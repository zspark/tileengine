package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileMap;

	public class TileBase
	{
		public static const X_MINUS:String="x-";
		public static const X_PLUS:String="x+";
		public static const Y_MINUS:String="y-";
		public static const Y_PLUS:String="y+";
		
		protected var _tilemap:TileMap;
		protected var _type:int;
		protected var _row:int;	
		protected var _col:int;
		protected var _bounceFactor:Number=.7;
		protected var _frictionFactor:Number=.5;
		
		public function TileBase(tilemap:TileMap,type:int,row:int,col:int)
		{
			_tilemap=tilemap;
			_type=type;
			_row=row;
			_col=col;
		}
		
		public function get col():int{return _col;}
		public function set col(value:int):void{_col=value;}
		public function get row():int{return _row;}
		public function set row(value:int):void{_row=value;}
		public function get type():int{return _type;}
		
		protected function getEnterDir(tilesize:int,fpos:Vector2D):String{
			//判断从哪个方向进入墙；
			//进入的方向只有4个，上下左右；
			var yOverlapDis:Number=fpos.y-tilesize*_row;
			var xOverlapDis:Number=fpos.x-tilesize*_col;
			
			if(yOverlapDis>xOverlapDis){
				if(tilesize-yOverlapDis>xOverlapDis){
					return TileBase.X_MINUS;
				}else return TileBase.Y_PLUS;
			}else{
				if(yOverlapDis>tilesize-xOverlapDis){
					return TileBase.X_PLUS;
				}else return TileBase.Y_MINUS;
			}
		}
		
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