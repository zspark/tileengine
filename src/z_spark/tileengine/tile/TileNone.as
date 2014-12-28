package z_spark.tileengine.tile
{
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.math.Vector2D;

	public class TileNone extends TileBase implements ITile
	{
		public function TileNone(type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(type,row,col);
			_type=TileType.TYPE_NONE;
		}
		
		public function testCollision(tilesize:uint, targetPos:Vector2D, targetSpd:Vector2D):int
		{
			return TileHandleStatus.ST_PASS;
		}
		
		CONFIG::DEBUG{
			public function toString():String{
				return "";
			}
			
			public function get dirArray():Array{
				return null;
			}
		};
		
	}
}