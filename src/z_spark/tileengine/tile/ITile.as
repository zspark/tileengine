package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.Particle;
	import z_spark.tileengine.node.CollisionNode;

	public interface ITile
	{
		function update(gravity:Vector2D, cn:CollisionNode,pct:Particle,fpos:Vector2D):int;
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