package code {
	
	import flash.display.MovieClip;
	
	
	public class Player extends MovieClip {
		
		var radius = 16;
		
		var bigBulletPowerUp = false;
		
		private var dirAngle:Number = 0;
		private var dirSpeed:Number = 0;
		public function Player() {
			// constructor code
		}
		
		public function update():void {
			
			var speed:Number = 180// 50 px/s

			if(KeyboardInput.keyLeft) dirAngle -= 90 * Time.dtScaled; // 90 degrees per second
			if(KeyboardInput.keyRight) dirAngle += 90 * Time.dtScaled; // 90 degrees per second
			if(KeyboardInput.keyUp) {
				dirSpeed = speed;
			}
			else if(KeyboardInput.keyDown){
				dirSpeed = -speed;
			}
			else {
				dirSpeed = 0;
			}
			
			
			var vx:Number = dirSpeed * Math.cos((dirAngle + 90)/180 * Math.PI);
			var vy:Number = dirSpeed * Math.sin((dirAngle + 90)/180 * Math.PI);
			
			x -= vx * Time.dtScaled;
			y -= vy * Time.dtScaled;
			
			
			trace(dirSpeed);
			
			var tx:Number = parent.mouseX - x;
			var ty:Number = parent.mouseY - y;
			var angle:Number = Math.atan2(ty, tx);
			angle *= 180 / Math.PI;
			
			turret.rotation = angle + 90;
			hull.rotation = dirAngle;
			// rotate player sprite
		}
	}
	
}
