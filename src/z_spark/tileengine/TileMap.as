package z_spark.tileengine
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.constance.TileDir;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.tile.ITile;
	import z_spark.tileengine.tile.TileNone;
	import z_spark.tileengine.tile.TileThrough;
	import z_spark.tileengine.tile.TileWall;

	use namespace zspark_tileegine_internal;
	public class TileMap
	{
		private static const TYPE_TO_TILE_CLASS:Array=[];
		
		public function TileMap(){
			TYPE_TO_TILE_CLASS[TileType.TYPE_WALL]=TileWall;
			TYPE_TO_TILE_CLASS[TileType.TYPE_NONE]=TileNone;
			TYPE_TO_TILE_CLASS[TileType.TYPE_THROUGHT]=TileThrough;
		}

//		TODO:waiting..
//		private var _tileRawMapInfoURL:String;
//		public function readTileMapInfo(mapRawInfoUrl:String):void{
//			_tileRawMapInfoURL=mapRawInfoUrl;
//			
//			var info:String=FileUtil.read(mapRawInfoUrl);
//			var mapRawInfo:Array=[];
//			var tmpA:Array=info.split('\n\r|\n|\r');
//			for (var i:int=0,m:int=tmpA.length;i<m; i++){
//				mapRawInfo[i]=tmpA[i].split(',');
//			}
//			tileMapRawInfo=mapRawInfo;
//		}
		
		private var _mapInfo:Array;
		/**
		 * A 2*2 Matrix; 
		 * @param mapInfo
		 * 
		 */
		public function set tileMapRawInfo(mapRawInfo:Array):void{
			if(TileGlobal.TILE_H*TileGlobal.TILE_W==0)throw Error("格子尺寸尚未设置或参数不合法。");
			if(_mapInfo)_mapInfo.length=0;
			else _mapInfo=[];
			//row
			for (var i:int=0,m:int=mapRawInfo.length;i<m;i++){
				_mapInfo[i]=[];
				//col
				for (var j:int=0,n:int=mapRawInfo[i].length;j<n;j++){
					var obj:Object=mapRawInfo[i][j];
					var cls:Class=TYPE_TO_TILE_CLASS[obj.type] as Class;
					if(cls){
						var tile:ITile=new cls(this,i,j);
						/*if(tile is IDynamic){
							_dynamicTiles.push(tile);
						}*/
					}else{
						throw Error("格子原始数据错误，有不能被识别或不支持的格子编号！(i,j)=("+i+','+j+"),tileType="+mapRawInfo[i][j].type);
					}
					_mapInfo[i][j]=tile;
				}
			}
		}
		
		private var _dynamicTiles:Array=[];
		/**
		 * 更新格子数据，更新场景状态；
		 * 比如电梯格子，需要上下走动；
		 * 场景的更新在元素更新之前； 
		 * 
		 */
		zspark_tileegine_internal function updateTiles():void{
			/*for each(var dyn:IDynamic in _dynamicTiles){
				dyn.update();
			}*/
		}
		
		public function get mapColNum():uint{
			return _mapInfo[0].length;
		}
		
		public function get mapRowNum():uint{
			return _mapInfo.length;
		}
		
		public function getTileByRC(row:uint,col:uint):ITile{
			return _mapInfo[row][col];
		}
		
		/**
		 * [xx,yy) 
		 * @param xx
		 * @param yy
		 * @return 
		 * 
		 */
		public function getTileByXY(xx:int,yy:int):ITile{
			return _mapInfo[int(yy/TileGlobal.TILE_H)][int(xx/TileGlobal.TILE_W)];
		}
		
		public function getTileByVector(vct:Vector2D):ITile{
			return _mapInfo[int(vct.y/TileGlobal.TILE_H)][int(vct.x/TileGlobal.TILE_W)];
		}
		
		public function switchTileByXY(aTile:ITile,targetTilex:int,targetTiley:int):void{
			
			var r:int=int(targetTiley/TileGlobal.TILE_H);
			var c:int=int(targetTilex/TileGlobal.TILE_W);
			var bTile:ITile=_mapInfo[r][c];
			if(bTile==null)return;
			_mapInfo[bTile.row][bTile.col]=aTile;
			_mapInfo[aTile.row][aTile.col]=bTile;
			
			var aTileRow:int=aTile.row;
			var aTileCol:int=aTile.col;
			aTile.row=bTile.row;
			aTile.col=bTile.col;
			bTile.row=aTileRow;
			bTile.col=aTileCol;
		}
		
		public function switchTileByDir(aTile:ITile,dir:int):void{
			var bTile:ITile;
			switch(dir)
			{
				case TileDir.DIR_DOWN:
				{
					bTile=_mapInfo[aTile.row+1][aTile.col];
					break;
				}
				case TileDir.DIR_TOP:
				{
					bTile=_mapInfo[aTile.row-1][aTile.col];
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			if(bTile==null)return;
			_mapInfo[bTile.row][bTile.col]=aTile;
			_mapInfo[aTile.row][aTile.col]=bTile;
			
			var aTileRow:int=aTile.row;
			var aTileCol:int=aTile.col;
			aTile.row=bTile.row;
			aTile.col=bTile.col;
			bTile.row=aTileRow;
			bTile.col=aTileCol;
		}
		
		public function toString():String{
			return "[TileMap] col="+mapColNum+" row="+mapRowNum;
		}
		
		CONFIG::DEBUG
		public function get debugMapInfo():Array{
			return _mapInfo;
		}
		
	}
}