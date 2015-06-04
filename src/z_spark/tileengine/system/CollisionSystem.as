package z_spark.tileengine.system
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.Particle;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.node.CollisionNode;
	import z_spark.tileengine.tile.ITile;
	import z_spark.tileengine.tile.TileGlobal;

	use namespace zspark_tileegine_internal;
	/**
	 * 碰撞解决； 
	 * 风，雨水等影响整个TileWorld的力；
	 * @author z_Spark
	 * 
	 */
	final public class CollisionSystem
	{
		private static const S_TO_MS:uint=1000;
		private static const MS_TO_S:Number=1/S_TO_MS;
		private var _delayHandleArray:Array=[];
		private var _futurePosition:Vector2D=new Vector2D();
		public function CollisionSystem(){}
		
		zspark_tileegine_internal function update(cn:CollisionNode,tilemap:TileMap,gravity:Vector2D,delta_ms:uint):void{
			var mc:MovementComponent=cn.movementCmp;
			var delta_s:Number=delta_ms*MS_TO_S;
			switch(cn.statusCmp.status)
			{
				case StatusComponent.STATUS_JUMP:
				{
					update_internal(tilemap,cn,gravity,delta_s);
					if(mc.fixSpeedFlag){
						mc.velocity.reset(mc.fixSpeed);
						mc.fixSpeedFlag=false;
					}
					mc.velocity.addScale(mc.acceleration,delta_s);
					mc.velocity.addScale(gravity,delta_s);
					
					break;
				}
				case StatusComponent.STATUS_MOVE:
				{
					update_internal(tilemap,cn,gravity,delta_s);
					mc.velocity.addScale(mc.acceleration,delta_s);
					
					break;
				}
				case StatusComponent.STATUS_STAY:
				default:
				{
					break;
				}
			}
			//不能超过最大速度；
			if(mc.velocity.mag>TileGlobal.MAX_VELOCITY){
				mc.velocity.setMagTo(TileGlobal.MAX_VELOCITY);
			}
		}
		
		private function update_internal(tilemap:TileMap,cn:CollisionNode,gravity:Vector2D,delta_s:Number):void{
			var mc:MovementComponent=cn.movementCmp;
			var pct:Particle;
			var tile:ITile;
			var st:int;
			
			_delayHandleArray.length=0;
			for each(pct in mc._particleVct){
				_futurePosition.resetComponent(pct.position.x+pct.velocity.x*delta_s,pct.position.y+pct.velocity.y*delta_s);
				tile=tilemap.getTileByXY(_futurePosition.x,_futurePosition.y);
				
				st=tile.update(gravity,cn,pct,_futurePosition);
				if(st==TileHandleStatus.ST_DELAY)_delayHandleArray.push(pct);
				else{
					pct.status=Particle.NO_CHECK;
				}
			}
			
			for each( pct in _delayHandleArray){
				_futurePosition.resetComponent(pct.position.x+pct.velocity.x*delta_s,pct.position.y+pct.velocity.y*delta_s);
				tile=tilemap.getTileByXY(_futurePosition.x,_futurePosition.y);
				
				tile.update(gravity,cn,pct,_futurePosition);
				pct.status=Particle.NO_CHECK;
			}
			
		}
		
	}
}