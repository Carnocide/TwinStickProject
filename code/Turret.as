package code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	
	public class Turret extends MovieClip {
		
		
		public function Turret() {
			// constructor code
		}
		
		public function getGlobalPos():Point {
			return this.parent.localToGlobal(new Point(this.x, this.y));
		}
	}
	
}
