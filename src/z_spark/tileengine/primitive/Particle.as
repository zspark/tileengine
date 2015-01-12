package z_spark.tileengine.primitive
{
	import flash.display.Sprite;
	
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.ElementStatus;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.tile.ITile;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 粒子； 
	 * @author z_Spark
	 * 
	 */
	public class Particle implements IElement
	{
		private var _acceleration:Vector2D;
		private var _velocity:Vector2D;
		private var _position:Vector2D;
		private var _obj:Sprite;

		public function get obj():Sprite
		{
			return _obj;
		}
		
		public function set obj(value:Sprite):void
		{
			_obj = value;
		}
		
		public function Particle()
		{
			_velocity=new Vector2D();
			_position=new Vector2D();
			_acceleration=new Vector2D();
		}
		
		public function get acceleration():Vector2D
		{
			return _acceleration;
		}
		
		public function set acceleration(value:Vector2D):void
		{
			_acceleration.reset(value);
		}

		public function get velocity():Vector2D
		{
			return _velocity;
		}
		
		public function setacceleration(x:Number,y:Number):void
		{
			_acceleration.resetComponent(x,y);
		}
		
		public function set velocity(value:Vector2D):void 
		{
			_velocity.reset(value);
		}
		
		public function setVelocity(x:Number,y:Number):void 
		{
			_velocity.resetComponent(x,y);
		}
		
		public function get position():Vector2D
		{
			return _position;
		}
		
		public function set position(value:Vector2D):void
		{
			_position.reset(value);
		}
		
		public function setPosition(x:Number,y:Number):void
		{
			_position.resetComponent(x,y);
		}
		
		public function get lastPosition():Vector2D{
			return new Vector2D(_position.x-_velocity.x,_position.y-_velocity.y);
		}
		
		public function get futurePosition():Vector2D{
			return new Vector2D(_position.x+_velocity.x,_position.y+_velocity.y);
		}
		
		public function frameEndCall(tile:ITile,handleStatus:int):void
		{
			if(_obj){
				_obj.x=_position.x;
				_obj.y=_position.y;
			}
		}
		
		CONFIG::DEBUG{
			private var _posHistoryCache:Array=[];
			public function addToHistory():void{
				_posHistoryCache.push(_position.clone());
			}
		};
		
		private var _status:uint=ElementStatus.STAY;
		public function get status():uint
		{
			return _status;
		}
		
		public function addStatus(stat:uint):void{
			_status|=stat;
		}
		
		public function removeStatus(stat:uint):void{
			_status&=~stat;
		}
		
		public function statusExist(stat:uint):Boolean{
			return (_status & stat)==stat;
		}
		
	}
}