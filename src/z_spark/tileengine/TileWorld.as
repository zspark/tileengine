package z_spark.tileengine
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.entity.IEntity;
	import z_spark.tileengine.node.CollisionNode;
	import z_spark.tileengine.node.RenderNode;
	import z_spark.tileengine.system.CollisionSystem;
	import z_spark.tileengine.system.RenderSystem;
	import z_spark.tileengine.tile.TileGlobal;

	use namespace zspark_tileegine_internal;
	final public class TileWorld
	{
		private var _collisionSystem:CollisionSystem;
		private var _renderSystem:RenderSystem;
		private var _tileMap:TileMap;
		private var _stage:Stage;
		private var _cn:CollisionNode;
		private var _rn:RenderNode;
		private var _gravity:Vector2D;
		private var _entityList:Vector.<IEntity>;
		
		public function TileWorld(stage:Stage)
		{
			_stage=stage;
			_entityList=new Vector.<IEntity>();
			_collisionSystem=new CollisionSystem();
			_renderSystem=new RenderSystem();
			_tileMap=new TileMap();
			
			_cn=new CollisionNode();
			_rn=new RenderNode();
		}
		
		public function setMaxVelocity(value:Number):void{
			TileGlobal.MAX_VELOCITY=value;
		}
		
		public function get tileMap():TileMap{
			return _tileMap;
		}
		
		public function tileSize(w:int,h:int):void{
			TileGlobal.TILE_W=w;
			TileGlobal.TILE_H=h;
		}
		
		public function set gravity(value:Vector2D):void{
			_gravity=value;
		/*	_collisionSystem.gravity=value;
			for each(var elem:MovementComponent in _entityList){
				elem.acceleration=value;
			}*/
		}
		
		public function get gravity():Vector2D
		{
			return _gravity;
		}
		
		public function engineStart():void{
			_stage.addEventListener(Event.ENTER_FRAME,onEHandler);
		}
		
		public function engineStop():void{
			_stage.removeEventListener(Event.ENTER_FRAME,onEHandler);
		}
		
		private function onEHandler(event:Event):void
		{
			_tileMap.updateTiles();
			
			for each(var entity:IEntity in _entityList){
				_cn.movementCmp=entity.mc;
				_cn.statusCmp=entity.sc;
				_collisionSystem.update(_cn,_tileMap,_gravity);
				
				_rn.movementCmp=entity.mc;
				_rn.renderCmp=entity.rc;
				_renderSystem.render(_rn);
			}
		}
		
		public function addWorldObject(elem:IEntity):void{
			_entityList.push(elem);
		}
		
		public function removeWorldObject(elem:IEntity):void{
			if(_entityList.indexOf(elem)>=0)
				_entityList.splice(_entityList.indexOf(elem),1);
		}
		
	}
}