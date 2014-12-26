package z_spark.tileengine
{
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.tile.ITile;

	use namespace zspark_tileegine_internal;
	/**
	 * 力作用器； 
	 * 风，雨水等影响整个TileWorld的力；
	 * @author z_Spark
	 * 
	 */
	public class ForceImpactor
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
		public function ForceImpactor(){}
		
		private var _gravity:Vector2D;
		zspark_tileegine_internal function set gravity(value:Vector2D):void{
			_gravity=value;
		}
		zspark_tileegine_internal function get gravity():Vector2D{
			return _gravity;
		}
		
		public function update(objs:Vector.<ITileWorldObject>,tilemap:TileMap):void{
			for(var i:int=0,m:int=objs.length;i<m;i++){
				var obj:ITileWorldObject=objs[i];
				obj.spdVector.add(_gravity);
				obj.posVector.add(obj.spdVector);
				
				var iteratorCount:int=0;
				var again:Boolean=true;
				while(again){
					iteratorCount++;
					if(iteratorCount>_iteratorMax)break;
					else {
						var tile:ITile=tilemap.getTileByXY(obj.posVector.x,obj.posVector.y);
						again=tile.testCollision(tilemap.tileSize,obj.posVector,obj.spdVector);
					}
				}
				
				obj.frameEndCall();
				
				CONFIG::DEBUG{
//					obj.addToHistory();
				};
			}
		}
		
	}
}