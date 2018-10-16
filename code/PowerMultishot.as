package code {
	
	import flash.display.MovieClip;
	
	/**
	* This powerup makes 3 bullets shoot instead of 1
	*/
	public class PowerMultishot extends Power {
		/** overriden from base class
		* Gives a string of the powerup type
		* @returns String "Multishot"
		*/
		override public function powerupType():String {
			return "Multishot" 
		}	
		
		/**
		* Boolean value for the health of the powerup if false, is alive
		*/
		public var isDead:Boolean = false;
		/** overrides from base class
		* Gives a boolean of the powerupLife
		* @returns Boolean isDead
		*/
		override public function isPowerupDead():Boolean {
			return isDead;
		}
		
		/**
		* Gives the radius of the powerup
		* @returns Number 13
		*/
		override public function radius():Number{
			return 13;
		}
		/**
		* Constructor.
		* Sets a random x and y position based on stage size
		*/
		public function PowerMultishot() {
			this.x = Math.random() * 1280;
			this.y = Math.random() * 720;
		}
	}
	
}
