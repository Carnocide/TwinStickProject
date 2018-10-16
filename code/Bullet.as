package code {

	import flash.display.MovieClip;

	/**
	* The class for projectiles
	*/
	public class Bullet extends MovieClip {

		/** the magnitude of the vector px/s */
		private const SPEED: Number = 240;
		/** The x-velocity in px/s. */
		private var velocityX: Number = 0;
		/** The y-velocity in px/s. */
		private var velocityY: Number = 0;
		/** The variable to determine whether or not to deconstruct the bullet */
		public var isDead: Boolean = false;
		/** The radius used for collision detection */
		public var radius: Number = 3;
		/** boolean for telling if the bullet was shot from the player with the big bullet powerup */
		public var isBig = false;

		//var velocity:Point = new Point();

		/**
		* The bullet constructor
		* determines its angle
		* determines its x and y components
		* applies modifiers
		* @params Player p The player object
		* @params MovieClip s The enemy movieclip object
		* @params Number angleAmount optional Supplied when calling from player with multishot
		*/
		public function Bullet(p: Player, s: MovieClip = null, angleAmount: Number = 3000) { // 3000 is some arbitrary number

			var angle: Number
			if (s) { // enemy bullet:
				try {

					var pos = s.getGlobalPos();
					this.x = pos.x;
					this.y = pos.y;

					if (pos.y > s.stage.stageHeight / 2) this.velocityY = -SPEED
					else this.velocityY = SPEED;


				} catch (e: Error) {
					x = s.x;
					y = s.y;

					var tx: Number = p.x - s.x;
					var ty: Number = p.y - s.y;

					angle = Math.atan2(ty, tx);
					angle += (Math.random() * 20 + Math.random() * -20) * Math.PI / 180;

					velocityX = SPEED * Math.cos(angle);
					velocityY = SPEED * Math.sin(angle);
				}

			} else { // player bullet:

				x = p.x;
				y = p.y;

				if (angleAmount != 3000) angle = angleAmount;
				else angle = (p.turret.rotation - 90) * Math.PI / 180;



				velocityX = SPEED * Math.cos(angle);
				velocityY = SPEED * Math.sin(angle);

				if (p.bigBulletPowerUp) {
					trace("big bullet");
					velocityX *= 1.4;
					velocityY *= 1.4;
					radius *= 4;
					this.scaleX = 4;
					this.scaleY = 4;
					this.isBig = true;
				}
				if (p.fastBulletPowerupCount > 0) {
					velocityX *= 2;
					velocityY *= 2;
				}
			}


			this.rotation = angle * 180 / Math.PI + 90;
		}

		/**
		* The update function for bullets
		* moves the bullet according to its velocities
		* Kills it if off the screen
		*/
		public function update(): void {

			x += velocityX * Time.dtScaled;
			y += velocityY * Time.dtScaled;
			if (y > stage.stageHeight + 100 || y < -100) {
				isDead = true;
			}
			if (x > stage.stageWidth + 100 || x < -100) {
				isDead = true;
			}
		}

	} // ends class
} // ends package