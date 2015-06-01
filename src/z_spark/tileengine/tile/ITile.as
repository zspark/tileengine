package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.node.CollisionNode;
	import z_spark.tileengine.primitive.MovementComponent;
	import z_spark.tileengine.primitive.Particle;

	public interface ITile
	{
		function testCollision(tilesize:uint,gravity:Vector2D, elem:CollisionNode):int;
		function handleTileMove(tilesize:uint,gravity:Vector2D, elem:MovementComponent,pct:Particle,fpos:Vector2D=null):int;
		function toString():String;
		CONFIG::DEBUG{
			function get dirArray():Array;
			function get debugDrawColor():uint;
		};
		
		function get col():int;
		function set col(value:int):void;
		function get row():int;
		function set row(value:int):void;
		function get type():int;
	}
}