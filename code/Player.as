﻿package code {
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	
	
	public class Player extends MovieClip {
		
		var radius = 16;
		
		var bigBulletPowerUp = false;
		var multishotPowerupCount:int = 0;
		var fastBulletPowerupCount:int = 0;
		
		private var dirAngle:Number = 0;
		private var dirSpeed:Number = 0;
		public function Player() {
			
			var myColorTransform = new ColorTransform();			
			myColorTransform.color = 0xDDF2800
			
			turret.transform.colorTransform = myColorTransform
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
			
			if (x < -10) x = -10
			if (x > this.stage.stageWidth + 10) x = this.stage.stageWidth + 10;
			if (y < -10) y = -10;
			if (y > this.stage.stageHeight + 10) y = this.stage.stageHeight+ 10;
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
