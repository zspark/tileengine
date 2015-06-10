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
			CONFIG::DEBUG{
				_debugDrawColor=0xFFFFFF;
			};
		}
		
		public function handle(tileHandleInput:TileHandleInput,tileHandleOutput:TileHandleOutput):void
		{
			tileHandleInput.pct.position.reset(tileHandleInput.futurePosition);
			tileHandleOutput.handleStatus=TileHandleStatus.ST_FIXED;
			return;
		}
	}
}