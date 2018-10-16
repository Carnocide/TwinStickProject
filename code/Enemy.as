package code {
	import flash.display.MovieClip;
	/**
	* The Base enemy Class
	* Is the parent class for bigenemy, torpedo, and boatenemy
	*/
	public class Enemy extends MovieClip {

		/** Gets overridden, returns if the enemy shoots bullets or not */
		public function getWeapon(): Boolean {
			return false;
		}
		
		/**  Gets overridden, returns a string with the name of the enemytype */
		public function getEnemyType():String {
			return "base";
		}

	}

}