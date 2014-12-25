package z_spark.tileengine
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.solver.ForceImpactor;

	use namespace zspark_tileegine_internal;
	final public class TileWorld
	{
		private var _collisionSolver:ForceImpactor;
		private var _tileMap:TileMap;
		private var _stage:Stage;
		public function TileWorld(stage:Stage)
		{
			_stage=stage;
			_tileWorldObjectArr=new Vector.<ITileWorldObject>();
			_collisionSolver=new ForceImpactor();
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
		
		public function set gravity(value:Vector2D):void{
			_collisionSolver.gravity=value;
		}
		
		public function get gravity():Vector2D
		{
			return _collisionSolver.gravity;
		}
		
		
		public function engineStart():void{
			_stage.addEventListener(Event.ENTER_FRAME,onEHandler);
		}
		
		public function engineStop():void{
			_stage.removeEventListener(Event.ENTER_FRAME,onEHandler);
		}
		
		private function onEHandler(event:Event):void
		{
			_collisionSolver.update(_tileWorldObjectArr,_tileMap);
		}
		
		private var _tileWorldObjectArr:Vector.<ITileWorldObject>;
		public function addWorldObject(obj:ITileWorldObject):void{
			_tileWorldObjectArr.push(obj);
		}
		
		public function removeWorldObject(obj:ITileWorldObject):void{
			_tileWorldObjectArr.splice(_tileWorldObjectArr.indexOf(obj),1);
		}
	}
}