package z_spark.tileengine.system
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.zspark_tileegine_internal;
	

	/**
	 * 每个粒子在格子中处理后的结果输出； 
	 * @author z_Spark
	 * 
	 */
	public final class TileHandleOutput
	{
		public var skipLastAllSettings:Boolean=false;
		public var row:int;
		public var col:int;
		private var _delayHandleArray:Array=[];
		/**
		 * 粒子是从哪个方向进入该格子。 
		 */
		public var dir:int;
		/**
		 * 格子对粒子的处理结果 
		 */
		public var handleStatus:int;
		/**
		 * 格子是否有对该粒子的速度修正； 
		 */
		public var fixSpeedFlag:Boolean=false;
		/**
		 * 速度修正的具体向量； 
		 * 独立2D向量；
		 */
		public var fixSpeed:Vector2D=new Vector2D();
		
		public function TileHandleOutput()
		{
			reset();
		}
		
		zspark_tileegine_internal function get delayHandleArray():Array
		{
			return _delayHandleArray;
		}

		public function reset():void{
			fixSpeedFlag=false;
			dir=-1;
			handleStatus=-1;
			fixSpeed.clear();
			row=-1;
			col=-1;
			skipLastAllSettings=false;
			_delayHandleArray.length=0;
		}
	}
}