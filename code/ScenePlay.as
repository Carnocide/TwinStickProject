package code {
	import flash.events.MouseEvent;

	public class ScenePlay extends GameScene {

		var player: Player;


		/** This array should only hold Snow objects. */
		var snowflakes: Array = new Array();
		/** The number seconds to wait before spawning the next Snow object. */
		var delaySpawn: Number = 0;

		/** This array holds only Bullet objects. */
		var bullets: Array = new Array();

		/** This array holds only the enemies' bullets. */
		var bulletsBad: Array = new Array();

		/** The amount of time left (in seconds) that the slowmo powerup is active. */
		var powerupSlowmoTimer: Number = 0;
		
		/** Boolean to check if the game is over (if the player died) */
		var isGameOver = false;
		
		/** collection of all currently spawned powerups */
		var powerups: Array = new Array();

		/** Number of seconds until a powerup spawns */
		var powerupsDelay:Number = 0;
		/** The scenes constructor. Creates a player object and places them near the center of the stage */
		public function ScenePlay() {

			player = new Player();
			addChild(player);
			player.x = 600
			player.y = 350;

		}
		/** Runs when the scene is first opened, adds the mouse event listener */
		override public function onBegin(): void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}
		/** Runs when the scene finishes, iterates through all the objects and sets them to is dead
		* Should, one the first update of a game reset, remove them from the scene
		*/
		override public function onEnd(): void {
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);
			
			removeChild(player);
			
			for (var i:int = 0; i < snowflakes.length; i++) {
				snowflakes[i].isDead = true;
			}
			for (var i:int = 0; i < bullets.length; i++) {
				bullets[i].isDead = true;
			}
			for (var i:int = 0; i < bulletsBad.length; i++) {
				bulletsBad[i].isDead = true;
			}
			
		}


		/** The scene's update loop, essentially acts as the core game loop when in the scene */
		override public function update(): GameScene {
			if (isGameOver) return new SceneLose();
			
			Time.update();


			if (powerupSlowmoTimer > 0) {

				Time.scale = .5;
				powerupSlowmoTimer -= Time.dt;

			} else {
				Time.scale = 1;
			}
			
			spawnPowerup();

			spawnSnow();

			player.update();

			updateSnow();

			updateBullets();
			
			updatePowerups();

			collisionDetection();

			return null;
		}
		/** Is run when the mouse is clicked, spawns bullets from the player */
		private function handleClick(e: MouseEvent): void {
			spawnBullet();
			
			if(player.bigBulletPowerUp) player.bigBulletPowerUp = false;
		}
		/** Spawns a bullet object from a player or from the enemy */
		public function spawnBullet(s: Snow = null): void {

			var b: Bullet = new Bullet(player, s);
			addChild(b);
			if (s) bulletsBad.push(b);
			else bullets.push(b);
		}

		/**
		 * Decrements the countdown timer, when it hits 0, it spawns a snowflake.
		 */
		private function spawnSnow(): void {
			// spawn snow:
			delaySpawn -= Time.dtScaled;
			if (delaySpawn <= 0) {
				var s: Snow = new Snow();
				addChild(s);
				snowflakes.push(s);
				delaySpawn = (int)(Math.random() * 2 + .5);
			}
		}
		
		/**
		 * Decrements the countdown timer, when it hits 0, it spawns a snowflake.
		 */
		private function spawnPowerup(): void {
			// spawn powerup:
			powerupsDelay -= Time.dtScaled;
			if (powerupsDelay <= 0) {
				var p: PowerBigBullet = new PowerBigBullet();
				addChild(p);
				powerups.push(p);
				powerupsDelay = (int)(Math.random() * 10 + 10); // from 10 to 20
			}
		}
		
		/** iterates through the snowflakes collection and updates each snowflake */
		private function updateSnow(): void {
			// update everything:
			for (var i = snowflakes.length - 1; i >= 0; i--) {
				snowflakes[i].update(this);
				if (snowflakes[i].isDead) {
					// remove it!!

					// 1. remove any event-listeners on the object
					snowflakes[i].dispose();

					// 2. remove the object from the scene-graph
					removeChild(snowflakes[i]);

					// 3. nullify any variables pointing to it
					// if the variable is an array,
					// remove the object from the array
					snowflakes.splice(i, 1);
				}
			} // for loop updating snow
		}
		
		/** iterates through the bullets collection and the bulletsBad collection */
		private function updateBullets(): void {
			// update everything:
			for (var i = bullets.length - 1; i >= 0; i--) {
				bullets[i].update();
				if (bullets[i].isDead) {
					// remove it!!

					// 1. remove any event-listeners on the object

					// 2. remove the object from the scene-graph
					removeChild(bullets[i]);

					// 3. nullify any variables pointing to it
					// if the variable is an array,
					// remove the object from the array
					bullets.splice(i, 1);
				}
			} // for loop updating bullets


			for (var i = bulletsBad.length - 1; i >= 0; i--) {
				bulletsBad[i].update();
				if (bulletsBad[i].isDead) {
					removeChild(bulletsBad[i]);
					bulletsBad.splice(i, 1);
				}
			} // for loop updating bullets			

		}
		
		private function updatePowerups(): void {
			for (var i:int = 0; i < powerups.length; i++) {
				var result = powerups[i].isPowerupDead()
				if(result) {
					removeChild(powerups[i]);
					powerups.splice(i, 1);
				}
			}
		}
		
		
		/**
		* Checks for all types of collision
		*/
		private function collisionDetection(): void {
			//enemies and our bullets
			for (var i: int = 0; i < snowflakes.length; i++) {
				for (var j: int = 0; j < bullets.length; j++) {

					var dx: Number = snowflakes[i].x - bullets[j].x;
					var dy: Number = snowflakes[i].y - bullets[j].y;
					var dis: Number = Math.sqrt(dx * dx + dy * dy);
					if (dis < snowflakes[i].radius + bullets[j].radius) {
						// collision!
						snowflakes[i].isDead = true;
						if (!bullets[j].isBig) bullets[j].isDead = true;


						powerupSlowmoTimer = 2;

					}
				}
			}
			// us and enemy bullets
			for (var i: int = 0; i < bulletsBad.length; i++) {
				var dx: Number = bulletsBad[i].x - player.x;
				var dy: Number = bulletsBad[i].y - player.y;
				var dis: Number = Math.sqrt(dx * dx + dy * dy);
				
				if (dis < player.radius + bulletsBad[i].radius) {
					// collision!

					//isGameOver = true;
					

				}
			}
			//powerups and our bullets
			for (var i: int = 0; i < bullets.length; i++) {
				for (var j: int = 0; j < powerups.length; j++) {
					var dx: Number = powerups[j].x - bullets[i].x;
					var dy: Number = powerups[j].y - bullets[i].y;
					var dis: Number = Math.sqrt(dx * dx + dy * dy);
					var powerupRadius = powerups[j].radius();
					if (dis < powerupRadius + bullets[i].radius) {
						if (!bullets[i].isBig) bullets[i].isDead = true;
						powerups[j].isDead = true;
						trace("supposed to be dead");
						var result = powerups[j].powerupType();
						if (result = "Big Bullet") player.bigBulletPowerUp = true;
					}
				}
			}
			
		}

	}

}