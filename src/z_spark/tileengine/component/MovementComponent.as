package z_spark.tileengine.component
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.Particle;
	import z_spark.tileengine.zspark_tileegine_internal;
	
	use namespace zspark_tileegine_internal;
	public class MovementComponent
	{
		zspark_tileegine_internal var _particleVct:Vector.<Particle>;
		zspark_tileegine_internal var _lastPivotPos:Vector2D;
		zspark_tileegine_internal var _lastRecordTime:uint;
		
		private var _speed:Vector2D;
		private var _acceleration:Vector2D;
		private var _startUpTime:uint=200;//ms;启动时间，就是物体从静止到满速的时间间隔;
		private var _passedTime:uint=0;//ms;
		
		private var _mostLeft_relativeToPovit:Number=0;
		private var _mostRight_relativeToPovit:Number=0;
		private var _mostTop_relativeToPovit:Number=0;
		private var _mostBottom_relativeToPovit:Number=0;
		
		public function MovementComponent()
		{
			_particleVct=new Vector.<Particle>();
			_speed=new Vector2D();
			_acceleration=new Vector2D();
			_lastPivotPos=new Vector2D();
		}
		
		public function get right():Number
		{
			return pivotParticle.position.x+_mostRight_relativeToPovit;
		}

		public function get left():Number
		{
			return pivotParticle.position.x+_mostLeft_relativeToPovit;
		}

		public function get top():Number
		{
			return pivotParticle.position.y+_mostTop_relativeToPovit;
		}

		public function get bottom():Number
		{
			return pivotParticle.position.y+_mostBottom_relativeToPovit;
		}
		
		public function get width():Number{
			return right-left;
		}
		
		public function get height():Number{
			return bottom-top;
		}

		zspark_tileegine_internal function fixPosition(xx:Number,yy:Number):void{
			for each(var pct:Particle in _particleVct){
				pct.position.addComponent(xx,yy);
			}
		}
		
		public function getCenterPosition(vct:Vector2D):void{
			vct.reset(pivotParticle.position);
			vct.addComponent(_mostLeft_relativeToPovit+_mostRight_relativeToPovit>>1,
				_mostBottom_relativeToPovit+_mostTop_relativeToPovit>>1);
		}
		
		public function set pivotParticle(pct:Particle):void{
			if(_particleVct.length>0 && _particleVct.length>0){
				var pvotPos:Vector2D=_particleVct[0].position;
				for each(var p:Particle in _particleVct){
					if(p==_particleVct[0])continue;
					p.position.resetComponent(pct.position.x+p.position.x-pvotPos.x,pct.position.y+p.position.y-pvotPos.y);
				}
			}
			_particleVct[0]=pct;
			pct.velocityShare(_speed);
			pct.accelerationShare(_acceleration);
			
			_lastPivotPos.reset(pct.position);
		}
		
		public function get pivotParticle():Particle{
			return _particleVct[0];
		}
		
		public function addSubParticle(offx:int,offy:int):void{
			if(_particleVct.length==0)throw("请先设置锚点粒子");
			var pvotPos:Vector2D=_particleVct[0].position;
			var pct:Particle=new Particle();
			pct.position.resetComponent(pvotPos.x+offx,pvotPos.y+offy);
			pct.velocityShare(_speed);
			pct.accelerationShare(_acceleration);
			_particleVct.push(pct);
			
			if(offx>_mostRight_relativeToPovit)_mostRight_relativeToPovit=offx;
			else if(offx<_mostLeft_relativeToPovit)_mostLeft_relativeToPovit=offx;
			if(offy>_mostBottom_relativeToPovit)_mostBottom_relativeToPovit=offy;
			else if(offy<_mostTop_relativeToPovit)_mostTop_relativeToPovit=offy;
		}
		
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
	}
}