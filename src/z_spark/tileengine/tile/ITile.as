package z_spark.tileengine.tile
{
	import flash.display.Graphics;
	
	import z_spark.tileengine.math.Vector2D;

	public interface ITile
	{
		function testCollision(tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):Boolean;
		
		CONFIG::DEBUG{
			function debugDraw(grap:Graphics,sz:int):void;
			function toString():String;
		};
		
		/**
		 * 重写格子方向向量，会顶掉之前公用的向量引用，持有新的，
		 * 并且公用的引用（除非再次赋值）不会自动恢复； 
		 * @param value
		 * 
		 */
		function set dirArray(value:Array):void;
			
//		function get dir():int;
//		
//		function get col():int;
//		
//		function get row():int;
//		
//		function get type():int;
	}
}