package z_spark.tileengine.math
{
	/**
	 * │a	b	tx	│
	 * │c	d	ty	│
	 * │e	f	n 	│
	 * 
	 * @author z_Spark
	 * 
	 */
	final public class Matrix2D
	{
		private var _a:Number=1;
		private var _b:Number=0;
		private var _c:Number=0;
		private var _d:Number=1;
		private var _tx:Number=0;
		private var _ty:Number=0;
		private var _e:Number=0;
		private var _f:Number=0;
		private var _n:Number=1;
		public function Matrix2D(a:Number=1,b:Number=0,c:Number=0,d:Number=1,tx:Number=0,ty:Number=0):void{
		{
			set(a,b,c,d,tx,ty);
		}
		}
		
		public function set (a:Number,b:Number,c:Number,d:Number,tx:Number,ty:Number):void{
			_a=a;
			_b=b;
			_c=c;
			_d=d;
			_tx=tx;
			_ty=ty;
		}
		
		
	}
}