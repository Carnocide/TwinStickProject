package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	/**
	 * This is the controller class for the entire Game.
	 */
	public class Game extends MovieClip {

		
		/**
		* This stores the current scene using a FSM.
		*/
		private var gameScene:GameScene;
		/**
		 * This is where we setup the game.
		 */
		public function Game() {
			
			KeyboardInput.setup(stage);

			switchScene(new SceneTitle())
			
			addEventListener(Event.ENTER_FRAME, gameLoop);
			
			
		}
		/**
		 * This event-handler is called every time a new frame is drawn.
		 * It's our game loop!
		 * @param e The Event that triggered this event-handler.
		 */
		private function gameLoop(e:Event):void {
			
			if(gameScene) switchScene(gameScene.update());

			
		} // function gameLoop
		
		private function switchScene(newScene:GameScene):void {
			if(newScene){
				//switch scenes...
				if(gameScene) gameScene.onEnd();
				if(gameScene) removeChild(gameScene);					
				gameScene = newScene;
				addChild(gameScene);
				gameScene.onBegin();
			}
		}
		

		
	} // class Game
} // package
