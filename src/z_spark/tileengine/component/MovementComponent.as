package z_spark.tileengine.component
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.Particle;
	import z_spark.tileengine.zspark_tileegine_internal;
	
	use namespace zspark_tileegine_internal;
	public class MovementComponent
	{
		zspark_tileegine_internal var _particleVct:Vector.<Particle>;
		private var _velocity:Vector2D;
		private var _acceleration:Vector2D;
		private var _fixSpeedFlag:Boolean=false;
		private var _fixSpeed:Vector2D;
		
		public function MovementComponent()
		{
			_particleVct=new Vector.<Particle>();
			_velocity=new Vector2D();
			_acceleration=new Vector2D();
			_fixSpeed=new Vector2D();
		}
		
		public function get fixSpeed():Vector2D
		{
			return _fixSpeed;
		}

		public function get fixSpeedFlag():Boolean
		{
			return _fixSpeedFlag;
		}

		public function set fixSpeedFlag(value:Boolean):void
		{
			_fixSpeedFlag = value;
		}

		public function set pivotParticle(pct:Particle):void{
			_particleVct[0]=pct;
			pct.velocityShare(_velocity);
			pct.accelerationShare(_acceleration);
		}
		
		public function get pivotParticle():Particle{
			return _particleVct[0];
		}
		
		public function addSubParticle(offx:int,offy:int):void{
			if(_particleVct[0]==null)throw("请先设置锚点粒子");
			var pvotPos:Vector2D=_particleVct[0].position;
			var pct:Particle=new Particle();
			pct.position.resetComponent(pvotPos.x+offx,pvotPos.y+offy);
			pct.velocityShare(_velocity);
			pct.accelerationShare(_acceleration);
			_particleVct.push(pct);
		}
		
		zspark_tileegine_internal function fixPos(x:Number,y:Number):void{
			for each(var pct:Particle in _particleVct){
				pct.position.addComponent(x,y);
			}
		}
		
//		zspark_tileegine_internal function get centerPos():Vector2D{
//			var fx:Number=0.0;
//			var fy:Number=0.0;
//			var n:uint=0;
//			for each(var pct:Particle in _particleVct){
//				fx+=pct.position.x;
//				fy+=pct.position.y;
//				n++;
//			}
//			return new Vector2D(fx/n,fy/n);
//		}
		
		public function get acceleration():Vector2D
		{
			return _acceleration;
		}
		
		public function set acceleration(value:Vector2D):void
		{
			_acceleration.reset(value);
			for each(var pct:Particle in _particleVct){
				pct.accelerationShare(_acceleration);
			}
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
				pct.velocityShare(_velocity);
			}
		}
		
		public function setVelocity(vx:Number,vy:Number):void{
			_velocity.resetComponent(vx,vy);
			for each(var pct:Particle in _particleVct){
				pct.velocityShare(_velocity);
			}
		}
		
	}
}