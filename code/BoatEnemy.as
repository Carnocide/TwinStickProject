package code {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import fl.motion.Color;

	/**
	*	Child of the Enemy Class
	* Boat enemy is the enemy that chases you and shoots
	*/
	public class BoatEnemy extends code.Enemy {
		/** The number of px/s the enemy moves along its vector */
		private var speed: Number;
		/** The number of px/s in the x direction */
		private var velocityX: Number;
		/** The number of px/s in the y direction */
		private var velocityY: Number;

		/** If this is true, the object is queued up to be destroyed!! */
		public var isDead: Boolean = false;

		//** The number of px from the center of the object used for radial collision detection */
		public var radius: Number = 51;

		/** The amount of time (in seconds) to wait before spawning the next bullet. */
		private var spawnDelay: Number = 0;

		/** This function returns a boolean on whether this enemy shoots bullets*/
		/** @returns Boolean true */
		public override function getWeapon(): Boolean {
			return true;
		}
		/** This function returns a string with the enemytype name*/
		/** @returns String "Boat Enemy" */
		public override function getEnemyType(): String {
			return "Boat Enemy";
		}
		
		/** The constructor
		* determines the spawn point the horizontal position, then either top or bottom
		* also sets this enemy's speed
		*/
		public function BoatEnemy() {

			var topBot = Math.random()
			x = Math.random() * 1280;
			if (topBot > 0.5) {
				y = 720;
			} else {
				y = -50;
			}


			speed = Math.random() * 75 + 50; // 2 to 5?
			//scaleX = Math.random() * .2 + .1; // .1 to .3
			//scaleY = scaleX;
			//radius *= scaleX;

		}

		/** The update loop of the BoatEnemy
		* Runs every Game update
		* Moves the enemy closer to the player
		* if the boat is done reloading, shoots again
		* kills the enemy if it goes off screen
		* @params gameScene:ScenePlay Is the core game play scene
		*/
		public function update(gameScene: ScenePlay): void {


			if (spawnDelay > 0) {
				spawnDelay -= Time.dtScaled;
			} else {
				gameScene.spawnBullet(this);
				spawnDelay = Math.random() * 1.5 + .5;
			}

			var dx: Number = gameScene.player.x - x;
			var dy: Number = gameScene.player.y - y;
			var angleToPlayer: Number = Math.atan2(dy, dx);

			velocityY = speed * Math.sin(angleToPlayer);
			velocityX = speed * Math.cos(angleToPlayer);

			this.rotation = (angleToPlayer * 180 / Math.PI) + 90;


			// fall
			x += velocityX * Time.dtScaled;
			y += velocityY * Time.dtScaled;
			if (y > stage.stageHeight + 100 || y < -100) {
				isDead = true;
			}
			if (x > stage.stageWidth + 100 || x < -100) {
				isDead = true;
			}
		}
		/**
		 * This function's job is to prepare the object for removal.
		 * In this case, we need to remove any event-listeners on this object.
		 */
		public function dispose(): void {
			//removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}
	}

}