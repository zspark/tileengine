package z_spark.tileengine.primitive
{
	import flash.display.Sprite;
	
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.tile.ITile;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 格子世界物体模型； 
	 * @author z_Spark
	 * 
	 */
	public class Particle
	{
		private static const MIN_SPD:Number=0.5;
		private static const MAX_SLEEPING_COUNT:int=30;
		private var _accV:Vector2D;
		private var _spdV:Vector2D;
		private var _posV:Vector2D;
		private var _damping:Number=1;
		private var _awake:Boolean=true;
		private var _obj:Sprite;

		public function get awake():Boolean
		{
			return _awake;
		}

		public function set awake(value:Boolean):void
		{
			_awake = value;
		}

		/**
		 * 每次碰撞发生后的能量衰减，无论方向； 
		 * @return 
		 * 
		 */
		public function get damping():Number
		{
			return _damping;
		}

		public function set damping(value:Number):void
		{
			_damping = value;
		}

		public function get obj():Sprite
		{
			return _obj;
		}
		
		public function set obj(value:Sprite):void
		{
			_obj = value;
		}
		
		public function Particle()
		{
			_spdV=new Vector2D();
			_posV=new Vector2D();
		}
		
		public function get accV():Vector2D
		{
			return _accV;
		}
		
		public function set accV(value:Vector2D):void
		{
			_accV = value;
		}

		public function get spdVector():Vector2D
		{
			return _spdV;
		}
		
		public function set spdVector(value:Vector2D):void 
		{
			_spdV=value;
			_awake=true;
		}
		
		public function get posVector():Vector2D
		{
			return _posV;
		}
		
		public function get lastPosVector():Vector2D{
			return new Vector2D(_posV.x-_spdV.x,_posV.y-_spdV.y);
		}
		
		zspark_tileegine_internal function integrate(duration:Number=0.0):void{
			_spdV.add(_accV);
			_posV.add(_spdV);
		}
		
		private var _hitPlaneCount:int=0;
		private var _lastTile:ITile;
		zspark_tileegine_internal function frameEndCall(tile:ITile,handleStatus:int):void
		{
//			if(handleStatus!=TileHandleStatus.ST_PASS){
////				_spdV.mul(1-_damping);
//				if(tile===_lastTile){
//					_hitPlaneCount++;
//					if(_hitPlaneCount>MAX_SLEEPING_COUNT && _spdV.mag<MIN_SPD)// && MathUtil.dotProduct(_spdV,_world.gravity)<=.002-_world.gravity.magSqare)
//					{	
//						_awake=false;
//						_hitPlaneCount=0;
//						_lastTile=null;
//					}
//				}else {
//					_hitPlaneCount=0;
//				}
//			}
//			_lastTile=tile;
			
			if(_obj){
				_obj.x=_posV.x;
				_obj.y=_posV.y;
			}
		}
		
		CONFIG::DEBUG{
			private var _posHistoryCache:Array=[];
			public function addToHistory():void{
				_posHistoryCache.push(_posV.clone());
			}
		};
	}
}