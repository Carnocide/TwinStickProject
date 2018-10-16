package code {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	public class ScenePlay extends GameScene {

		var player: Player;
		var score: Number = 0;

		/** This array should only hold Snow objects. */
		var enemies: Array = new Array();
		/** The number seconds to wait before spawning the next Snow object. */
		var boatDelaySpawn: Number = 3;

		var torpedoDelaySpawn: Number = 0;

		var bigDelaySpawn: Number = 3;
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
		var powerupsDelay: Number = 0;
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
			Time.update();
		}
		/** Runs when the scene finishes, iterates through all the objects and sets them to is dead
		 * Should, one the first update of a game reset, remove them from the scene
		 */
		override public function onEnd(): void {
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);

			removeChild(player);

			for (var s: int = 0; s < enemies.length; s++) {
				enemies[s].isDead = true;
			}
			for (var b: int = 0; b < bullets.length; b++) {
				bullets[b].isDead = true;
			}
			for (var a: int = 0; a < bulletsBad.length; a++) {
				bulletsBad[a].isDead = true;
			}

		}


		/** The scene's update loop, essentially acts as the core game loop when in the scene */
		override public function update(): GameScene {
			if (isGameOver) {
				trace("score in lose = " + score);
				return new SceneLose(score);
			}

			Time.update();


			if (powerupSlowmoTimer > 0) {

				Time.scale = .5;
				powerupSlowmoTimer -= Time.dt;

			} else {
				Time.scale = 1;
			}

			spawnPowerup();
			spawnBoatEnemies();

			spawnTorpedoEnemies();

			spawnBigEnemies();


			player.update();

			updateEnemies();

			updateBullets();

			updatePowerups();

			collisionDetection();

			return null;
		}
		/** Is run when the mouse is clicked, spawns bullets from the player */
		private function handleClick(e: MouseEvent): void {
			spawnBullet();

			if (player.bigBulletPowerUp) player.bigBulletPowerUp = false;
			if (player.fastBulletPowerupCount > 0) player.fastBulletPowerupCount--;
			if (player.multishotPowerupCount > 0) player.multishotPowerupCount--;
		}
		/** Spawns a bullet object from a player or from the enemy */
		public function spawnBullet(s: MovieClip = null): void {



			var b: Bullet = new Bullet(player, s);
			addChild(b);

			if (player.multishotPowerupCount > 0 && s == null) {

				var newBullet1: Bullet = new Bullet(player, null, (((player.turret.rotation - 90) * Math.PI / 180) + .2));
				var newBullet2: Bullet = new Bullet(player, null, (((player.turret.rotation - 90) * Math.PI / 180) - .2));
				addChild(newBullet1);
				addChild(newBullet2);
				bullets.push(newBullet1);
				bullets.push(newBullet2);

			}

			if (s) bulletsBad.push(b);
			else bullets.push(b);

		}

		/**
		 * Decrements the countdown timer, when it hits 0, it spawns a snowflake.
		 */
		private function spawnBoatEnemies(): void {
			// spawn snow:
			boatDelaySpawn -= Time.dtScaled;
			if (boatDelaySpawn <= 0) {
				var s: BoatEnemy = new BoatEnemy();
				addChild(s);
				enemies.push(s);
				boatDelaySpawn = (int)(Math.random() * 2 + 1);
			}
		}

		private function spawnTorpedoEnemies(): void {
			// spawn snow:
			torpedoDelaySpawn -= Time.dtScaled;
			if (torpedoDelaySpawn <= 0) {
				var s: TorpedoEnemy = new TorpedoEnemy(this);
				addChild(s);
				enemies.push(s);
				torpedoDelaySpawn = 1;
			}
		}

		private function spawnBigEnemies(): void {
			// spawn snow:
			bigDelaySpawn -= Time.dtScaled;

			if (bigDelaySpawn <= 0) {
				var s: BigEnemy = new BigEnemy();
				addChild(s);
				enemies.push(s);
				bigDelaySpawn = 10;
			}
		}

		/**
		 * Decrements the countdown timer, when it hits 0, it spawns a snowflake.
		 */
		private function spawnPowerup(): void {
			// spawn powerup:
			powerupsDelay -= Time.dtScaled;
			var picker = Math.random();


			if (powerupsDelay <= 0) {
				var p: Power;
				if (picker <= .333) {
					p = new PowerMultishot();
				}
				if (picker > .333 && picker <= .666) {
					p = new PowerBigBullet();
				}
				if (picker > .666) {
					p = new PowerFastshot();
				}

				addChild(p);
				powerups.push(p);
				powerupsDelay = (int)(Math.random() * 3); // from 10 to 20
			}
		}

		/** iterates through the enemy collection and updates each enemy */
		private function updateEnemies(): void {
			// update everything:
			for (var i = enemies.length - 1; i >= 0; i--) {
				enemies[i].update(this);

				if (enemies[i].isDead) {
					// remove it!!
					// 1. remove any event-listeners on the object
					enemies[i].dispose();

					// 2. remove the object from the scene-graph
					removeChild(enemies[i]);

					// 3. nullify any variables pointing to it
					// if the variable is an array,
					// remove the object from the array
					enemies.splice(i, 1);
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


			for (var b = bulletsBad.length - 1; b >= 0; b--) {
				bulletsBad[b].update();
				if (bulletsBad[b].isDead) {
					removeChild(bulletsBad[b]);
					bulletsBad.splice(b, 1);
				}
			} // for loop updating bullets			

		}

		private function updatePowerups(): void {
			for (var i: int = 0; i < powerups.length; i++) {
				var result = powerups[i].isPowerupDead()
				if (result) {
					removeChild(powerups[i]);
					powerups.splice(i, 1);
				}
			}
		}


		/**
		 * Checks for all types of collision
		 */
		private function collisionDetection(): void {
			collisionEnemiesAndOurBullets();

			collisionUsAndEnemyBullets();

			collisionPowerupsAndOurBullets();
			collisionUsAndEnemies();


		} // end collisionDetection()

		private function collisionEnemiesAndOurBullets(): void {
			for (var i: int = 0; i < enemies.length; i++) {
				for (var j: int = 0; j < bullets.length; j++) {

					var dx: Number = enemies[i].x - bullets[j].x;
					var dy: Number = enemies[i].y - bullets[j].y;
					var dis: Number = Math.sqrt(dx * dx + dy * dy);
					if (dis < enemies[i].radius + bullets[j].radius) {
						// collision!
						enemies[i].isDead = true;
						if (!bullets[j].isBig) bullets[j].isDead = true;
						if (enemies[i].getEnemyType() == "Torpedo Enemy") score +=2;
						if (enemies[i].getEnemyType() == "Boat Enemy") score += 3;
						if (enemies[i].getEnemyType() == "Big Enemy") score += 6;


						//powerupSlowmoTimer = 2;

					}
				}
			}
		} // end collisionEnemiesAndOurBullets

		private function collisionUsAndEnemyBullets(): void {
			// us and enemy bullets
			for (var i: int = 0; i < bulletsBad.length; i++) {
				var dx: Number = bulletsBad[i].x - player.x;
				var dy: Number = bulletsBad[i].y - player.y;
				var dis: Number = Math.sqrt(dx * dx + dy * dy);

				if (dis < player.radius + bulletsBad[i].radius) {
					// collision!aaaaaaaaa
					trace("x of " + bulletsBad[i].x + " and y of " + bulletsBad[i].y)
					isGameOver = true;


				}
			}
		} // end collisionUsAndEnemyBullets

		private function collisionUsAndEnemies(): void {
			// us and enemy bullets
			for (var i: int = 0; i < enemies.length; i++) {
				var dx: Number = enemies[i].x - player.x;
				var dy: Number = enemies[i].y - player.y;
				var dis: Number = Math.sqrt(dx * dx + dy * dy);

				if (dis < player.radius + enemies[i].radius) {
					// collision!
					trace("Dead by ship");
					trace("x of " + enemies[i].x + " and y of " + enemies[i].y)
					trace(enemies[i].getEnemyType());
					isGameOver = true;


				}
			}
		} // end collisionUsAndTorpedoEnemies

		private function collisionPowerupsAndOurBullets(): void {
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
						var result = powerups[j].powerupType();
						if (result == "Big Bullet") player.bigBulletPowerUp = true;
						if (result == "Multishot") player.multishotPowerupCount += 10;
						if (result == "Fastshot") player.fastBulletPowerupCount += 10;
					}
				}
			}
		} // end collisionPowerupsAndOurBullets():void

	}

}