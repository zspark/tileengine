package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.Particle;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.node.CollisionNode;

	public class TileNone extends TileBase implements ITile
	{
		public function TileNone(tilemap:TileMap,row:int,col:int)
		{
			super(tilemap,row,col);
			_type=TileType.TYPE_NONE;
		}
		
		public function update(gravity:Vector2D, cn:CollisionNode,pct:Particle,fpos:Vector2D):int
		{
			pct.position.reset(fpos);
			return TileHandleStatus.ST_PASS;
		}
	}
}