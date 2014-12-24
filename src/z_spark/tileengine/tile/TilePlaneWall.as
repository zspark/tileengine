package z_spark.tileengine.tile
{
	import flash.display.Graphics;
	
	import z_spark.as3lib.utils.ColorUtil;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.math.Vector2D;

	public class TilePlaneWall  extends TileBase implements ITile
	{
		public function TilePlaneWall(row:int,col:int,dir:int,pos:Vector2D,dirv:Vector2D)
		{
			super(row,col,dir,pos,dirv);
			_type=TileType.TYPE_PLANE_WALL;
			CONFIG::DEBUG{
				debugDrawColor=ColorUtil.COLOR_BLUE_LIGHT;
			};
		}
		
		CONFIG::DEBUG{
			override public function debugDraw(grap:Graphics,sz:int):void{
			}
		};
		
	}
}