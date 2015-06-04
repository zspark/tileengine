package z_spark.tileengine
{
	import z_spark.linearalgebra.Vector2D;

	public class Particle
	{
		public static const AMBIGUOUS:String="ambiguous";
		public static const ABSOLUTE:String="absolute";
		public static const NO_CHECK:String="none_check";
		
		private var _acceleration:Vector2D;
		private var _velocity:Vector2D;
		private var _position:Vector2D;
		private var _status:String=NO_CHECK;
		/**
		 * 粒子不受重力的影响
		 * 亦即粒子没有重力的概念； 
		 * 
		 */
		public function Particle()
		{
			_velocity=new Vector2D();
			_position=new Vector2D();
			_acceleration=new Vector2D();
		}
		
		public function get status():String
		{
			return _status;
		}

		public function set status(value:String):void
		{
			_status = value;
		}

		public function get acceleration():Vector2D
		{
			return _acceleration;
		}
		
		public function set acceleration(value:Vector2D):void
		{
			_acceleration.reset(value);
		}
		
		public function setacceleration(x:Number,y:Number):void
		{
			_acceleration.resetComponent(x,y);
		}
		
		public function accelerationShare(value:Vector2D):void{
			_acceleration=value;
		}
		
		/**
		 * 单位：像素每秒（pps）；
		 * @return 
		 * 
		 */
		public function get velocity():Vector2D
		{
			return _velocity;
		}
		
		public function set velocity(value:Vector2D):void 
		{
			_velocity.reset(value);
		}
		
		public function velocityShare(value:Vector2D):void{
			_velocity=value;
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
	}
}