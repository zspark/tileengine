package z_spark.tileengine.tile
{
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.primitive.IElement;

	public interface ITile
	{
		function testCollision(tilesize:uint,gravity:Vector2D, elem:IElement):int;
		
		CONFIG::DEBUG{
			function toString():String;
			function get dirArray():Array;
			function get debugDrawColor():uint;
		};
		
//		/**
//		 * 重写格子方向向量，会顶掉之前公用的向量引用，持有新的，
//		 * 并且公用的引用（除非再次赋值）不会自动恢复； 
//		 * @param value
//		 * 
//		 */
//		function set dirArray(value:Array):void;
			
//		function get dir():int;
//		
		function get col():int;
//		
		function get row():int;
//		
		function get type():int;
	}
}