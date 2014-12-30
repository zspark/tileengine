package z_spark.tileengine
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.primitive.Particle;

	use namespace zspark_tileegine_internal;
	final public class TileWorld
	{
		private var _collisionSolver:ForceImpactor;
		private var _tileMap:TileMap;
		private var _stage:Stage;
		public function TileWorld(stage:Stage)
		{
			_stage=stage;
			_awakeObjectList=new Vector.<Particle>();
			_sleepingObjectList=new Vector.<Particle>();
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
			_collisionSolver.update(_awakeObjectList,_tileMap);
		}
		
		private var _awakeObjectList:Vector.<Particle>;
		private var _sleepingObjectList:Vector.<Particle>;
		public function addWorldObject(model:Particle):void{
			_awakeObjectList.push(model);
			model.tileWorld=this;
		}
		
		public function removeWorldObject(model:Particle):void{
			if(_awakeObjectList.indexOf(model)>=0)
				_awakeObjectList.splice(_awakeObjectList.indexOf(model),1);
			else if(_sleepingObjectList.indexOf(model)>=0)
				_sleepingObjectList.splice(_sleepingObjectList.indexOf(model),1);
			
			model.tileWorld=null;
		}
		
		zspark_tileegine_internal function sleep(model:Particle):void{
			_awakeObjectList.splice(_awakeObjectList.indexOf(model),1);
			_sleepingObjectList.push(model);
		}
		
		zspark_tileegine_internal function wakeup(model:Particle):void{
			_sleepingObjectList.splice(_awakeObjectList.indexOf(model),1);
			if(_awakeObjectList.indexOf(model)>=0)return;
			_awakeObjectList.push(model);
		}
	}
}