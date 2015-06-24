package z_spark.tileengine.system
{
	import flash.utils.getTimer;
	
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileGlobal;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.TileUtil;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.constance.TileDir;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.node.CollisionNode;
	import z_spark.tileengine.sensor.Sensor;
	import z_spark.tileengine.sensor.event.SensorEvent;
	import z_spark.tileengine.tile.ITile;

	use namespace zspark_tileegine_internal;
	/**
	 * @author z_Spark
	 * 
	 */
	final public class CollisionSystem
	{
		private static const S_TO_MS:uint=1000;
		private static const MS_TO_S:Number=1/S_TO_MS;
		private var _tileHandleInput:TileHandleInput=new TileHandleInput();
		private var _tileHandleOutput:TileHandleOutput=new TileHandleOutput();
		
		public function CollisionSystem(){}
		
		zspark_tileegine_internal function update(cn:CollisionNode,tilemap:TileMap,gravity:Vector2D,delta_ms:uint,sensor:Sensor=null):void{
			var mc:MovementComponent=cn.movementCmp;
			var delta_s:Number=delta_ms*MS_TO_S;
			_tileHandleInput.cn=cn;
			_tileHandleInput.gravity=gravity;
			_tileHandleInput.sensor=sensor;
			_tileHandleInput.tileMap=tilemap;
			switch(cn.statusCmp.status)
			{
				case StatusComponent.STATUS_JUMP:
				{
					update_internal(tilemap,cn,gravity,delta_s);
					
					if(_tileHandleOutput.skipLastAllSettings)break;
					mc.speed.add(_tileHandleOutput.fixSpeed);
					mc.speed.addScale(mc.acceleration,delta_s);
					mc.speed.addScale(gravity,delta_s);
					limitSpeed(mc);
					
					if(sensor){
						dispatch_wall();
						dispatch_through();
					}
					
					swapAndSaveInfo();
					break;
				}
				case StatusComponent.STATUS_MOVE:
				{
					update_internal(tilemap,cn,gravity,delta_s);
					
					if(_tileHandleOutput.skipLastAllSettings)break;
					mc.speed.addScale(mc.acceleration,delta_s);
					limitSpeed(mc);
					
					if(sensor){
						dispatch_wall();
						dispatch_through();
						dispatch_inAir();
					}
					
					swapAndSaveInfo();
					break;
				}
				case StatusComponent.STATUS_STAY:
				default:break;
			}
		}
		
		private function update_internal(tilemap:TileMap,cn:CollisionNode,gravity:Vector2D,delta_s:Number):void{
			var mc:MovementComponent=cn.movementCmp;
			var tile:ITile;
			var fpivot:Vector2D=_tileHandleInput.futurePivot;
			
			_tileHandleOutput.reset();
			fpivot.reset(mc._pivot);
			fpivot.addScale(mc.speed,delta_s);
			
			mc.getFirst(fpivot,_tileHandleInput);
			do{
				tile=tilemap.getTileByVector(_tileHandleInput.futurePos);
				tile.handle(_tileHandleInput,_tileHandleOutput);
				
				if(_tileHandleOutput.handleStatus==TileHandleStatus.ST_FIXED){
					fpivot.add(_tileHandleOutput.fixPivot);
				}
				_tileHandleOutput.fixPivot.clear();
			}while(mc.getNext(fpivot,_tileHandleInput));
			
			mc._lastPivot.reset(mc._pivot);
			mc._pivot.reset(fpivot);
			
			_tileHandleInput.cn.statusCmp.tileCountArray[TileType.TYPE_THROUGHT]=_tileHandleOutput.inThroughParticleCount;
			_tileHandleInput.cn.statusCmp.tileCountArray[TileType.TYPE_THROUGHT_TOP]=_tileHandleOutput.inThroughTopParticleCount;
			_tileHandleInput.cn.statusCmp.tileCountArray[TileType.TYPE_WALL]=_tileHandleOutput.hitWallParticleCount;
			
		}
		
		private function fixThroughTopPosition():void
		{
			var tmpV:Vector2D=new Vector2D();
			tmpV.reset(_tileHandleInput.gravity);
			tmpV.setMagTo(TileGlobal.MAX_VELOCITY*17/1000);
			
			var mc:MovementComponent=_tileHandleInput.cn.movementCmp;
			var tilemap:TileMap=_tileHandleInput.tileMap;
			var tile:ITile;
			
			_tileHandleInput.futurePivot.resetComponent(mc.left+tmpV.x,mc.bottom+tmpV.y);
			_tileHandleInput.currentPos.resetComponent(mc.left,mc.bottom);
			tile=tilemap.getTileByVector(_tileHandleInput.futurePivot);
			if(tile.type==TileType.TYPE_THROUGHT_TOP){
				TileUtil.fixPosition(tile.row,tile.col,TileDir.DIR_TOP,_tileHandleInput.currentPos,_tileHandleOutput.fixPivot);
				mc._pivot.add(_tileHandleOutput.fixPivot);
				return;
			}
			
			_tileHandleInput.futurePivot.x=mc.right+tmpV.x
			_tileHandleInput.currentPos.resetComponent(mc.right,mc.bottom);
			tile=tilemap.getTileByVector(_tileHandleInput.futurePivot);
			if(tile.type==TileType.TYPE_THROUGHT_TOP){
				TileUtil.fixPosition(tile.row,tile.col,TileDir.DIR_TOP,_tileHandleInput.currentPos,_tileHandleOutput.fixPivot);
				mc._pivot.add(_tileHandleOutput.fixPivot);
			}
		}
		
		private function dispatch_inAir():void{
			var tmpV:Vector2D=_tileHandleInput.futurePivot;
			tmpV.reset(_tileHandleInput.gravity);
			tmpV.setMagTo(TileGlobal.MAG_OF_TESTING_NONE_TILE);
			var mc:MovementComponent=_tileHandleInput.cn.movementCmp;
			var tilemap:TileMap=_tileHandleInput.tileMap;
			var tile:ITile;
			
			//未来最低点如果是空格子，肯定是要下落的；
			tile=tilemap.getTileByXY(mc.left+tmpV.x,mc.bottom+tmpV.y);
			if(tile.type==TileType.TYPE_NONE){
				tile=tilemap.getTileByXY(mc.right+tmpV.x,mc.bottom+tmpV.y);
				if(tile.type==TileType.TYPE_NONE){
					_tileHandleInput.sensor.dispatch(SensorEvent.SOR_IN_THE_AIR,_tileHandleOutput);
					return;
				}else if(tile.type==TileType.TYPE_WALL || tile.type==TileType.TYPE_SOFT_WALL){
					return;
				}
			}else if(tile.type==TileType.TYPE_WALL || tile.type==TileType.TYPE_SOFT_WALL){
				return;
			}
			
			//现在的最低点是软墙的话，也是要下落的；
			tile=tilemap.getTileByXY(mc.left,mc.bottom);
			if(tile.type==TileType.TYPE_SOFT_WALL){
				tile=tilemap.getTileByXY(mc.right,mc.bottom);
				if(tile.type==TileType.TYPE_SOFT_WALL){
					_tileHandleInput.sensor.dispatch(SensorEvent.SOR_IN_THE_AIR,_tileHandleOutput);
				}
			}
		}
		
		private function dispatch_wall():void{
			if(_tileHandleOutput.hitWallParticleCount>0){
				_tileHandleInput.sensor.dispatch(SensorEvent.SOR_HIT_TILE_WALL,_tileHandleOutput);
			}
		}
		
		private function dispatch_through():void{
			
			var tc:uint=_tileHandleInput.cn.statusCmp.tileCountArray[TileType.TYPE_THROUGHT];
			var ltc:uint=_tileHandleInput.cn.statusCmp.tileCountArray_history[TileType.TYPE_THROUGHT];
			
			if(tc==0){
				if(ltc>0){
					fixThroughTopPosition();
					_tileHandleInput.sensor.dispatch(SensorEvent.SOR_FIRST_ALL_OUT_TILE_THROUGH,_tileHandleOutput);
				}
			}else if(tc<4){
				if(ltc==0)_tileHandleInput.sensor.dispatch(SensorEvent.SOR_FIRST_IN_TILE_THROUGH,_tileHandleOutput);
				else if(ltc==4)_tileHandleInput.sensor.dispatch(SensorEvent.SOR_FIRST_OUT_TILE_THROUGH,_tileHandleOutput);
			}else if(tc==4){
				if(ltc<4)_tileHandleInput.sensor.dispatch(SensorEvent.SOR_FIRST_ALL_IN_TILE_THROUGH,_tileHandleOutput);
			}
		}
		
		private function swapAndSaveInfo():void{
			//交换数组；
			var tmp:Array=_tileHandleInput.cn.statusCmp.tileCountArray;
			if(tmp==_tileHandleInput.cn.statusCmp.particlesTileCountArray1){
				_tileHandleInput.cn.statusCmp.tileCountArray=_tileHandleInput.cn.statusCmp.particlesTileCountArray2;
				_tileHandleInput.cn.statusCmp.tileCountArray_history=tmp;
			}else{
				_tileHandleInput.cn.statusCmp.tileCountArray=_tileHandleInput.cn.statusCmp.particlesTileCountArray1;
				_tileHandleInput.cn.statusCmp.tileCountArray_history=tmp;
			}
			
			//清理当前数组；
			_tileHandleInput.cn.statusCmp.tileCountArray.length=0;
			
			_tileHandleInput.cn.movementCmp._lastPivot.reset(_tileHandleInput.cn.movementCmp._pivot);
			_tileHandleInput.cn.movementCmp._lastPivotTime=getTimer();
		}
		
		private function limitSpeed(mc:MovementComponent):void{
			//不能超过最大速度；
			if(mc.speed.mag>TileGlobal.MAX_VELOCITY){
				mc.speed.setMagTo(TileGlobal.MAX_VELOCITY);
			}
		}
		
	}
}