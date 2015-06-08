package z_spark.tileengine.component
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.Particle;
	import z_spark.tileengine.zspark_tileegine_internal;
	
	use namespace zspark_tileegine_internal;
	public class MovementComponent
	{
		zspark_tileegine_internal var _particleVct:Vector.<Particle>;
		private var _speed:Vector2D;
		private var _acceleration:Vector2D;
		
		public function MovementComponent()
		{
			_particleVct=new Vector.<Particle>();
			_speed=new Vector2D();
			_acceleration=new Vector2D();
		}
		
		public function fixPosition(xx:Number,yy:Number):void{
			for each(var pct:Particle in _particleVct){
				pct.position.addComponent(xx,yy);
			}
		}
		
		public function fixPositionByVector(vct:Vector2D):void{
			for each(var pct:Particle in _particleVct){
				pct.position.add(vct);
			}
		}
		
		public function getCenterPosition(vct:Vector2D):void{
			vct.clear();
			for each(var pct:Particle in _particleVct){
				vct.add(pct.position);
			}
			
			vct.mul(1/_particleVct.length);
		}
		
		public function set pivotParticle(pct:Particle):void{
			_particleVct[0]=pct;
			pct.velocityShare(_speed);
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
			pct.velocityShare(_speed);
			pct.accelerationShare(_acceleration);
			_particleVct.push(pct);
		}
		
		/*zspark_tileegine_internal function get centerPos():Vector2D{
			var fx:Number=0.0;
			var fy:Number=0.0;
			var n:uint=0;
			for each(var pct:Particle in _particleVct){
				fx+=pct.position.x;
				fy+=pct.position.y;
				n++;
			}
			return new Vector2D(fx/n,fy/n);
		}*/
		
		public function get acceleration():Vector2D
		{
			return _acceleration;
		}
		
		/**
		 * 将参数中的2D向量值复制给该对象成员，并不是引用参数； 
		 * @param value
		 * 
		 */
		public function set acceleration(value:Vector2D):void
		{
			_acceleration.reset(value);
		}
		
		public function get speed():Vector2D
		{
			return _speed;
		}
		
		/**
		 * 只是将参数中的x，y分量保存进自己的成员变量_velocity里面，不会引用参数； 
		 * @param value
		 * 
		 */
		public function set speed(value:Vector2D):void
		{
			_speed.reset(value);
		}
		
		public function setSpeed(vx:Number,vy:Number):void{
			_speed.resetComponent(vx,vy);
		}
		
	}
}