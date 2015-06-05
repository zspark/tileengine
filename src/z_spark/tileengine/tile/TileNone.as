package z_spark.tileengine.tile
{
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.system.TileHandleInput;
	import z_spark.tileengine.system.TileHandleOutput;

	public class TileNone extends TileBase implements ITile
	{
		public function TileNone(tilemap:TileMap,row:int,col:int)
		{
			super(tilemap,row,col);
			_type=TileType.TYPE_NONE;
			_bounceDecrease=0;
			_frictionDecrease=0;
		}
		
		public function handle(tileHandleInput:TileHandleInput,tileHandleOutput:TileHandleOutput):void
		{
			tileHandleInput.pct.position.reset(tileHandleInput.futurePosition);
			tileHandleOutput.handleStatus=TileHandleStatus.ST_PASS;
			return;
		}
	}
}