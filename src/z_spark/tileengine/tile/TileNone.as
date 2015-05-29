package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.constance.ElementStatus;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.primitive.IElement;

	public class TileNone extends TileBase implements ITile
	{
		public function TileNone(tilemap:TileMap,type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(tilemap,type,row,col);
			_type=TileType.TYPE_NONE;
		}
		
		public function testCollision(tilesize:uint,gravity:Vector2D, elem:IElement):int
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
		
		public function handleTileMove(tilesize:uint, gravity:Vector2D, elem:IElement,testPos:Vector2D=null):int
		{
			var x:Number=elem.position.x;
			var y:Number=elem.position.y;
			do{
				x+=elem.acceleration.x
				y+=elem.acceleration.y;
				var tile:ITile=_tilemap.getTileByXY(x,y);
			}while(tile==this)
			if(tile is TileNone){
				elem.addStatus(ElementStatus.JUMP);
				return TileHandleStatus.ST_PASS;
			}
			else return tile.handleTileMove(tilesize,gravity,elem,new Vector2D(x,y));
			
		}
		
	}
}