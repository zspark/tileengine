package z_spark.tileengine.component
{
	

	public class StatusComponent
	{
		public static const STATUS_JUMP:int=1;
		public static const STATUS_MOVE:int=2;
		public static const STATUS_STAY:int=4;
		
		private var _status:uint=STATUS_JUMP;
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