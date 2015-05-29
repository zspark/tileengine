package z_spark.tileengine.primitive
{
	import flash.display.Sprite;
	
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.tile.ITile;

	public class Entity implements IElement
	{
		private var _centerPtc:CaculateCompnent
		private var _w:int=2;
		private var _h:int=2;
		
		private var _obj:Sprite;
		
		public function get obj():Sprite
		{
			return _obj;
		}
		
		public function set obj(value:Sprite):void
		{
			_obj = value;
		}
		
		public function Entity()
		{
			_centerPtc=new CaculateCompnent();
		}
		
		public function get w():int
		{
			return _w;
		}

		public function set w(value:int):void
		{
			_w = value;
		}

		public function get h():int
		{
			return _h;
		}

		public function set h(value:int):void
		{
			_h = value;
		}

		public function get acceleration():Vector2D
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function set acceleration(value:Vector2D):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function addStatus(stat:uint):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function get futurePosition():Vector2D
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function get lastPosition():Vector2D
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function get position():Vector2D
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function set position(value:Vector2D):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function removeStatus(stat:uint):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function setPosition(x:Number, y:Number):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function setVelocity(x:Number, y:Number):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function setacceleration(x:Number, y:Number):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function get status():uint
		{
			// TODO Auto Generated method stub
			return 0;
		}
		
		public function get velocity():Vector2D
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function set velocity(value:Vector2D):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function frameEndCall(tile:ITile,handleStatus:int):void
		{
			if(_obj){
				_obj.x=_centerPtc.position.x+_w*.5;
				_obj.y=_centerPtc.position.y+_h*.5;
			}
		}
		
	}
}