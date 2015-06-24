package z_spark.tileengine.component
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.system.TileHandleInput;
	
	use namespace zspark_tileegine_internal;
	public class MovementComponent
	{
		public static const LEFT_TOP:uint=0;
		public static const RIGHT_TOP:uint=1;
		public static const RIGHT_BOTTOM:uint=2;
		public static const LEFT_BOTTOM:uint=3;
		
		zspark_tileegine_internal var _lastPivot:Vector2D;
		zspark_tileegine_internal var _pivot:Vector2D;
		zspark_tileegine_internal var _lastPivotTime:uint;
		
		private var _speed:Vector2D;
		private var _acceleration:Vector2D;
		
		private var _w:Number=1.0;
		private var _h:Number=1.0;
		
		public function MovementComponent()
		{
			_pivot=new Vector2D();
			_lastPivot=new Vector2D();
			_speed=new Vector2D();
			_acceleration=new Vector2D();
		}
		
		public function get right():Number
		{
			return _pivot.x+_w;
		}

		public function get left():Number
		{
			return _pivot.x;
		}

		public function get top():Number
		{
			return _pivot.y;
		}

		public function get bottom():Number
		{
			return _pivot.y+_h;
		}
		
		public function get width():Number{
			return _w;
		}
		
		public function get height():Number{
			return _h;
		}
		
		public function getCenterPosition(vct:Vector2D):void{
			vct.reset(_pivot);
			vct.addComponent(_w>>1,_h>>1);
		}
		
		public function setSize(gx:Number,gy:Number,w:Number=1.0,h:Number=1.0):void{
			_pivot.x=gx;
			_pivot.y=gy;
			_w=w;_h=h;
		}
		
		public function get acceleration():Vector2D
		{
			return _acceleration;
		}
		
		/**
		 * 将参数中的2D向量值复制给该对象成员，并不是引用参数； 
		 * @param value
		 * 
		 */
		public function set acceleration(value:Vector2D):void
		{
			_acceleration.reset(value);
		}
		
		public function get speed():Vector2D
		{
			return _speed;
		}
		
		/**
		 * 只是将参数中的x，y分量保存进自己的成员变量_velocity里面，不会引用参数； 
		 * @param value
		 * 
		 */
		public function set speed(value:Vector2D):void
		{
			_speed.reset(value);
		}
		
		private var i:int=0;
		zspark_tileegine_internal function getFirst(fpivot:Vector2D,input:TileHandleInput):Boolean{
			input.currentPos.reset(_pivot);
			input.futurePos.reset(fpivot);
			input.corner=LEFT_TOP;
			i=0;
			return true;
		}
		
		zspark_tileegine_internal function getNext(fpivot:Vector2D,input:TileHandleInput):Boolean{
			i++;
			if(i==1){
				input.currentPos.resetComponent(_pivot.x+_w,_pivot.y);
				input.futurePos.resetComponent(fpivot.x+_w,fpivot.y);
				input.corner=RIGHT_TOP;
				return true;
			}
			if(i==2){
				input.currentPos.resetComponent(_pivot.x+_w,_pivot.y+_h);
				input.futurePos.resetComponent(fpivot.x+_w,fpivot.y+_h);
				input.corner=RIGHT_BOTTOM;
				return true;
			}
			if(i==3){
				input.currentPos.resetComponent(_pivot.x,_pivot.y+_h);
				input.futurePos.resetComponent(fpivot.x,fpivot.y+_h);
				input.corner=LEFT_BOTTOM;
				return true;
			}
			return false;
		}
	}
}