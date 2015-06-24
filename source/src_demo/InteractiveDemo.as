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
	
	[SWF(width="1100",height="640",frameRate="60")]
	public class InteractiveDemo extends Sprite
	{
		private var world:TileWorld;
		private var body:RigidEntity;
		private var _entityCtrl:KeyboardStatus;
		private var _vx:Number=0.0;
		private var _vy:Number=0.0;
		public function InteractiveDemo()
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
			
			//刚体默认是跳跃状态，我们改为移动状态（移动状态不参与重力计算，目的是为了降低计算量，对于俯视角游戏，也不需要重力）；
			body.statusComponent.status=StatusComponent.STATUS_STAY;
			
			//将刚体加入格子世界；
			world.addWorldObject(body);
			
			//创建一个实体控制器；
			_entityCtrl=new KeyboardStatus(stage);
			
			addEventListener(Event.ENTER_FRAME,onE);
			
			//////////////////////////////////debug///////////////////////////////////
			var dbug:Sprite=new DBGStats();
			dbug.x=stage.stageWidth-100;
			addChild(dbug);
			
		}
		
		private const spd:Number=150;
		
		protected function onE(event:Event):void
		{
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
			else body.statusComponent.status=StatusComponent.STATUS_MOVE;
			body.movementComponent.speed.resetComponent(_vx,_vy);
		}
		
	}
}