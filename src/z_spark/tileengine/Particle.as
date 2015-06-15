package z_spark.tileengine
{
	import z_spark.linearalgebra.Vector2D;

	public class Particle
	{
		public static const AMBIGUOUS:String="ambiguous";
		public static const ABSOLUTE:String="absolute";
		public static const NO_CHECK:String="none_check";
		
		private var _acceleration:Vector2D;
		private var _speed:Vector2D;
		private var _position:Vector2D;
		private var _status:String=NO_CHECK;
		
		/**
		 * 粒子不受重力的影响
		 * 亦即粒子没有重力的概念； 
		 * 
		 */
		public function Particle(posX:Number=0.0,posY:Number=0.0)
		{
			_speed=new Vector2D();
			_position=new Vector2D(posX,posY);
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
		public function get speed():Vector2D
		{
			return _speed;
		}
		
		public function set speed(value:Vector2D):void 
		{
			_speed.reset(value);
		}
		
		public function speedShare(value:Vector2D):void{
			_speed=value;
		}
		
		public function setSpeed(x:Number,y:Number):void 
		{
			_speed.resetComponent(x,y);
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
		
		public function positionShare(value:Vector2D):void{
			_position=value;
		}
	}
}