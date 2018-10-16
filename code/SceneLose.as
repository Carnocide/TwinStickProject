package code {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * The losing scene
	 */
	public class SceneLose extends GameScene {

		/** 
		 * Boolean for storing whether or not to switch scenes
		 */
		private var shouldSwitchToPlay: Boolean = false;
		/** 
		 * constructor code
		 * @params Number score the final score of the game
		 */
		public function SceneLose(score: Number) {
			trace("score in lose = " + score);
			this.scoreText.text = "Score: " + score;
		}
		/**
		 * Updates the losing scene
		 * checks for input to restart
		 */
		override public function update(): GameScene {
			if (KeyboardInput.keyEnter) return new ScenePlay();
			if (shouldSwitchToPlay) return new ScenePlay();


			return null;
		}

		/** 
		 * runs when entering the scene
		 */
		override public function onBegin(): void {
			this.x = this.stage.stageWidth / 2;
			this.y = this.stage.stageHeight / 2;
			bttnPlay.addEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);

		}
		/** 
		 * runs when leaving the scene
		 */
		override public function onEnd(): void {
			bttnPlay.removeEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
		}
		/**
		 * The function run when clicking the play button
		 * resets the game
		 */
		private function handleClickPlay(e: MouseEvent): void {
			trace("handleClickPlay");
			shouldSwitchToPlay = true;
		}
	}

}