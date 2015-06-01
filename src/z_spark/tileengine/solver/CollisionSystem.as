package z_spark.tileengine.solver
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.node.CollisionNode;
	import z_spark.tileengine.primitive.MovementComponent;
	import z_spark.tileengine.primitive.Particle;
	import z_spark.tileengine.primitive.StatusComponent;
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
		/**
		 * 碰撞检测迭代最大次数，数值越大，越精确，但越耗性能，你懂的； 
		 * 不懂碰撞原理的客户端程序不要随意变动该值；
		 */
		private var _iteratorMax:uint=2;
		zspark_tileegine_internal function get iteratorMax():uint
		{
			return _iteratorMax;
		}
		
		zspark_tileegine_internal function set iteratorMax(value:uint):void
		{
			_iteratorMax = value;
		}
		
		public function CollisionSystem(){}
		
		zspark_tileegine_internal function update(cn:CollisionNode,tilemap:TileMap,gravity:Vector2D):void{
			var mc:MovementComponent;
			var tile:ITile;
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
					for each(var pct:Particle in mc._particleVct){
						var fpos:Vector2D=pct.futurePosition;
						tile=tilemap.getTileByXY(fpos.x,fpos.y);
						tile.handleTileMove(tilemap.tileSize,gravity,mc,pct,fpos);
					}
					break;
				}
				case StatusComponent.STATUS_STAY:
				{
					break;
				}
				default:
				{
					break;
				}
				
				CONFIG::DEBUG{
//					cn.addToHistory();
				};
			}
		}
		
	}
}