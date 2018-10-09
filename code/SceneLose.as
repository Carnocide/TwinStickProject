package code {
	
	import flash.display.MovieClip;
	
	
	public class SceneLose extends GameScene {
		
		
		public function SceneLose() {
			// constructor code
		}
		override public function update():GameScene {
			trace("scenelose");
			if(KeyboardInput.keyEnter) return new SceneTitle();
			
			return null;
		}
	}
	
}
