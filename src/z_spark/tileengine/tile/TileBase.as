package z_spark.tileengine.tile
{
	import z_spark.tileengine.TileMap;

	public class TileBase
	{
		protected var _tilemap:TileMap;
		protected var _type:int;
		protected var _row:int;	
		protected var _col:int;
		protected var _bounceFactor:Number=.7;
		protected var _frictionFactor:Number=.5;
		protected var _fixTeleport:Boolean=false;
		
		public function TileBase(tilemap:TileMap,type:int,row:int,col:int)
		{
			_tilemap=tilemap;
			_type=type;
			_row=row;
			_col=col;
		}
		
		public function set fixTeleport(value:Boolean):void{_fixTeleport = value;}
		public function get col():int{return _col;}
		public function set col(value:int):void{_col=value;}
		public function get row():int{return _row;}
		public function set row(value:int):void{_row=value;}
		public function get type():int{return _type;}
		
		CONFIG::DEBUG_DRAW_TIMELY{
			private var _intervalId:uint;
			private var _recovered:Boolean=true;
			public function recoverDebugDraw():void{
				if(_recovered)return;
				clearTimeout(_intervalId);
				TileDebugger.debugDraw(this);
				_recovered=true;
			}
		};
		
		CONFIG::DEBUG{
			protected var _debugDrawColor:uint=0x000000;
			public function get debugDrawColor():uint{
				return _debugDrawColor;
			}
		};
	}
}