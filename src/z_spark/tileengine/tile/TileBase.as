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
		
		/**
		 * 判断从哪个方向进入格子；
		 * 进入的方向只有4个，上下左右；
		 * @param tilesize
		 * @param fpos
		 * @return 
		 * 
		 */		
		protected function getEnterDir(tilesize:int,fpos:Vector2D):String{
			var yOverlapDis:Number=fpos.y-tilesize*_row;
			var xOverlapDis:Number=fpos.x-tilesize*_col;
			var oyOverlapDis:Number=tilesize-yOverlapDis;
			var oxOverlapDis:Number=tilesize-xOverlapDis;
			
			var result:String='';
			var tile:ITile;
			var minDis:Number=tilesize+1;
			
			if(yOverlapDis<minDis){
				tile=_tilemap.getTileByRC(row-1,col);
				if(tile is TileNone){
					minDis=yOverlapDis;
					result=TileBase.Y_MINUS;
				}
			}
			
			if(xOverlapDis<minDis){
				tile=_tilemap.getTileByRC(row,col-1);
				if(tile is TileNone){
					minDis=xOverlapDis;
					result=TileBase.X_MINUS;
				}
			}
			
			if(oyOverlapDis<minDis){
				tile=_tilemap.getTileByRC(row+1,col);
				if(tile is TileNone){
					minDis=oyOverlapDis;
					result=TileBase.Y_PLUS;
				}
			}
			
			if(oxOverlapDis<minDis){
				tile=_tilemap.getTileByRC(row,col+1);
				if(tile is TileNone){
					minDis=oxOverlapDis;
					result=TileBase.X_PLUS;
				}
			}
			
			return result;
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