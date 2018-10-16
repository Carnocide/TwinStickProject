package code {
	import flash.events.KeyboardEvent;
	import flash.display.Stage;

	/** 
	 * The class that handles all input through a keyboard
	 */
	public class KeyboardInput {

		/** the left key is pressed */
		static public var keyLeft: Boolean = false;
		/** the up key is pressed */
		static public var keyUp: Boolean = false
		/** the right key is pressed */
		static public var keyRight: Boolean = false;
		/** the down key is pressed */
		static public var keyDown: Boolean = false;
		/** the enter key is pressed */
		static public var keyEnter: Boolean = false;

		/**
		 * Adds event listeners for keydown and key up
		 */
		static public function setup(stage: Stage) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}
		/** 
		 *
		 * updates the state of the key
		 * @params int keyCode The keycode of the key pressed
		 * @params boolean isDown the boolean if the key is pressed
		 */
		static private function updateKey(keyCode: int, isDown: Boolean): void {

			if (keyCode == 13) keyEnter = isDown;
			if (keyCode == 65) keyLeft = isDown;
			if (keyCode == 87) keyUp = isDown;
			if (keyCode == 68) keyRight = isDown;
			if (keyCode == 83) keyDown = isDown;
		}
		/** calls updateKey with true */
		static private function handleKeyDown(e: KeyboardEvent): void {
			//trace(e.keyCode);
			updateKey(e.keyCode, true);
		}
		/** calls updateKey with false */
		static private function handleKeyUp(e: KeyboardEvent): void {

			updateKey(e.keyCode, false);
		}


	}

}