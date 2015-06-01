package z_spark.tileengine.primitive
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
		private var _posOffset:Vector2D=new Vector2D();
		private var _globalCenterPos:Vector2D=new Vector2D();
		
		public function RenderCompnent()
		{
		}
		
		
		public function get posOffset():Vector2D
		{
			return _posOffset;
		}

		public function set posOffset(value:Vector2D):void
		{
			_posOffset = value;
		}

		public function set disObj(value:DisplayObject):void
		{
			_disObj = value;
		}

		zspark_tileegine_internal function setNativeMethod():void{
			_disObj.scaleX=_scaleX;
			_disObj.scaleY=_scaleY;
			_disObj.x=_globalCenterPos.x+_posOffset.x;
			_disObj.y=_globalCenterPos.y+_posOffset.y;
		}
		
		zspark_tileegine_internal function setGlobalCenterPos(gx:Number,gy:Number):void{
			_globalCenterPos.resetComponent(gx,gy);
		}
	}
}