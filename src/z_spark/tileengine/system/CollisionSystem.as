package z_spark.tileengine.system
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.node.CollisionNode;
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.Particle;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.tile.ITile;

	use namespace zspark_tileegine_internal;
	/**
	 * 碰撞解决； 
	 * 风，雨水等影响整个TileWorld的力；
	 * @author z_Spark
	 * 
	 */
	final public class CollisionSystem
	{
		public function CollisionSystem(){}
		
		zspark_tileegine_internal function update(cn:CollisionNode,tilemap:TileMap,gravity:Vector2D):void{
			var mc:MovementComponent;
			var tile:ITile;
			var delayHandleArr:Array=[];
			switch(cn.statusCmp.status)
			{
				case StatusComponent.STATUS_CLIMB:
				{
					break;
				}
				case StatusComponent.STATUS_JUMP:
				{
					/*mc=cn.movementCmp;
					mc.position.add(mc.velocity);
					
					var iteratorCount:int=0;
					var status:int=TileHandleStatus.ST_ITERATOR;
					while(status==TileHandleStatus.ST_ITERATOR){ 
						iteratorCount++;
						if(iteratorCount>_iteratorMax)break;
						else {
							tile=tilemap.getTileByXY(mc.position.x,mc.position.y);
							status=tile.testCollision(tilemap.tileSize,gravity,cn);
						}
					}
					
					mc.velocity.add(mc.acceleration);*/
					break;
				}
				case StatusComponent.STATUS_MOVE:
				{
					mc=cn.movementCmp;
					var st:int;
					for each(var pct:Particle in mc._particleVct){
						var fpos:Vector2D=pct.futurePosition;
						tile=tilemap.getTileByXY(fpos.x,fpos.y);
						
						st=tile.handleTileMove(gravity,mc,pct,fpos);
						if(st==TileHandleStatus.ST_DELAY)delayHandleArr.push(pct);
						else{
							pct.status=Particle.NO_CHECK;
						}
					}
					
					for each( pct in delayHandleArr){
						fpos=pct.futurePosition;
						tile=tilemap.getTileByXY(fpos.x,fpos.y);
						
						tile.handleTileMove(gravity,mc,pct,fpos);
						pct.status=Particle.NO_CHECK;
					}
					
					delayHandleArr.length=0;
					
					
					break;
				}
				case StatusComponent.STATUS_STAY:
				default:
				{
					break;
				}
			}
		}
		
	}
}