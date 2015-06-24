package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import utils.KeyboardStatus;
	import utils.MapInfoConst;
	import utils.RigidEntityFactory;
	import utils.TileWorldFactory;
	
	import z_spark.core.debug.DBGStats;
	import z_spark.core.utils.KeyboardConst;
	import z_spark.tileengine.TileWorld;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.entity.RigidEntity;
	import z_spark.tileengine.sensor.Sensor;
	import z_spark.tileengine.sensor.event.SensorEvent;
	import z_spark.tileengine.system.TileHandleOutput;
	
	[SWF(width="1100",height="640",frameRate="60")]
	public class SensorDemo extends Sprite
	{
		private var _entityCtrl:KeyboardStatus;
		private var world:TileWorld;
		private var body:RigidEntity;
		public function SensorDemo()
		{
			trace("Hello Tile World!");
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			stage.color=0xcccccc;
			stage.frameRate=60;
			
			//创建一个格子世界；
			world=TileWorldFactory.createNewWorld(stage,MapInfoConst.simpleMapInfo,this);
			
			const a:int=20;
			
			//创建一个刚体
			body=RigidEntityFactory.createNewRigidEntity(a*4.7,a*5,this);
			
			//将刚体加入格子世界；
			world.addWorldObject(body);
			
			//创建一个实体控制器；
			_entityCtrl=new KeyboardStatus(stage);
			
			////////////////////////////////sensor/////////////////////////////////////
			//创建一个传感器；
			var _sensor:Sensor=new Sensor();
			
			//将传感器指向刚体；
			body.sensor=_sensor;
			
			//监听传感器；
			_sensor.addEventListener(SensorEvent.SOR_HIT_TILE_WALL,onHitWall);
			_sensor.addEventListener(SensorEvent.SOR_IN_THE_AIR,onInTheAir);
			//////////////////////////////////end_of_sensor///////////////////////////////////
			
			addEventListener(Event.ENTER_FRAME,onE);
			
			//////////////////////////////////debug///////////////////////////////////
			var dbug:Sprite=new DBGStats();
			dbug.x=stage.stageWidth-100;
			addChild(dbug);
			
		}
		
		private const spd:Number=150;
		protected function onE(event:Event):void
		{
			var _vx:Number=0;
			var _vy:Number=0;
			if(_entityCtrl.keyStatus[KeyboardConst.LEFT+'']==1){
				if(_entityCtrl.keyStatus[KeyboardConst.RIGHT+'']==1){
					_vx=0;
				}else{
					_vx=-spd;
				}
			}else{
				if(_entityCtrl.keyStatus[KeyboardConst.RIGHT+'']==1){
					_vx=spd;
				}else{
					_vx=0;
				}
			}
			
			if(_entityCtrl.keyStatus[KeyboardConst.UP+'']==1){
				if(_entityCtrl.keyStatus[KeyboardConst.DOWN+'']==1){
					_vy=0;
				}else{
					_vy=-spd;
				}
			}else{
				if(_entityCtrl.keyStatus[KeyboardConst.DOWN+'']==1){
					_vy=spd;
				}else{
					_vy=0;
				}
			}
			
			if(_vx==0 && _vy==0)body.statusComponent.status=StatusComponent.STATUS_STAY;
			else {
				body.statusComponent.status=StatusComponent.STATUS_MOVE;
				body.movementComponent.speed.resetComponent(_vx,_vy);
			}
		}
		
		protected function onInTheAir(event:Event):void
		{
			//结合InteractiveDemo.as让刚体移动到重力方向一定距离没有墙的位置会出发该事件；
			trace("body 在空中，需要转变状态为'跳跃'不然不会从空中掉下来。");
		}
		
		private var hitWallCount:uint=0;
		protected function onHitWall(event:SensorEvent):void
		{
			var output:TileHandleOutput=event.tileHandleOutput;
			hitWallCount++;
//			trace("碰撞总次数："+hitWallCount,"本次碰撞信息：[列："+output.col," 行："+output.row," 方向："+output.dir," 修正速度向量："+output.fixSpeed+"]");
		}
		
	}
}