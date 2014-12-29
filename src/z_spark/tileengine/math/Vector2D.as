package z_spark.tileengine.math
{
	
	final public class Vector2D
	{
		private var _x:Number;
		private var _y:Number;		
		
		public function clone():Vector2D{
			return new Vector2D(_x,_y);
		}
		
		public function Vector2D(xx:Number=0,yy:Number=0)
		{
			_x=xx;
			_y=yy;
		}
		
		public function reset(vct:Vector2D):void{
			_x=vct.x;
			_y=vct.y;
		}
		
		public function resetComponent(xx:Number,yy:Number):void{
			_x=xx;
			_y=yy;
		}
		
		public function resetComponentScale(xx:Number,yy:Number,scale:Number):void{
			_x=xx*scale;
			_y=yy*scale;
		}
		
		public function resetScale(vct:Vector2D,scale:Number):void{
			_x=vct.x*scale;
			_y=vct.y*scale;
		}
		
		public function add(vct:Vector2D):void{
			_x+=vct.x;
			_y+=vct.y;
		}
		
		public function addScale(vct:Vector2D,scale:Number):void{
			_x+=vct.x*scale;
			_y+=vct.y*scale;
		}
		
		public function addComponent(x:Number,y:Number):void{
			_x+=x;
			_y+=y;
		}
		
		public function addComponentScale(x:Number,y:Number,scale:Number):void{
			_x+=x*scale;
			_y+=y*scale;
		}
		
		public function sub(vct:Vector2D):void{
			_x-=vct.x;
			_y-=vct.y;
		}
		
		public function subComponent(x:Number,y:Number):void{
			_x-=x;
			_y-=y;
		}
		
		
		public function mul(value:Number):void{
			_x*=value;
			_y*=value;
		}
		
		public function normalize():void{
			var m:Number=mag;
			_x/=m;
			_y/=m;
		}
		
		public function get mag():Number{
			return Math.sqrt(_x*_x+_y*_y);
		}
		
		public function get magSqare():Number{
			return _x*_x+_y*_y;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}
		
		public function toString():String{
			return "[x,y]=["+x+","+y+"]";
		}

	}
}