package z_spark.tileengine.tile
{
	import flash.display.Graphics;
	
	import z_spark.tileengine.math.Vector2D;

	public interface ITile
	{
		function testCollision(tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):Boolean;
		
		CONFIG::DEBUG{
			function debugDraw(grap:Graphics,sz:int):void;
		};
		
//		function get dir():int;
//		
//		function get col():int;
//		
//		function get row():int;
//		
//		function get type():int;
	}
}