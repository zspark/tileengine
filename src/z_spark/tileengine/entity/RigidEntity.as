package z_spark.tileengine.entity
{
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.component.RenderCompnent;
	import z_spark.tileengine.component.StatusComponent;

	/**
	 * 刚体实体，可以有好多个碰撞点，但共享同一个速度、加速度向量； 
	 * @author z_Spark
	 * 
	 */
	public class RigidEntity implements IEntity
	{
		private var _mc:MovementComponent;
		private var _sc:StatusComponent;
		private var _rc:RenderCompnent;
		
		public function get rc():RenderCompnent
		{
			return _rc;
		}

		public function set rc(value:RenderCompnent):void
		{
			_rc = value;
		}

		public function get sc():StatusComponent
		{
			return _sc;
		}

		public function set sc(value:StatusComponent):void
		{
			_sc = value;
		}

		public function get mc():MovementComponent
		{
			return _mc;
		}

		public function set mc(value:MovementComponent):void
		{
			_mc = value;
		}

		public function RigidEntity()
		{
			_mc=new MovementComponent();
			_rc=new RenderCompnent();
			_sc=new StatusComponent();
		}
		
	}
}