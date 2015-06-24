package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import utils.Assets;
	import utils.KeyboardStatus;
	import utils.MapInfoConst;
	import utils.RigidEntityFactory;
	import utils.TileWorldFactory;
	
	import z_spark.core.debug.DBGStats;
	import z_spark.tileengine.EntityController;
	import z_spark.tileengine.TileWorld;
	import z_spark.tileengine.entity.RigidEntity;
	import z_spark.tileengine.sensor.Sensor;
	
//	[SWF(width="1100",height="640",frameRate="60")]
//	[SWF(width="1026",height="434",frameRate="60")]
	[SWF(width="700",height="280",frameRate="60")]
	public class LadderDemo extends Sprite
	{
		private var world:TileWorld;
		private var body:RigidEntity;
		private var _kbStatus:KeyboardStatus;
		private var _entityCtrl:EntityController;
		public function LadderDemo()
		{
			trace("Hello Tile World!");
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			stage.color=0xcccccc;
			stage.frameRate=60;
			
			//贴上简单的背景;
			var cls:Class=Assets.mapBmps;
			var bmp:Bitmap=new cls();
			bmp.x=-5;
//			bmp.y=15;
			addChild(bmp);
			
			
			//创建一个格子世界；
			world=TileWorldFactory.createNewWorld(stage,MapInfoConst.demoMapRawInfo,this);
			
			const a:int=20;
			
			//创建一个刚体
			body=RigidEntityFactory.createNewRigidEntity(a*4.7,a*2.5,this);
			
			//将刚体加入格子世界；
			world.addWorldObject(body);
			
			//创建一个实体控制器；
			_entityCtrl=new EntityController();
			_entityCtrl.body=body;
			_entityCtrl.sensor=new Sensor();
			_entityCtrl.tilemap=world.tileMap;
			
			//创建一个键盘状态记录对象；
			_kbStatus=new KeyboardStatus(stage);
			_kbStatus.spaceDownFn=_entityCtrl.onJumpDown;
			_entityCtrl.keyStatus=_kbStatus.keyStatus;
			
			addEventListener(Event.ENTER_FRAME,onE);
			
			//////////////////////////////////debug///////////////////////////////////
			var dbug:Sprite=new DBGStats();
			dbug.x=stage.stageWidth-100;
			addChild(dbug);
			
		}
		
		protected function onE(event:Event):void
		{
			_entityCtrl.onE(event);
		}		
		
	}
}