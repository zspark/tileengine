package z_spark.tileengine.tile
{
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.math.Vector2D;

	public class TileNone extends TileBase implements ITile
	{
		public function TileNone(type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(type,row,col);
			_type=TileType.TYPE_NONE;
		}
		
		public function testCollision(tilesize:uint, targetPos:Vector2D, targetSpd:Vector2D):Boolean
		{
			return false;
		}
		
		CONFIG::DEBUG{
			public function toString():String{
				return "";
			}
			protected var _debugDrawColor:uint=0x000000;
			public function get debugDrawColor():uint{
				return _debugDrawColor;
			}
			
			public function get dirArray():Array{
				return null;
			}
		};
		
	}
}