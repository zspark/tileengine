package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import utils.RigidEntityFactory;
	import utils.TileWorldFactory;
	
	import z_spark.core.debug.DBGStats;
	import z_spark.linearalgebra.LAMath;
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileWorld;
	import z_spark.tileengine.entity.RigidEntity;
	import utils.MapInfoConst;
	
	[SWF(width="1100",height="640",frameRate="60")]
	public class GravityDemo extends Sprite
	{
		private var world:TileWorld;
		private var gravity:Vector2D;
		public function GravityDemo()
		{
			trace("Hello Tile World!");
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			stage.color=0xcccccc;
			stage.frameRate=60;
			
			//创建一个格子世界；
			world=TileWorldFactory.createNewWorld(stage,MapInfoConst.simpleMapInfo,this);
			gravity=world.gravity;
			
			const a:int=20;
			
			//创建一个刚体
			var body:RigidEntity=RigidEntityFactory.createNewRigidEntity(a*4.7,a*5,this);
			
			//将刚体加入格子世界；
			world.addWorldObject(body);
			
			
			//////////////////////////////////debug///////////////////////////////////
			var dbug:Sprite=new DBGStats();
			dbug.x=stage.stageWidth-100;
			addChild(dbug);
			
			
			addEventListener(Event.ENTER_FRAME,onE);
		}
		
		protected function onE(event:Event):void
		{
			//每次enterframe 将重力向量旋转随机的角度；
			LAMath.addDegree(gravity,Math.random()*5);
		}
		
	}
}