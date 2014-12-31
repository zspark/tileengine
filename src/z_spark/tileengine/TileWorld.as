package z_spark.tileengine
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import z_spark.tileengine.contact.Contact;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.primitive.Particle;
	import z_spark.tileengine.solver.CollisionSolver;
	import z_spark.tileengine.solver.ContactSolver;

	use namespace zspark_tileegine_internal;
	final public class TileWorld
	{
		private var _collisionSolver:CollisionSolver;
		private var _contactSolver:ContactSolver;
		private var _tileMap:TileMap;
		private var _stage:Stage;
		public function TileWorld(stage:Stage)
		{
			_stage=stage;
			_awakeObjectList=new Vector.<Particle>();
			_contactList=new Vector.<Contact>();
			_collisionSolver=new CollisionSolver();
			_contactSolver=new ContactSolver();
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
			for each(var ptc:Particle in _awakeObjectList){
				ptc.acceleration=value;
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
			_collisionSolver.update(_awakeObjectList,_tileMap);
			_contactSolver.update(_contactList);
		}
		
		private var _awakeObjectList:Vector.<Particle>;
		public function addWorldObject(ptc:Particle):void{
			_awakeObjectList.push(ptc);
			ptc.acceleration=_gravity;
		}
		
		public function removeWorldObject(ptc:Particle):void{
			if(_awakeObjectList.indexOf(ptc)>=0)
				_awakeObjectList.splice(_awakeObjectList.indexOf(ptc),1);
		}
		
		private var _contactList:Vector.<Contact>;
		public function addContact(contact:Contact):void{
			_contactList.push(contact);
		}
		
	}
}