package z_spark.tileengine
{
	public class TileGlobal
	{
		public static var TILE_W:uint;
		public static var TILE_H:uint;
		
		public static var MAX_VELOCITY:Number=500.0;//pps
		
		public static var MAG_OF_TESTING_NONE_TILE:Number=1.0;
		
		public static var RECENT_STEP_COUNT:uint=10;//保存近期10帧对象的移动信息，比如速度、距离；
	}
}