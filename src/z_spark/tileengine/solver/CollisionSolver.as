package z_spark.tileengine.solver
{
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.primitive.Particle;
	import z_spark.tileengine.tile.ITile;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.zspark_tileegine_internal;

	use namespace zspark_tileegine_internal;
	/**
	 * 碰撞解决； 
	 * 风，雨水等影响整个TileWorld的力；
	 * @author z_Spark
	 * 
	 */
	final public class CollisionSolver
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
		
		private var _gravity:Vector2D;
		zspark_tileegine_internal function set gravity(value:Vector2D):void{
			_gravity=value;
		}

		zspark_tileegine_internal function set iteratorMax(value:uint):void
		{
			_iteratorMax = value;
		}
		
		public function CollisionSolver(){}
		
		zspark_tileegine_internal function update(ptcs:Vector.<Particle>,tilemap:TileMap):void{
//			for(var i:int=0,m:int=ptcs.length;i<m;i++){
//				var ptc:WorldObjectModel=ptcs[i];
			for each(var ptc:Particle in ptcs){
				if(!ptc.awake)continue;
				ptc.integrate();
				
				var iteratorCount:int=0;
				var status:int=TileHandleStatus.ST_ITERATOR;
				while(status==TileHandleStatus.ST_ITERATOR){
					iteratorCount++;
					if(iteratorCount>_iteratorMax)break;
					else {
						var tile:ITile=tilemap.getTileByXY(ptc.posVector.x,ptc.posVector.y);
						status=tile.testCollision(tilemap.tileSize,_gravity,ptc.posVector,ptc.spdVector);
					}
				}
				
				ptc.frameEndCall(tile,status);
				
				CONFIG::DEBUG{
//					ptc.addToHistory();
				};
			}
		}
		
	}
}