package z_spark.tileengine
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.tile.ITile;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 格子世界物体模型； 
	 * @author z_Spark
	 * 
	 */
	public class WorldObjectModel extends EventDispatcher
	{
		private static const MIN_SPD:Number=0.5;
		private static const MAX_SLEEPING_COUNT:int=4;
		private var _obj:Sprite;
		public function get obj():Sprite
		{
			return _obj;
		}
		
		public function set obj(value:Sprite):void
		{
			_obj = value;
		}
		
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
		
		public function set spdVector(value:Vector2D):void 
		{
			_spdV=value;
			_world.wakeup(this);
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
		
		private var _hitPlaneCount:int=0;
		private var _lastTile:ITile;
		private var _allowDispatch:Boolean=false;
		zspark_tileegine_internal function frameEndCall(tile:ITile,handleStatus:int):void
		{
			if(handleStatus!=TileHandleStatus.ST_PASS){
				if(tile===_lastTile){
					_hitPlaneCount++;
					if(_hitPlaneCount>MAX_SLEEPING_COUNT && _spdV.mag<MIN_SPD){
						_world.sleep(this);
						_hitPlaneCount=0;
						_lastTile=null;
					}
				}else {
					_hitPlaneCount=0;
				}
			}
			_lastTile=tile;
			
			if(_obj){
				_obj.x=_posV.x;
				_obj.y=_posV.y;
			}
			_allowDispatch && dispatchEvent(new Event("update"));
		}
		
		CONFIG::DEBUG{
			private var _posHistoryCache:Array=[];
			public function addToHistory():void{
				_posHistoryCache.push(_posV.clone());
			}
		};
	}
}