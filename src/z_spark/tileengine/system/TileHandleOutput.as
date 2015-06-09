package z_spark.tileengine.system
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.zspark_tileegine_internal;
	
	use namespace zspark_tileegine_internal;

	/**
	 * 每个粒子在格子中处理后的结果输出； 
	 * @author z_Spark
	 * 
	 */
	public final class TileHandleOutput
	{
		public var skipLastAllSettings:Boolean=false;
		zspark_tileegine_internal var hitWallParticleCount:uint=0;
		zspark_tileegine_internal var inThroughParticleCount:uint=0;
		/**
		 * 粒子是从哪个方向进入该格子。 
		 */
		public var dir:int;
		/**
		 * 格子对粒子的处理结果 
		 */
		public var handleStatus:int;
		/**
		 * 速度修正的具体向量； 
		 * 独立2D向量；
		 */
		public var fixSpeed:Vector2D=new Vector2D();
		
		public function TileHandleOutput(){reset();}
		
		private var _delayHandleArray:Array=[];
		/**
		 * 延后处理的粒子； 
		 * @return 
		 * 
		 */
		zspark_tileegine_internal function get delayHandleArray():Array
		{return _delayHandleArray;	}

		zspark_tileegine_internal function reset():void{
			dir=-1;
			handleStatus=-1;
			fixSpeed.clear();
			skipLastAllSettings=false;
			_delayHandleArray.length=0;
			hitWallParticleCount=0;
			inThroughParticleCount=0;
		}
	}
}