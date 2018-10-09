package code {
	
	import flash.display.MovieClip;
	
	/**
	* This powerup makes a bullet 4 times as large that does not die when colliding
	*/
	public class PowerBigBullet extends Power {
		/** overriden */
		override public function powerupType():String {
			return "Big Bullet" 
		}		
		public var isDead:Boolean = false;
		/** overriden */
		override public function isPowerupDead():Boolean {
			return isDead;
		}
		
		override public function radius():Number{
			return 30;
		}
		/**
		* Constructor.
		* Sets a random x and y position based on stage size
		*/
		public function PowerBigBullet() {
			this.x = Math.random() * 1280;
			this.y = Math.random() * 720;
		}
	}
	
}
