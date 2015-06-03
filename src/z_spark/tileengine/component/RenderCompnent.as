package z_spark.tileengine.component
{
	import flash.display.DisplayObject;
	
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.zspark_tileegine_internal;
	
	use namespace zspark_tileegine_internal;
	public class RenderCompnent
	{
		private var _disObj:DisplayObject;
		private var _scaleX:Number=1.0;
		private var _scaleY:Number=1.0;
		
		public function RenderCompnent(){}
		
		public function set sprite(value:DisplayObject):void
		{
			_disObj = value;
		}

		zspark_tileegine_internal function render(globalPos:Vector2D):void{
			/*_disObj.scaleX=_scaleX;
			_disObj.scaleY=_scaleY;*/
			_disObj.x=globalPos.x;
			_disObj.y=globalPos.y;
		}
		
	}
}