package z_spark.tileengine
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import z_spark.tileengine.math.Vector2D;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 格子世界物体模型； 
	 * @author z_Spark
	 * 
	 */
	public class WorldObjectModel extends EventDispatcher
	{
		public function WorldObjectModel()
		{
			_spdV=new Vector2D();
			_posV=new Vector2D();
		}
		
		private var _spdV:Vector2D;
		public function get spdVector():Vector2D
		{
			return _spdV;
		}
		
		private var _posV:Vector2D;
		public function get posVector():Vector2D
		{
			return _posV;
		}
		
		private var _world:TileWorld;
		zspark_tileegine_internal function set tileWorld(value:TileWorld):void{
			_world=value;
		}
		
		private var _allowDispatch:Boolean=false;
		zspark_tileegine_internal function frameEndCall():void
		{
			_allowDispatch && dispatchEvent(new Event("update"));
		}
		
		zspark_tileegine_internal function wakeUp():void{
			_world.awake(this);
		}
		
		zspark_tileegine_internal function sleep():void{
			_world.sleep(this);
		}
		
		CONFIG::DEBUG{
			public function addToHistory():void
			{
			}
		};
	}
}