package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.constance.TileDir;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.Particle;

	public class TileBase
	{
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
		
		/**
		 * 判断从哪个方向进入格子；
		 * 进入的方向只有4个，上下左右；
		 * @param tilesize
		 * @param fpos
		 * @return 
		 * 
		 */		
//		protected function getEnterDir(tilesize:int,fpos:Vector2D,mc:MovementComponent):String{
//			/*
//			 * 新的算法采用判断‘之前位置’在墙的方向而决定点的来向；
//			 * */
//			
//			
//			
//		}
		/*
		*old version
		*有个问题就是有可能‘未来点’处在对角线上，此时哪个方向谁先判断
		*最后的方向就是哪边，导致对象在墙的边缘一直不能继续前进；*/
		protected function getEnterDir(fpos:Vector2D):int{
			var yOverlapDis:Number=fpos.y-TileGlobal.TILE_H*_row;
			var xOverlapDis:Number=fpos.x-TileGlobal.TILE_W*_col;
			var oyOverlapDis:Number=TileGlobal.TILE_H-yOverlapDis;
			var oxOverlapDis:Number=TileGlobal.TILE_W-xOverlapDis;
			
			var result:int;
			var tile:ITile;
			var minDis:Number=Number.MAX_VALUE;
			
			if(yOverlapDis<minDis){
				tile=_tilemap.getTileByRC(row-1,col);
				if(tile.type==TileType.TYPE_NONE){
					minDis=yOverlapDis;
					result=TileDir.DIR_TOP;
				}
			}
			
			if(xOverlapDis<minDis){
				tile=_tilemap.getTileByRC(row,col-1);
				if(tile.type==TileType.TYPE_NONE){
					minDis=xOverlapDis;
					result=TileDir.DIR_LEFT;
				}
			}
			
			if(oyOverlapDis<minDis){
				tile=_tilemap.getTileByRC(row+1,col);
				if(tile.type==TileType.TYPE_NONE){
					minDis=oyOverlapDis;
					result=TileDir.DIR_DOWN;
				}
			}
			
			if(oxOverlapDis<minDis){
				tile=_tilemap.getTileByRC(row,col+1);
				if(tile.type==TileType.TYPE_NONE){
					minDis=oxOverlapDis;
					result=TileDir.DIR_RIGHT;
				}
			}
			
			return result;
		}
		
		/**
		 * true 意思就是有二义性，不明确，需要延迟处理的粒子； 
		 * @param pct
		 * @return 
		 * 
		 */
		protected function checkAmbigulty(pct:Particle):Boolean{
			var result:Boolean=false;
			if(pct.status==Particle.NO_CHECK){
				if(pct.position.x<=left){
					if(pct.position.y<=top || pct.position.y>=bottom)result=true;
					else result=false;
				}else if(pct.position.x>=right){
					if(pct.position.y<=top || pct.position.y>=bottom)result=true;
					else result=false;
				}
				
				pct.status=result?Particle.AMBIGUOUS:Particle.ABSOLUTE;
			}
			return result;
		}
		
		public function toString():String{
			return "[ type:"+_type+",col:"+_col+",row:"+_row+" ]";
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