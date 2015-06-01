package z_spark.tileengine.entity
{
	import flash.display.Sprite;
	
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.primitive.IEntity;
	import z_spark.tileengine.primitive.MovementComponent;
	import z_spark.tileengine.primitive.RenderCompnent;
	import z_spark.tileengine.primitive.StatusComponent;
	import z_spark.tileengine.tile.ITile;

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
		private var _obj:Sprite;
		
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

		public function get obj():Sprite
		{
			return _obj;
		}
		
		public function set obj(value:Sprite):void
		{
			_obj = value;
		}
		
		public function RigidEntity()
		{
		}
		
		public function addStatus(stat:uint):void
		{
		}
		
		public function get position():Vector2D
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function set position(value:Vector2D):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function get status():uint
		{
			return _sc.status;
		}
		
		public function frameEndCall(tile:ITile,handleStatus:int):void
		{
		}
		
	}
}