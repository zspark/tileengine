package z_spark.tileengine.tile
{
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.primitive.IElement;

	public interface ITile
	{
		function testCollision(tilesize:uint,gravity:Vector2D, elem:IElement):int;
		function handleTileMove(tilesize:uint,gravity:Vector2D, elem:IElement,testPos:Vector2D=null):int;
		CONFIG::DEBUG{
			function toString():String;
			function get dirArray():Array;
			function get debugDrawColor():uint;
		};
		
		function get col():int;
		function set col(value:int):void;
		function get row():int;
		function set row(value:int):void;
		function get type():int;
		function set fixTeleport(value:Boolean):void;
	}
}