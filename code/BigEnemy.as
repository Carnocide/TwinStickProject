package code {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;


	public class BigEnemy extends Enemy {

		private var speed: Number;
		private var velocityX: Number;
		private var velocityY: Number;



		/** If this is true, the object is queued up to be destroyed!! */
		public var isDead: Boolean = false;

		public var radius: Number = 51;

		/** The amount of time (in seconds) to wait before spawning the next bullet. */
		private var spawnDelay: Number = 0;

		public override function getWeapon(): Boolean {
			return true;
		}

		public override function getEnemyType(): String {
			return "Big Enemy";
		}

		public function BigEnemy() {

			var topBot = Math.random();
			var leftRight = Math.random();
			if (leftRight > 0.5) {
				this.x = 1280
				this.velocityX = -100
			} else {
				this.x = 0;
				this.velocityX = 100;
			}
			if (topBot > 0.5) {
				this.y = 675;
			} else {
				this.y = 45;
				this.rotation = 180
			}

			// 2 to 5?
			//scaleX = Math.random() * .2 + .1; // .1 to .3
			//scaleY = scaleX;
			//radius *= scaleX;

			//addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}


		public function update(gameScene: ScenePlay): void {

			if (spawnDelay > 0) {
				spawnDelay -= Time.dtScaled;
			} else {
				gameScene.spawnBullet(this.turretFront);
				gameScene.spawnBullet(this.turretCenter);
				gameScene.spawnBullet(this.turretBack);
				spawnDelay = 1;
			}

			var dx: Number = gameScene.player.x - x;
			var dy: Number = gameScene.player.y - y;
			var angleToPlayer: Number = Math.atan2(dy, dx);




			// fall
			x += velocityX * Time.dtScaled;
			if (y > stage.stageHeight + 100 || y < -100) {
				isDead = true;
			}
			if (x > stage.stageWidth + 100 || x < -100) {
				isDead = true;
			}
		}
		private function handleClick(e: MouseEvent): void {
			isDead = true;
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