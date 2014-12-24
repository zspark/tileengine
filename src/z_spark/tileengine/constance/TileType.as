package z_spark.tileengine.constance
{
	public class TileType
	{
		public static const TYPE_NONE:int=0x00;
		/**
		 * --------------------- 
		 */
		public static const TYPE_PLANE_GROUND:int=0x02;
		/**
		 *______/-------- 
		 */
		public static const TYPE_LEFT_SLOP_GROUND:int=0x03;
		/**
		 *----\_____ 
		 */
		public static const TYPE_RIGHT_SLOP_GROUND:int=0x04;
		/**
		 *----\_____ 
		 */
		public static const TYPE_RIGHT_SLOP:int=0x05;
		/**
		 *______/-------- 
		 */
		public static const TYPE_LEFT_SLOP:int=0x06;
		
		/**
		 * ------------------------- 
		 */
		public static const TYPE_PLANE_WALL:int=0x01;
	}
}