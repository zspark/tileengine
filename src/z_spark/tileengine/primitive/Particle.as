package z_spark.tileengine.primitive
{
	import flash.display.Sprite;
	
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.tile.ITile;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 格子世界物体模型； 
	 * @author z_Spark
	 * 
	 */
	public class Particle
	{
		private static const MIN_SPD:Number=0.5;
		private static const MAX_SLEEPING_COUNT:int=30;
		private var _acceleration:Vector2D;
		private var _velocity:Vector2D;
		private var _position:Vector2D;
		private var _damping:Number=1;
		private var _inverseMass:Number=1.0;
		private var _forceAccum:Vector2D;
		private var _obj:Sprite;

		public function get mass():Number
		{
			if(_inverseMass==0)return Number.MAX_VALUE;
			else return 1.0/_inverseMass;
		}

		public function set mass(value:Number):void
		{
			_inverseMass=1.0/value;
		}

		public function get inverseMass():Number
		{
			return _inverseMass;
		}

		public function set inverseMass(value:Number):void
		{
			_inverseMass = value;
		}

		public function get damping():Number
		{
			return _damping;
		}

		public function set damping(value:Number):void
		{
			_damping = value;
		}
		
		public function get hasFiniteMass():Boolean{
			//TODO:hwo to understand;
			return _inverseMass>=0.0;
		}

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
		
		public function clearAccumulator():void{
			_forceAccum.clear();
		}
		
		public function get lastPosVector():Vector2D{
			return new Vector2D(_position.x-_velocity.x,_position.y-_velocity.y);
		}
		
		public function addForce(value:Vector2D):void{
			_forceAccum.add(value);
		}
		
		zspark_tileegine_internal function integrate(duration:Number=0.0):void{
			if(_inverseMass<=0.0)return;
			_position.addScale(_velocity,duration);
			var acc:Vector2D=_acceleration.clone();
			acc.addScale(_forceAccum,_inverseMass);
			_velocity.addScale(acc,duration);
			_velocity.mul(Number.pow(_damping,duration));
			_forceAccum.clear();
		}
		
		zspark_tileegine_internal function frameEndCall(tile:ITile,handleStatus:int):void
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
	}
}