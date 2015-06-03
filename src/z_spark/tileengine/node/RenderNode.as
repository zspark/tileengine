package z_spark.tileengine.node
{
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.component.RenderCompnent;
	import z_spark.tileengine.component.RenderCompnent;

	public class RenderNode
	{
		private var _movementCmp:MovementComponent;
		private var _renderCmp:RenderCompnent;
		
		public function get renderCmp():RenderCompnent
		{
			return _renderCmp;
		}
		
		public function set renderCmp(value:RenderCompnent):void
		{
			_renderCmp = value;
		}
		
		public function get movementCmp():MovementComponent
		{
			return _movementCmp;
		}
		
		public function set movementCmp(value:MovementComponent):void
		{
			_movementCmp = value;
		}
		public function RenderNode(){}
	}
}