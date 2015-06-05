package z_spark.tileengine.system
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.Particle;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.node.CollisionNode;
	import z_spark.tileengine.sensor.Sensor;
	import z_spark.tileengine.sensor.event.SensorEvent;
	import z_spark.tileengine.tile.ITile;
	import z_spark.tileengine.tile.TileGlobal;
	import z_spark.tileengine.tile.TileNone;

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
			_tileHandleInput.speed.reset(mc.speed);
			switch(cn.statusCmp.status)
			{
				case StatusComponent.STATUS_JUMP:
				{
					update_internal(tilemap,cn,gravity,delta_s);
					
					if(_tileHandleOutput.skipLastAllSettings)break;
					if(_tileHandleOutput.fixSpeedFlag){
						mc.speed.reset(_tileHandleOutput.fixSpeed);
					}
					mc.speed.addScale(mc.acceleration,delta_s);
					mc.speed.addScale(gravity,delta_s);
					limitSpeed(mc);
					break;
				}
				case StatusComponent.STATUS_MOVE:
				{
					update_internal(tilemap,cn,gravity,delta_s);
					
					if(_tileHandleOutput.skipLastAllSettings)break;
					
					mc.speed.addScale(mc.acceleration,delta_s);
					
					if(sensor){
						var tmpV:Vector2D=_tileHandleInput.futurePosition;
						tmpV.reset(gravity);
						tmpV.setMagTo(TileGlobal.MAG_OF_TESTING_NONE_TILE);
						var n:uint=0;
						for each(var pct:Particle in mc._particleVct){
							var tile:ITile=tilemap.getTileByXY(pct.position.x+tmpV.x,pct.position.y+tmpV.y);
							if(tile && tile is TileNone){
								n++;
							}
						}
						if(n>=mc._particleVct.length)sensor.dispatch(SensorEvent.SOR_IN_THE_AIR,_tileHandleOutput);
					}
					
					limitSpeed(mc);
					break;
				}
				case StatusComponent.STATUS_STAY:
				default:break;
			}
			
		}
		
		
		private function limitSpeed(mc:MovementComponent):void{
			//不能超过最大速度；
			if(mc.speed.mag>TileGlobal.MAX_VELOCITY){
				mc.speed.setMagTo(TileGlobal.MAX_VELOCITY);
			}
		}
		
		private function update_internal(tilemap:TileMap,cn:CollisionNode,gravity:Vector2D,delta_s:Number):void{
			var mc:MovementComponent=cn.movementCmp;
			var pct:Particle;
			var tile:ITile;
			
			_tileHandleOutput.reset();
			
			for each(pct in mc._particleVct){
				_tileHandleInput.pct=pct;
				_tileHandleInput.futurePosition.reset(pct.position);
				_tileHandleInput.futurePosition.addScale(_tileHandleInput.speed,delta_s);
				tile=tilemap.getTileByVector(_tileHandleInput.futurePosition);
				tile.handle(_tileHandleInput,_tileHandleOutput);
				if(_tileHandleOutput.handleStatus==TileHandleStatus.ST_PASS)pct.status=Particle.NO_CHECK;
			}
			
			for each( pct in _tileHandleOutput.delayHandleArray){
				_tileHandleInput.pct=pct;
				_tileHandleInput.futurePosition.reset(pct.position);
				_tileHandleInput.futurePosition.addScale(_tileHandleInput.speed,delta_s);
				tile=tilemap.getTileByVector(_tileHandleInput.futurePosition);
				tile.handle(_tileHandleInput,_tileHandleOutput);
				pct.status=Particle.NO_CHECK;
			}
			
		}
		
		
	}
}