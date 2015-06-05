package z_spark.tileengine.entity
{
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.component.RenderCompnent;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.sensor.Sensor;

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
		private var _sensor:Sensor;
		
		public function get sensor():Sensor
		{
			return _sensor;
		}

		public function set sensor(value:Sensor):void
		{
			_sensor = value;
		}

		public function get renderComponent():RenderCompnent
		{
			return _rc;
		}

		public function set renderComponent(value:RenderCompnent):void
		{
			_rc = value;
		}

		public function get statusComponent():StatusComponent
		{
			return _sc;
		}

		public function set statusComponent(value:StatusComponent):void
		{
			_sc = value;
		}

		public function get movementComponent():MovementComponent
		{
			return _mc;
		}

		public function set movementComponent(value:MovementComponent):void
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