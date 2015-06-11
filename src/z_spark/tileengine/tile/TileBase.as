package z_spark.tileengine.tile
{
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.TileGlobal;

	public class TileBase
	{
		protected var _tilemap:TileMap;
		protected var _type:int;
		protected var _row:int;	
		protected var _col:int;
		protected var _bounceDecrease:Number=.8;
		protected var _frictionDecrease:Number=.5;
		
		public function TileBase(tilemap:TileMap,row:int,col:int)
		{
			_tilemap=tilemap;
			_row=row;
			_col=col;
		}
		
		public function get frictionDecrease():Number
		{
			return _frictionDecrease;
		}

		public function set frictionDecrease(value:Number):void
		{
			_frictionDecrease = value;
		}

		public function get bounceDecrease():Number
		{
			return _bounceDecrease;
		}

		public function set bounceDecrease(value:Number):void
		{
			_bounceDecrease = value;
		}

		public function get col():int{return _col;}
		public function set col(value:int):void{_col=value;}
		public function get row():int{return _row;}
		public function set row(value:int):void{_row=value;}
		public function get type():int{return _type;}
		
		public function get top():int{
			return _row*TileGlobal.TILE_H;
		}
		public function get bottom():int{
			return (_row+1)*TileGlobal.TILE_H;
		}
		public function get left():int{
			return _col*TileGlobal.TILE_W;
		}
		public function get right():int{
			return (_col+1)*TileGlobal.TILE_W;
		}
		
		public function toString():String{
			return "[ type:"+_type+",col:"+_col+",row:"+_row+" ]";
		}
		
		CONFIG::DEBUG{
			protected var _debugDrawColor:uint=0x000000;
			public function get debugDrawColor():uint{
				return _debugDrawColor;
			}
		};
	}
}