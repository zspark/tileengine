package z_spark.tileengine.sensor
{
	import flash.events.EventDispatcher;
	
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.sensor.event.SensorEvent;
	import z_spark.tileengine.system.TileHandleOutput;

	public class Sensor extends EventDispatcher
	{
		
		public function Sensor()
		{
		}
		
		zspark_tileegine_internal function dispatch(name:String,tileHandleOutput:TileHandleOutput):void{
			var evt:SensorEvent=new SensorEvent(name,false,false);
			evt.tileHandleOutput=tileHandleOutput;
			dispatchEvent(evt);
		}
	}
}