package code {
	
	import flash.display.MovieClip;
	
	/**
	 * This class is an ABSTRACT class for 
	 * Powerups
	 */
	public class Power extends MovieClip {
		
		//TODO: ? Add universal powerup properties
		
		/** ABSTRACT
		* Holds a value of the powerup radius
		*/
		public function radius():Number {
			return 0;
		}
		
		/** ABSTRACT
		* Holds a value of the powerup type
		*/
		public function powerupType():String {
			return "";
		}
		
		/** ABSTRACT
		* Holds a value to determine if the powerup has been deaded
		*/
		public function isPowerupDead():Boolean {
			return false;
		}
	}
	
}
