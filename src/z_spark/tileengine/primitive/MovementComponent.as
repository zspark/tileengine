package z_spark.tileengine.primitive
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.zspark_tileegine_internal;
	
	use namespace zspark_tileegine_internal;
	public class MovementComponent
	{
		zspark_tileegine_internal var _particleVct:Vector.<Particle>;
		private var _velocity:Vector2D;
		private var _acceleration:Vector2D;
		
		public function MovementComponent()
		{
			_particleVct=new Vector.<Particle>();
			_velocity=new Vector2D();
			_acceleration=new Vector2D();
		}
		
		public function addParticle(ptc:Particle):void{
			ptc.velocity=_velocity;
			_particleVct.push(ptc);
		}
		
		zspark_tileegine_internal function fixPos(x:Number,y:Number):void{
			for each(var pct:Particle in _particleVct){
				pct.position.addComponent(x,y);
			}
		}
		
		zspark_tileegine_internal function get centerPos():Vector2D{
			var fx:Number=0.0;
			var fy:Number=0.0;
			var n:uint=0;
			for each(var pct:Particle in _particleVct){
				fx+=pct.position.x;
				fy+=pct.position.y;
				n++;
			}
			return new Vector2D(fx/n,fy/n);
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
		
		/**
		 * 只是将参数中的x，y分量保存进自己的成员变量_velocity里面，不会引用参数； 
		 * @param value
		 * 
		 */
		public function set velocity(value:Vector2D):void
		{
			_velocity.reset(value);
			for each(var pct:Particle in _particleVct){
				pct.velocity.reset(value);
			}
		}
		
		public function setVelocity(vx:Number,vy:Number):void{
			_velocity.resetComponent(vx,vy);
			for each(var pct:Particle in _particleVct){
				pct.velocity.resetComponent(vx,vy);
			}
		}
		
		/*public function get lastPosition():Vector2D{
			return new Vector2D(_position.x-_velocity.x,_position.y-_velocity.y);
		}
		
		public function get futurePosition():Vector2D{
			return new Vector2D(_position.x+_velocity.x,_position.y+_velocity.y);
		}
		
		CONFIG::DEBUG{
			private var _posHistoryCache:Array=[];
			public function addToHistory():void{
				_posHistoryCache.push(_position.clone());
			}
		};*/
		
	}
}