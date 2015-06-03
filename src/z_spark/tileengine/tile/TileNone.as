package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.node.CollisionNode;
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.Particle;

	public class TileNone extends TileBase implements ITile
	{
		public function TileNone(tilemap:TileMap,type:int,row:int,col:int)
		{
			super(tilemap,type,row,col);
			_type=TileType.TYPE_NONE;
		}
		
		public function testCollision(tilesize:uint,gravity:Vector2D, cn:CollisionNode):int
		{
			return TileHandleStatus.ST_PASS;
		}
		

		CONFIG::DEBUG{
			
			public function get dirArray():Array{
				return null;
			}
		};
		
		public function handleTileMove( gravity:Vector2D, elem:MovementComponent,pct:Particle,fpos:Vector2D=null):int
		{
			pct.position.reset(fpos);
			return TileHandleStatus.ST_PASS;
			
		}
		
	}
}