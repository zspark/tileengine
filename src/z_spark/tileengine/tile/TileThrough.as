package z_spark.tileengine.tile
{
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.sensor.event.SensorEvent;
	import z_spark.tileengine.system.TileHandleInput;
	import z_spark.tileengine.system.TileHandleOutput;

	use namespace zspark_tileegine_internal;
	
	public class TileThrough extends TileBase implements ITile
	{
		public function TileThrough(tilemap:TileMap,row:int,col:int)
		{
			super(tilemap,row,col);
			_type=TileType.TYPE_THROUGHT;
			_bounceDecrease=0;
			_frictionDecrease=0;
			CONFIG::DEBUG{
				_debugDrawColor=0x666666;
			};
		}
		
		public function handle(tileHandleInput:TileHandleInput,tileHandleOutput:TileHandleOutput):void
		{
			tileHandleInput.pct.position.reset(tileHandleInput.futurePosition);
			
			tileHandleOutput.handleStatus=TileHandleStatus.ST_PASS;
			tileHandleOutput.row=_row;
			tileHandleOutput.col=_col;
			
			if(tileHandleInput.sensor &&!tileHandleOutput.hit_through_event_dispatched){
				tileHandleOutput.hit_through_event_dispatched=true;
				tileHandleInput.sensor.dispatch(SensorEvent.SOR_HIT_TILE_THROUGH,tileHandleOutput);
			}
			return;
		}
	}
}