package code {
	import flash.display.MovieClip;

	public class Enemy extends MovieClip {

		public function Enemy() {



		}
		public function getWeapon(): Boolean {
			return false;
		}
		
		public function getEnemyType():String {
			return "base";
		}

	}

}