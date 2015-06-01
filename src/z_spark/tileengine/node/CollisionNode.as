package z_spark.tileengine.node
{
	import z_spark.tileengine.primitive.MovementComponent;
	import z_spark.tileengine.primitive.StatusComponent;

	public class CollisionNode
	{
		private var _movementCmp:MovementComponent;
		private var _statusCmp:StatusComponent;
		public function CollisionNode(){}

		public function get statusCmp():StatusComponent
		{
			return _statusCmp;
		}

		public function set statusCmp(value:StatusComponent):void
		{
			_statusCmp = value;
		}

		public function get movementCmp():MovementComponent
		{
			return _movementCmp;
		}

		public function set movementCmp(value:MovementComponent):void
		{
			_movementCmp = value;
		}
		
	}
}