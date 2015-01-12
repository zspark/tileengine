package z_spark.tileengine.tile
{
	import z_spark.as3lib.utils.ColorUtil;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.primitive.IElement;


	/**
	 * 迭代格子； 
	 * @author z_Spark
	 * 
	 */
	final public class TileIterator extends TileOneSide implements ITile
	{
		public function TileIterator(tilemap:TileMap,type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(tilemap,type,row,col,pos,dirv);
			_type=TileType.TYPE_ITERATOR;
			CONFIG::DEBUG{
				_debugDrawColor=ColorUtil.COLOR_ORANGE;
			};
		}
		
		override public function testCollision(tilesize:uint,gravity:Vector2D, elem:IElement):int
		{
			super.testCollision(tilesize,gravity,elem);
			return TileHandleStatus.ST_ITERATOR;
		}
		
	}
}