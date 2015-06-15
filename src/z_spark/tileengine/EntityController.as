package z_spark.tileengine
{
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import z_spark.core.utils.KeyboardConst;
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.constance.TileDir;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.entity.RigidEntity;
	import z_spark.tileengine.sensor.Sensor;
	import z_spark.tileengine.sensor.event.SensorEvent;
	import z_spark.tileengine.tile.ITile;

	public class EntityController
	{
		private var _centerVct:Vector2D=new Vector2D();
		private var spdY:Number=210;
		private var spdX:Number=170;
		private var hitWallCount:uint=0;
		private var _isBodyInTileThrough:Boolean=false;
		private var _isBodyClimbing:Boolean=false;
		private var _vx:Number=0.0;
		private var _vy:Number=0.0;
		private var _body:RigidEntity;
		private var _tilemap:TileMap;
		private var _sensor:Sensor;
		private var _recentDisInfo:Array=[];
		private var _recentTimeInfo:Array=[];
		private var _keyStatus:Array;
		
		public function EntityController(){}
		
		
		public function set keyStatus(value:Array):void
		{
			_keyStatus = value;
		}

		public function set sensor(value:Sensor):void
		{
			_sensor = value;
			_sensor.addEventListener(SensorEvent.SOR_HIT_TILE_WALL,onHitWall);
			_sensor.addEventListener(SensorEvent.SOR_IN_THE_AIR,onInTheAir);
			_sensor.addEventListener(SensorEvent.SOR_FIRST_ALL_OUT_TILE_THROUGH,onAllOutLadder);
			_sensor.addEventListener(SensorEvent.SOR_FIRST_ALL_IN_TILE_THROUGH,onAllInLadder);
			_sensor.addEventListener(SensorEvent.SOR_FIRST_IN_TILE_THROUGH,onFirstInLadder);
			_sensor.addEventListener(SensorEvent.SOR_FIRST_OUT_TILE_THROUGH,onFirstOutLadder);
			if(_body)_body.sensor=_sensor;
		}

		public function set tilemap(value:TileMap):void
		{
			_tilemap = value;
		}

		public function set body(value:RigidEntity):void
		{
			_body = value;
			if(_sensor)_body.sensor=_sensor;
		}

		public function onJumpDown():void
		{
			if(canJump){
				if(_isBodyClimbing){
					if(_keyStatus[KeyboardConst.LEFT+'']==1){
						if(_keyStatus[KeyboardConst.RIGHT+'']==1){
							_vx=0;
						}else{
							_vx=-spdX*.7;
							_vy=-spdY*.2;
						}
					}else{
						if(_keyStatus[KeyboardConst.RIGHT+'']==1){
							_vx=spdX*.7;
							_vy=-spdY*.2;
						}else{
							_vx=0;
						}
					}
				}else if(_keyStatus[KeyboardConst.DOWN+'']==1){
					_vy=--spdY*.4;
					_body.movementComponent.speed.resetComponent(_vx,_vy);
					_body.statusComponent.status=StatusComponent.STATUS_MOVE;
					_isBodyClimbing=false;
					return;
				}else _vy=-spdY*1.5;
				_body.movementComponent.speed.resetComponent(_vx,_vy);
				_body.statusComponent.status=StatusComponent.STATUS_JUMP;
				_isBodyClimbing=false;
			}
		}
		
		private function get canJump():Boolean{
			return _body.statusComponent.status!=StatusComponent.STATUS_JUMP
		}
		
		protected function onFirstOutLadder(event:Event):void
		{
			trace("first out");
		}
		
		protected function onAllInLadder(event:Event):void
		{
			trace("all in");
		}
		
		protected function onAllOutLadder(event:SensorEvent):void
		{
			trace("all out");
			_isBodyInTileThrough=false;
			_isBodyClimbing=false;
			//			_body.statusComponent.status=StatusComponent.STATUS_JUMP;
			//检查下方是否为梯子顶，是的话，就要修正位置不能掉下去；
			/*_body.movementComponent.getCenterPosition(_centerVct);
			var tile:ITile=_tilemap.getTileByXY(_centerVct.x,_body.movementComponent.bottom+1.0);
			if(tile.type!=TileType.TYPE_THROUGHT)_isBodyInTileThrough=true;*/
		}
	
		protected function onFirstInLadder(event:SensorEvent):void
		{
			trace("first in");
			_isBodyInTileThrough=true;
		}
		
		protected function onInTheAir(event:SensorEvent):void
		{
			trace("in air");
			_body.statusComponent.status=StatusComponent.STATUS_JUMP;
			//计算水平速度，这个时候的速度不能用原来的移动速度模拟，不然不真实；
			//想象这样一种情况：角色慢慢走在边上，最后再点击一下移动，掉下去了，此时的水平速度不能用其正常移动时的速度；
			//相反，如果角色从距离边很远的地方就以正常的速度往边上走，那么掉下去后，其速度应该与正常移动速度一样。
			var dis:Number=Math.abs(_recentDisInfo[0]-_recentDisInfo[_recentDisInfo.length-1]);
			var time:Number=getTimer()-_recentTimeInfo[0];
			var velocity:Number=dis*1000/time;//pps;
			
			trace(dis,time,velocity);
			var spdx:Number=_vx*velocity/Math.abs(_vx);
			_body.movementComponent.speed.x=isNaN(spdx)?0:spdx;
		}
		
		
		protected function onHitWall(event:SensorEvent):void
		{
			trace("hit wall");
			_isBodyClimbing=false;
			if(_body.statusComponent.status==StatusComponent.STATUS_JUMP && event.tileHandleOutput.dir==TileDir.DIR_TOP){
				hitWallCount++;
				if(hitWallCount%1==0){
					_body.statusComponent.status=StatusComponent.STATUS_STAY;
					hitWallCount=0;
				}
			}
		}
		
		
		public function onE(event:Event):void
		{
			saveInfo();
			
			_vx=_vy=0;
			checkClimbLadder();
			if(_body.statusComponent.status!=StatusComponent.STATUS_JUMP){
				if(!_isBodyClimbing){
					if(_keyStatus[KeyboardConst.LEFT+'']==1){
						if(_keyStatus[KeyboardConst.RIGHT+'']==1){
							_vx=0;
						}else{
							_vx=-spdX;
						}
					}else{
						if(_keyStatus[KeyboardConst.RIGHT+'']==1){
							_vx=spdX;
						}else{
							_vx=0;
						}
					}
				}
				
				if(_vx==0 && _vy==0 )_body.statusComponent.status=StatusComponent.STATUS_STAY;
				else _body.statusComponent.status=StatusComponent.STATUS_MOVE;
				_body.movementComponent.speed.resetComponent(_vx,_vy);
			}
		}
		
		private function saveInfo():void
		{
			_recentDisInfo.push(_body.movementComponent.zspark_tileegine_internal::_lastPivot.x);
			if(_recentDisInfo.length>TileGlobal.RECENT_STEP_COUNT)_recentDisInfo.shift();
			
			_recentTimeInfo.push(_body.movementComponent.zspark_tileegine_internal::_lastPivotTime);
			if(_recentTimeInfo.length>TileGlobal.RECENT_STEP_COUNT)_recentTimeInfo.shift();
		}
		
		private function checkClimbLadder():void
		{
			if(_isBodyInTileThrough){
				if( _body.statusComponent.status==StatusComponent.STATUS_JUMP){
					if(!_isBodyClimbing)checkJumpClimb();
				}else{
					//move or stay;
					if(_isBodyClimbing){
						climbMove();
					}else checkMoveClimb();
				}
			}else{
				var tile:ITile;
				var midX:Number;
				const D:Number=5;
				if(_body.statusComponent.status!=StatusComponent.STATUS_JUMP){
					if(_keyStatus[KeyboardConst.DOWN+""]==1 ){
						_body.movementComponent.getCenterPosition(_centerVct);
						tile =_tilemap.getTileByXY(_centerVct.x,_body.movementComponent.bottom+TileGlobal.MAG_OF_TESTING_NONE_TILE);
						if(tile && (tile.type==TileType.TYPE_THROUGHT || tile.type==TileType.TYPE_THROUGHT_TOP)){
							midX=tile.left+TileGlobal.TILE_W/2;
							if(_centerVct.x>midX-D && _centerVct.x<midX+D){
								fixClimbPos(midX);
								_vy=spdY*.6;
							}
						}
					}
				}
			}
		}
		
		private function climbMove():void{
			if(_keyStatus[KeyboardConst.UP+'']==1){
				if(_keyStatus[KeyboardConst.DOWN+'']==1){
					_vy=0;
				}else{
					_vy=-spdY*.6;
				}
			}else{
				if(_keyStatus[KeyboardConst.DOWN+'']==1){
					_vy=spdY*.6;
				}else{
					_vy=0;
				}
			}
		}
		
		private function checkJumpClimb():void
		{
			const D:Number=5;
			if(_keyStatus[KeyboardConst.UP+""]==1){
				
				_body.movementComponent.getCenterPosition(_centerVct);
				var tile:ITile =_tilemap.getTileByVector(_centerVct);
				if(tile && (tile.type==TileType.TYPE_THROUGHT || tile.type==TileType.TYPE_THROUGHT_TOP)){
					var midX:Number=tile.left+TileGlobal.TILE_W/2;
					if(_centerVct.x>midX-D && _centerVct.x<midX+D)fixClimbPos(midX);
				}
			}
		}
		
		private function fixClimbPos(midX:Number):void{
			_body.movementComponent.zspark_tileegine_internal::_pivot.x=midX-20/2;
			_body.statusComponent.status=StatusComponent.STATUS_MOVE;
			_isBodyClimbing=true;
		}
		
		private function checkMoveClimb():void
		{
			const D2:Number=5;
			var tile:ITile;
			var flag:Boolean=false;
			if(_keyStatus[KeyboardConst.UP+""]==1 ){
				_body.movementComponent.getCenterPosition(_centerVct);
				tile =_tilemap.getTileByVector(_centerVct);
				if(tile && (tile.type==TileType.TYPE_THROUGHT || tile.type==TileType.TYPE_THROUGHT_TOP)){
					var midX:Number=tile.left+TileGlobal.TILE_W/2;
					if(_centerVct.x>midX-D2 && _centerVct.x<midX+D2)fixClimbPos(midX);
				}
			}
		}
		
	}
}