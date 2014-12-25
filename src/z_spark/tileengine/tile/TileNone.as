package z_spark.tileengine.tile
{
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.math.Vector2D;

	public class TileNone extends CollisionSolver
	{
		public function TileNone(row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(row,col,pos,dirv);
			_type=TileType.TYPE_NONE;
		}
		
		override public function testCollision(tilesize:uint, targetPos:Vector2D, targetSpd:Vector2D):Boolean
		{
			return false;
		}
		
	}
}