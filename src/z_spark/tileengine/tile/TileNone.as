package z_spark.tileengine.tile
{
	import flash.display.Graphics;
	
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
			public function debugDraw(grap:Graphics,sz:int):void{
			}
		};
		
	}
}