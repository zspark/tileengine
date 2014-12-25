package z_spark.tileengine
{
	import z_spark.tileengine.constance.TileDir;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.tile.ITile;
	import z_spark.tileengine.tile.TileNone;
	import z_spark.tileengine.tile.TilePlane;
	import z_spark.tileengine.tile.TileSlop;

	use namespace zspark_tileegine_internal;
	public class TileMap
	{
		private static const TYPE_TO_TILE_CLASS:Array=[];
		private static const DIR_TO_LOCALPOS:Array=[];
		private static const DIR_TO_DIRVECTOR:Array=[];
		
		private var _tileSize:uint;
		
		public function TileMap(){
			TYPE_TO_TILE_CLASS[TileType.TYPE_PLANE]=TilePlane;
			TYPE_TO_TILE_CLASS[TileType.TYPE_SLOP]=TileSlop;
			TYPE_TO_TILE_CLASS[TileType.TYPE_NONE]=TileNone;
		}
		

		zspark_tileegine_internal function get tileSize():uint
		{
			return _tileSize;
		}

		zspark_tileegine_internal function set tileSize(value:uint):void
		{
			_tileSize = value;
			DIR_TO_LOCALPOS[TileDir.DIR_LEFT_TOP_OUTER]=new Vector2D(0,0);
			DIR_TO_LOCALPOS[TileDir.DIR_LEFT_TOP]=new Vector2D(_tileSize,0);
			DIR_TO_LOCALPOS[TileDir.DIR_TOP]=new Vector2D(0,0);
			DIR_TO_LOCALPOS[TileDir.DIR_RIGHT_TOP_OUTER]=new Vector2D(_tileSize,0);
			DIR_TO_LOCALPOS[TileDir.DIR_RIGHT_TOP]=new Vector2D(0,0);
			DIR_TO_LOCALPOS[TileDir.DIR_LEFT]=new Vector2D(0,0);
			DIR_TO_LOCALPOS[TileDir.DIR_MIDDLE]=new Vector2D(0,0);
			DIR_TO_LOCALPOS[TileDir.DIR_RIGHT]=new Vector2D(_tileSize,0);
			DIR_TO_LOCALPOS[TileDir.DIR_LEFT_DOWN]=new Vector2D(0,0);
			DIR_TO_LOCALPOS[TileDir.DIR_DOWN]=new Vector2D(0,_tileSize);
			DIR_TO_LOCALPOS[TileDir.DIR_RIGHT_DOWN]=new Vector2D(_tileSize,0);
			
			const F:Number=Math.SQRT2*.5;
			DIR_TO_DIRVECTOR[TileDir.DIR_LEFT_TOP_OUTER]=[new Vector2D(-F,-F)];
			DIR_TO_DIRVECTOR[TileDir.DIR_LEFT_TOP]=[new Vector2D(-F,-F)];
			DIR_TO_DIRVECTOR[TileDir.DIR_TOP]=[new Vector2D(0,-1)];
			DIR_TO_DIRVECTOR[TileDir.DIR_RIGHT_TOP_OUTER]=[new Vector2D(F,-F)];
			DIR_TO_DIRVECTOR[TileDir.DIR_RIGHT_TOP]=[new Vector2D(F,-F)];
			DIR_TO_DIRVECTOR[TileDir.DIR_LEFT]=[new Vector2D(-1,0)];
			DIR_TO_DIRVECTOR[TileDir.DIR_MIDDLE]=[new Vector2D(0,0)];
			DIR_TO_DIRVECTOR[TileDir.DIR_RIGHT]=[new Vector2D(1,0)];
			DIR_TO_DIRVECTOR[TileDir.DIR_LEFT_DOWN]=[new Vector2D(-F,F)];
			DIR_TO_DIRVECTOR[TileDir.DIR_DOWN]=[new Vector2D(0,1)];
			DIR_TO_DIRVECTOR[TileDir.DIR_RIGHT_DOWN]=[new Vector2D(F,F)];
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
			if(_tileSize==0)throw Error("格子尺寸尚未设置，不能参与引擎计算。");
			if(_mapInfo)_mapInfo.length=0;
			else _mapInfo=[];
			//row
			for (var i:int=0,m:int=mapRawInfo.length;i<m;i++){
				_mapInfo[i]=[];
				//col
				for (var j:int=0,n:int=mapRawInfo[i].length;j<n;j++){
					var type:int=mapRawInfo[i][j].type;
					var cls:Class=TYPE_TO_TILE_CLASS[type] as Class;
					if(cls){
						var dir:int=mapRawInfo[i][j].dir;
						var tile:ITile=new cls(i,j,DIR_TO_LOCALPOS[dir],DIR_TO_DIRVECTOR[dir]);
					}else{
						throw Error("格子原始数据错误，有不能被识别或不支持的格子编号！(i,j)=("+i+','+j+"),tileType="+mapRawInfo[i][j].type);
					}
					_mapInfo[i][j]=tile;
				}
			}
		}
		
		CONFIG::DEBUG{
			public function get debugMapInfo():Array{
				return _mapInfo;
			}
		};
		
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
			return _mapInfo[int(yy/_tileSize)][int(xx/_tileSize)];
		}
	}
}



/**
 * switch(mapRawInfo[i][j].dir)
						{
							case TileDir.DIR_TOP:
							{
								tile.rightDirection.set(0,-1);
								break;
							}
							case TileDir.DIR_LEFT:
							{
								tile.rightDirection.set(-1,0);
								break;
							}
							case TileDir.DIR_RIGHT:
							{
								tile.rightDirection.set(1,0);
								break;
							}
							case TileDir.DIR_DOWN:
							{
								tile.rightDirection.set(0,1);
								break;
							}
							default:
							{
								break;
							}
						}
 */