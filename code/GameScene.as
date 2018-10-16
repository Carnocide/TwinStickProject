package code {
	import flash.display.MovieClip;

	/**
	 * This class is an ABSTRACT class for our
	 * GameScene FSM. All game scenes are child classes
	 * of this class.
	 */
	public class GameScene extends MovieClip {

		/**
		 * Each game scene should OVERRIDE this method
		 * and add specific implementation.
		 */
		public function update(): GameScene {
			trace("tick");
			return null;
		}

		/** overriden
		 * runs when the scene starts
		 */
		public function onBegin(): void {

		}
		/** overriden
		 * runs when the scene ends
		 */
		public function onEnd(): void {

		}

	}
}