package code {
	
	import flash.display.MovieClip;
	
	
	public class Bullet extends MovieClip {
		
		private const SPEED:Number = 240;
		
		private var velocityX:Number = 0;
		/** The y-velocity in px/s. */
		private var velocityY:Number = 0;
		
		public var isDead:Boolean = false;
		public var radius:Number = 3;
		public var isBig = false;
		
		//var velocity:Point = new Point();
		
		public function Bullet(p:Player, s:Snow = null) {
			
			
			if(s){ // enemy bullet:
				x = s.x;
				y = s.y;
				
					
				var tx:Number = p.x - s.x;
				var ty:Number = p.y - s.y;
				
				var angle:Number = Math.atan2(ty, tx);
				angle += (Math.random() * 20 + Math.random() * -20) * Math.PI / 180;
				
				velocityX = SPEED * Math.cos(angle);
				velocityY = SPEED * Math.sin(angle);
				
				
				
				
			} else { // player bullet:
				
				x = p.x;
				y = p.y;
				
				var angle:Number = (p.rotation - 90) * Math.PI / 180;
				
				velocityX = SPEED * Math.cos(angle);
				velocityY = SPEED * Math.sin(angle);
				
				if (p.bigBulletPowerUp) {
					trace("big bullet");
					velocityX *=2;
					velocityY *=2;
					radius *= 4;
					this.scaleX = 4;
					this.scaleY = 4;
					this.isBig = true;
				}
			}
			
			
			this.rotation = angle * 180 / Math.PI + 90;
		}
		
		public function update():void {
			
			x += velocityX * Time.dtScaled;
			y += velocityY * Time.dtScaled;
			
			if(!stage || y < -5 || x < -5 || x > stage.stageWidth + 5 || y > stage.stageHeight + 5) isDead = true;
		}
		
	} // ends class
} // ends package
