package code {
	import flash.events.MouseEvent;
	
	public class SceneTitle extends GameScene {
		
		
		private var shouldSwitchToPlay:Boolean = false;
		
		override public function update():GameScene {
			if(KeyboardInput.keyEnter) return new ScenePlay();
			if(shouldSwitchToPlay) return new ScenePlay();
			
			return null;
		}
		override public function onBegin():void {
			this.x = this.stage.stageWidth/2;
			this.y = this.stage.stageHeight/2;
			bttnPlay.addEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
		}
		override public function onEnd():void {
			bttnPlay.removeEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay);
		}
		
		private function handleClickPlay(e:MouseEvent):void {
			trace("handleClickPlay");
			shouldSwitchToPlay = true;
		}
		
	}
	
}
