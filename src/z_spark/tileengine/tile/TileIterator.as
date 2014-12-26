package z_spark.tileengine.tile
{
	import z_spark.as3lib.utils.ColorUtil;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.math.Vector2D;


	/**
	 * 迭代格子； 
	 * @author z_Spark
	 * 
	 */
	final public class TileIterator extends TileNormal implements ITile
	{
		public function TileIterator(type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(type,row,col,pos,dirv);
			_type=TileType.TYPE_ITERATOR;
			CONFIG::DEBUG{
				debugDrawColor=ColorUtil.COLOR_ORANGE;
			};
		}
		
		override public function testCollision(tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):Boolean
		{
			super.testCollision(tilesize,targetPos,targetSpd);
			return true;
		}
		
	}
}