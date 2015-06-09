package z_spark.tileengine.component
{
	import z_spark.tileengine.zspark_tileegine_internal;

	use namespace zspark_tileegine_internal;

	public class StatusComponent
	{
		public static const STATUS_JUMP:int=1;
		public static const STATUS_MOVE:int=2;
		public static const STATUS_STAY:int=4;
		
		private var _status:uint=STATUS_JUMP;
		public function StatusComponent(){
			tileCountArray=particlesTileCountArray1;
			tileCountArray_history=particlesTileCountArray2;
		}
		
		public function get status():uint
		{
			return _status;
		}

		public function set status(value:uint):void
		{
			_status = value;
		}
		
		zspark_tileegine_internal var particlesTileCountArray2:Array=[];
		zspark_tileegine_internal var particlesTileCountArray1:Array=[];
		zspark_tileegine_internal var tileCountArray_history:Array;
		zspark_tileegine_internal var tileCountArray:Array;

	}
}