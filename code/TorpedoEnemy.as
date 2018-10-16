package code {

	import flash.display.MovieClip

	import flash.events.MouseEvent;

	public class TorpedoEnemy extends Enemy {

		private var angleToPlayer: Number;

		private var speed: Number;
		private var velocityX: Number;
		private var velocityY: Number;

		/** If this is true, the object is queued up to be destroyed!! */
		public var isDead: Boolean = false;

		public var radius: Number = 51;

		// constructor code
		public override function getEnemyType(): String {
			return "Torpedo Enemy";
		}


		public function TorpedoEnemy(gameScene: ScenePlay) {

			var leftRight = Math.random()
			y = Math.random() * 720
			if (leftRight > 0.5) {
				x = -70;
			} else {
				x = 1350;
			}
			speed = 300; // px/s
			var dx: Number = gameScene.player.x - x;
			var dy: Number = gameScene.player.y - y;
			angleToPlayer = Math.atan2(dy, dx);

			velocityY = speed * Math.sin(angleToPlayer);
			velocityX = speed * Math.cos(angleToPlayer);

			this.rotation = (angleToPlayer * 180 / Math.PI) + 90;

			// 2 to 5?wwwwwwwwww
			//radius *= scaleX;

			//addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}


		public function update(gameScene: ScenePlay): void {




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
		private function handleClick(e: MouseEvent): void {
			isDead = true;
		}

		public function dispose(): void {
			//removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		}
	}

}