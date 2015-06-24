package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import utils.TileEngineDemoUtils;
	
	import z_spark.batata.ui.UIFactory;
	import z_spark.bkgrasper.SPKKeySet;
	import z_spark.bkgrasper.SPKKeyboardControl;
	import z_spark.core.debug.DBGStats;
	import z_spark.core.utils.KeyboardConst;
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.Particle;
	import z_spark.tileengine.TileWorld;
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.constance.TileDir;
	import z_spark.tileengine.debug.TileDebugger;
	import z_spark.tileengine.entity.RigidEntity;
	import z_spark.tileengine.sensor.Sensor;
	import z_spark.tileengine.sensor.event.SensorEvent;
	import z_spark.tileengine.system.TileHandleOp;
	import z_spark.tileengine.TileGlobal;
	import utils.MapInfoConst;
	
	[SWF(width="1100",height="640",frameRate="60")]
	public class SensorDemo extends Sprite
	{
		private var kbc:SPKKeyboardControl=new SPKKeyboardControl();
		private var world:TileWorld;
		protected var _keyStatus:Array;
		private var body:RigidEntity;
		private var _vx:Number=0.0;
		private var _vy:Number=0.0;
		private var _sensor:Sensor;
		public function SensorDemo()
		{
			trace("Hello Tile World!");
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			stage.color=0xcccccc;
			stage.frameRate=60;
			
			////////////////////////////////////////////////////////keyboard//
			_keyStatus=[];
			kbc.stage=stage;
			var ks:SPKKeySet=new SPKKeySet();
			ks.registKey(KeyboardConst.LEFT,onLeftUp,onLeftDown);
			ks.registKey(KeyboardConst.RIGHT,onRightUp,onRightDown);
			ks.registKey(KeyboardConst.UP,onUpUp,onUpDown);
			ks.registKey(KeyboardConst.DOWN,onDownUp,onDownDown);
			ks.registKey(KeyboardConst.SPACE,onSpaceUp,onSpaceDown);
			kbc.registKeySet("SensorTest",ks,true);
			/////////////////////////////////////////////////////////end////
			
			var _ctn:Sprite=new Sprite();
			addChild(_ctn);
			
			world=new TileWorld(stage);
			world.gravity=new Vector2D(0,500);
			world.tileSize(40,50);
			world.tileMap.tileMapRawInfo=MapInfoConst.mapRawInfo4;
			TileGlobal.MAX_VELOCITY=400;
			TileDebugger.initAndDraw(world.tileMap,_ctn);
			
			const a:int=20;
			const size:uint=20;
			body=new RigidEntity();
			var pct:Particle=new Particle();
			pct.position=new Vector2D(a*4.7,a*5);
			var movementComponent:MovementComponent=body.movementComponent;
			movementComponent.pivotParticle=pct;
			movementComponent.addSubParticle(size,0);
			movementComponent.addSubParticle(size,size);
			movementComponent.addSubParticle(0,size);
			
			var disp:Sprite=TileEngineDemoUtils.getColoredSprite(size,size,0x000000);
			body.renderComponent.sprite=disp;
			_ctn.addChild(disp);
			
			world.addWorldObject(body);
			
			////////////////////////////////sensor/////////////////////////////////////
			_sensor=new Sensor();
			body.sensor=_sensor;
			_sensor.addEventListener(SensorEvent.SOR_HIT_TILE_WALL,onHitWall);
			_sensor.addEventListener(SensorEvent.SOR_IN_THE_AIR,onInTheAir);
			//////////////////////////////////end_of_sensor///////////////////////////////////
			
			world.engineStart();
			
			addEventListener(Event.ENTER_FRAME,onE);
			
			//////////////////////////////////debug///////////////////////////////////
			var dbug:Sprite=new DBGStats();
			dbug.x=stage.stageWidth-100;
			addChild(dbug);
			
		}
		
		protected function onInTheAir(event:Event):void
		{
			body.statusComponent.status=StatusComponent.STATUS_JUMP;
		}
		
		private function onSpaceUp():void
		{
			spaceDownFlag=false;
		}
		
		private var spaceDownFlag:Boolean=false;
		private function onSpaceDown():void
		{
			if(!spaceDownFlag){
				spaceDownFlag=true;
				body.movementComponent.velocity.y=-spd*4;
				body.statusComponent.status=StatusComponent.STATUS_JUMP;
			}
		}
		
		private var spd:Number=150;
		
		protected function onE(event:Event):void
		{
			if(body.statusComponent.status!=StatusComponent.STATUS_JUMP ){
				if(_keyStatus[KeyboardConst.LEFT+'']==1){
					if(_keyStatus[KeyboardConst.RIGHT+'']==1){
						_vx=0;
						body.movementComponent.velocity.x=_vx;
					}else{
						_vx=-spd;
						body.movementComponent.velocity.x=_vx;
					}
				}else{
					if(_keyStatus[KeyboardConst.RIGHT+'']==1){
						_vx=spd;
						body.movementComponent.velocity.x=_vx;
					}else{
						_vx=0;
						body.movementComponent.velocity.x=_vx;
					}
				}
				
				if(_vx==0 && _vy==0)body.statusComponent.status=StatusComponent.STATUS_STAY;
				else body.statusComponent.status=StatusComponent.STATUS_MOVE;
			}
		}
		
		private var hitWallCount:uint=0;
		protected function onHitWall(event:SensorEvent):void
		{
			if(body.statusComponent.status==StatusComponent.STATUS_JUMP){
				var output:TileHandleOp=event.tileHandleOutput;
				if(output.dir==TileDir.DIR_TOP)hitWallCount++;
				if(hitWallCount>=3){
					body.statusComponent.status=StatusComponent.STATUS_MOVE;
					hitWallCount=0;
					body.movementComponent.velocity.clear();
					output.skipLastAllSettings=true;
				}
			}
		}
		
		protected function onLeftDown():void
		{
			_keyStatus[KeyboardConst.LEFT+'']=1;
		}
		
		protected function onRightDown():void
		{
			_keyStatus[KeyboardConst.RIGHT+'']=1;
		}
		
		protected function onUpDown():void
		{
			_keyStatus[KeyboardConst.UP+'']=1;
		}
		
		protected function onDownDown():void
		{
			_keyStatus[KeyboardConst.DOWN+'']=1;
		}
		protected function onDownUp():void
		{
			_keyStatus[KeyboardConst.DOWN+'']=0;
		}
		
		protected function onUpUp():void
		{
			_keyStatus[KeyboardConst.UP+'']=0;
		}
		
		protected function onRightUp():void
		{
			_keyStatus[KeyboardConst.RIGHT+'']=0;
		}
		
		protected function onLeftUp():void
		{
			_keyStatus[KeyboardConst.LEFT+'']=0;
			
		}
	}
}