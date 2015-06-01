package z_spark.tileengine.primitive
{
	

	public class StatusComponent
	{
		public static const STATUS_JUMP:int=1;
		public static const STATUS_MOVE:int=2;
		public static const STATUS_STAY:int=4;
		public static const STATUS_CLIMB:int=8;
		
		private var _status:uint=STATUS_STAY;
		public function StatusComponent(){}
		
		public function get status():uint
		{
			return _status;
		}

		public function set status(value:uint):void
		{
			_status = value;
		}

	}
}