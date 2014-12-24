package z_spark.tileengine
{
	import z_spark.tileengine.math.Vector2D;

	public interface ITileWorldObject
	{
//		function get x():Number;
//		function get y():Number;
//		
//		function set x(value:Number):void;
//		function set y(value:Number):void;
		
		/**
		 * 获取到物体的大致尺寸； 
		 * 暂时以圆形计算；
		 * @return 
		 * 
		 */
//		function get size():Number;
		
		function get spdVector():Vector2D;
		function get posVector():Vector2D;
		
		/**
		 * 引擎计算完毕后调用，该显示对象设置自己的最终坐标； 
		 * 
		 */
		function frameEndCall():void;
		
		CONFIG::DEBUG{
			function addToHistory():void;
		};
	}		
}