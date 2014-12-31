package z_spark.tileengine.debug
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.TileWorldConst;
	import z_spark.tileengine.math.MathUtil;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.tile.ITile;
	import z_spark.tileengine.tile.TileNone;

	use namespace zspark_tileegine_internal;
	public class TileDebugger
	{
		public function TileDebugger()
		{
		}
		public static function initAndDraw(tileMap:TileMap,canvas:Sprite):void{
			CONFIG::DEBUG{
				trace('Draw debug frame line');
				
				_tileMap=tileMap;
				_canvas=canvas;
				canvas.graphics.clear();
				var mapInfo:Array=tileMap.debugMapInfo;
				for (var i:int=0;i<mapInfo.length;i++){
					for (var j:int=0;j<mapInfo[i].length;j++){
						var tile:ITile=mapInfo[i][j] as ITile;
						if(tile is TileNone)continue;
						debugDraw(tile);
					}
				}
			};
		}
		CONFIG::DEBUG{
			private static var _canvas:Sprite;
			private static var _tileMap:TileMap;
			
			public static function debugDraw(tile:ITile):void{
				var grap:Graphics=_canvas.graphics;
				var sz:int=_tileMap.tileSize;
				var _col:int=tile.col;
				var _row:int=tile.row;
				var _dirArray:Array=tile.dirArray;
				const ltpos:Point=new Point(_col*sz,_row*sz);
				var debugPosArray:Array=[];
				
				switch(_dirArray)
				{
					case TileWorldConst.DIRVECTOR_DOWN:
					case TileWorldConst.DIRVECTOR_LEFT:
					case TileWorldConst.DIRVECTOR_TOP:
					case TileWorldConst.DIRVECTOR_RIGHT:
					case TileWorldConst.DIRVECTOR_LEFT_AND_TOP:
					case TileWorldConst.DIRVECTOR_RIGHT_AND_TOP:
					{
						debugPosArray=[ltpos,new Point(ltpos.x+sz,ltpos.y),new Point(ltpos.x+sz,ltpos.y+sz),new Point(ltpos.x,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_LEFT_DOWN:
					{
						debugPosArray=[ltpos,new Point(ltpos.x+sz,ltpos.y),new Point(ltpos.x+sz,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_LEFT_TOP:
					{
						debugPosArray=[new Point(ltpos.x+sz,ltpos.y),new Point(ltpos.x+sz,ltpos.y+sz),new Point(ltpos.x,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_RIGHT_DOWN:
					{
						debugPosArray=[ltpos,new Point(ltpos.x+sz,ltpos.y),new Point(ltpos.x,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_RIGHT_TOP:
					{
						debugPosArray=[ltpos,new Point(ltpos.x+sz,ltpos.y+sz),new Point(ltpos.x,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_LEFT_TOP_OUTER:
					{
						debugPosArray=[ltpos,new Point(ltpos.x+sz,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_RIGHT_TOP_OUTER:
					{
						debugPosArray=[new Point(ltpos.x+sz,ltpos.y),new Point(ltpos.x,ltpos.y+sz)];
						break;
					}
					default:
					{
						break;
					}
				}
				
				const debugColor:uint=0x42621c;
				if(debugPosArray.length>0){
					grap.lineStyle(1,debugColor);
					for (var i:int=0;i<debugPosArray.length;i++){
						if(i==0)grap.moveTo(debugPosArray[i].x,debugPosArray[i].y);
						else{
							grap.lineTo(debugPosArray[i].x,debugPosArray[i].y);
						}
					}
					grap.lineTo(debugPosArray[0].x,debugPosArray[0].y);
					
					//画方向；
					const centerPos:Point=new Point(ltpos.x+sz*.5,ltpos.y+sz*.5);
					const upv:Vector2D=new Vector2D(0,-1);
					const downv:Vector2D=new Vector2D(0,1);
					const leftv:Vector2D=new Vector2D(-1,0);
					const rightv:Vector2D=new Vector2D(1,0);
					grap.beginFill(debugColor,0.5);
					for each(var v:Vector2D in _dirArray){
						if(MathUtil.dotProduct(v,upv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x,ltpos.y,ltpos.x+sz,ltpos.y]));
						}else if(MathUtil.dotProduct(v,downv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x,ltpos.y+sz,ltpos.x+sz,ltpos.y+sz]));
						}else if(MathUtil.dotProduct(v,leftv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x,ltpos.y,ltpos.x,ltpos.y+sz]));
						}else if(MathUtil.dotProduct(v,rightv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x+sz,ltpos.y,ltpos.x+sz,ltpos.y+sz]));
						}
					}
					grap.endFill();
				}
			}
		};
		
	}
}