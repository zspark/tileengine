package z_spark.tileengine
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.primitive.IElement;
	import z_spark.tileengine.primitive.Particle;
	import z_spark.tileengine.solver.CollisionSolver;

	use namespace zspark_tileegine_internal;
	final public class TileWorld
	{
		private var _collisionSolver:CollisionSolver;
		private var _tileMap:TileMap;
		private var _stage:Stage;
		public function TileWorld(stage:Stage)
		{
			_stage=stage;
			_awakeObjectList=new Vector.<IElement>();
			_collisionSolver=new CollisionSolver();
			_tileMap=new TileMap();
		}
		
		public function get tileMap():TileMap{
			return _tileMap;
		}
		
		public function set tileSize(value:uint):void{
			_tileMap.tileSize=value;
		}
		
		public function get tileSize():uint{
			return _tileMap.tileSize;
		}
		
		private var _gravity:Vector2D;
		public function set gravity(value:Vector2D):void{
			_gravity=value;
			_collisionSolver.gravity=value;
			for each(var elem:Particle in _awakeObjectList){
				elem.acceleration=value;
			}
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
			_collisionSolver.update(_awakeObjectList,_tileMap);
		}
		
		private var _awakeObjectList:Vector.<IElement>;
		public function addWorldObject(elem:IElement):void{
			_awakeObjectList.push(elem);
			elem.acceleration=_gravity;
		}
		
		public function removeWorldObject(elem:IElement):void{
			if(_awakeObjectList.indexOf(elem)>=0)
				_awakeObjectList.splice(_awakeObjectList.indexOf(elem),1);
		}
		
	}
}