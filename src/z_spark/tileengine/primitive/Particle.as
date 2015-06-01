package z_spark.tileengine.primitive
{
	import z_spark.linearalgebra.Vector2D;

	public class Particle
	{
		private var _acceleration:Vector2D;
		private var _velocity:Vector2D;
		private var _position:Vector2D;
		public function Particle()
		{
			_velocity=new Vector2D();
			_position=new Vector2D();
			_acceleration=new Vector2D();
		}
		
		public function get futurePosition():Vector2D
		{
			return new Vector2D(_position.x+_velocity.x,_position.y+_velocity.y);
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
		
		public function get velocity():Vector2D
		{
			return _velocity;
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
	}
}