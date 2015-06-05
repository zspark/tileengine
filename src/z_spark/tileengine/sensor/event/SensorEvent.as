package z_spark.tileengine.sensor.event
{
	import flash.events.Event;
	
	import z_spark.tileengine.system.TileHandleOutput;
	
	public class SensorEvent extends Event
	{
		public static const SOR_HIT_TILE_WALL:String="sor_hit_tile_wall";
		public static const SOR_STOPPED:String="sor_stopped";
		public static const SOR_IN_THE_AIR:String="sor_in_the_air";
		
		public var tileHandleOutput:TileHandleOutput;
		public function SensorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}