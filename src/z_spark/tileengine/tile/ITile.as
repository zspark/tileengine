package z_spark.tileengine.tile
{
	import z_spark.tileengine.system.TileHandleInput;
	import z_spark.tileengine.system.TileHandleOutput;

	public interface ITile
	{
		function handle(tileHandleInput:TileHandleInput,tileHandleOutput:TileHandleOutput):void;
		function toString():String;
		
		function get col():int;
		function set col(value:int):void;
		function get row():int;
		function set row(value:int):void;
		function get type():int;
		
		function get top():int;
		function get bottom():int;
		function get left():int;
		function get right():int;
		
		
		CONFIG::DEBUG{
			function get debugDrawColor():uint;
		};
	}
}