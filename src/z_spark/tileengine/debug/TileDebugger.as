package z_spark.tileengine.debug
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import z_spark.tileengine.TileGlobal;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.tile.ITile;
	import z_spark.tileengine.tile.TileNone;

	use namespace zspark_tileegine_internal;
	public class TileDebugger
	{
		public function TileDebugger(){}
		
		CONFIG::DEBUG
		public static function initAndDraw(tileMap:TileMap,canvas:Sprite):void{
			trace('Draw debug frame line');
			
			_tileMap=tileMap;
			_canvas=canvas;
			canvas.graphics.clear();
			var mapInfo:Array=tileMap.debugMapInfo;
			
			var szw:int=TileGlobal.TILE_W;
			var szh:int=TileGlobal.TILE_H;
			
			const sw:int=_canvas.stage.stageWidth;
			const sh:int=_canvas.stage.stageHeight;
			
			var grap:Graphics=_canvas.graphics;
			const col:uint=0x000000;
			grap.lineStyle(1,col,.5);
			for (var i:int=0;i<mapInfo[0].length;i++){
				grap.moveTo(i*szw,0);
				grap.lineTo(i*szw,sh);
				
			}
			for (var j:int=0;j<mapInfo.length;j++){
				grap.moveTo(0,j*szh);
				grap.lineTo(sw,j*szh);
			}
			grap.endFill();
			
			
			for (i=0;i<mapInfo.length;i++){
				for (j=0;j<mapInfo[i].length;j++){
					var tile:ITile=mapInfo[i][j] as ITile;
					if(tile is TileNone)continue;
					grap.beginFill(tile.debugDrawColor,.5);
					grap.drawRect(tile.left,tile.top,szw,szh);
					grap.endFill();
					
				}
			}
		}
		
		CONFIG::DEBUG{
			private static var _canvas:Sprite;
			private static var _tileMap:TileMap;
		};
		
			
			/*public static function debugDraw_(tile:ITile):void{
				var grap:Graphics=_canvas.graphics;
				var szw:int=TileGlobal.TILE_W;
				var szh:int=TileGlobal.TILE_H;
				var _col:int=tile.col;
				var _row:int=tile.row;
				var _dirArray:Array=tile.dirArray;
				const ltpos:Point=new Point(_col*szw,_row*szw);
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
						debugPosArray=[ltpos,new Point(ltpos.x+szw,ltpos.y),new Point(ltpos.x+szw,ltpos.y+szh),new Point(ltpos.x,ltpos.y+szh)];
						break;
					}
					case TileWorldConst.DIRVECTOR_LEFT_DOWN:
					{
						debugPosArray=[ltpos,new Point(ltpos.x+szw,ltpos.y),new Point(ltpos.x+szw,ltpos.y+szh)];
						break;
					}
					case TileWorldConst.DIRVECTOR_LEFT_TOP:
					{
						debugPosArray=[new Point(ltpos.x+szw,ltpos.y),new Point(ltpos.x+szw,ltpos.y+szh),new Point(ltpos.x,ltpos.y+szh)];
						break;
					}
					case TileWorldConst.DIRVECTOR_RIGHT_DOWN:
					{
						debugPosArray=[ltpos,new Point(ltpos.x+szw,ltpos.y),new Point(ltpos.x,ltpos.y+szh)];
						break;
					}
					case TileWorldConst.DIRVECTOR_RIGHT_TOP:
					{
						debugPosArray=[ltpos,new Point(ltpos.x+szw,ltpos.y+szh),new Point(ltpos.x,ltpos.y+szh)];
						break;
					}
					case TileWorldConst.DIRVECTOR_LEFT_TOP_OUTER:
					{
						debugPosArray=[ltpos,new Point(ltpos.x+szw,ltpos.y+szh)];
						break;
					}
					case TileWorldConst.DIRVECTOR_RIGHT_TOP_OUTER:
					{
						debugPosArray=[new Point(ltpos.x+szw,ltpos.y),new Point(ltpos.x,ltpos.y+szh)];
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
					const centerPos:Point=new Point(ltpos.x+szw*.5,ltpos.y+szh*.5);
					const upv:Vector2D=new Vector2D(0,-1);
					const downv:Vector2D=new Vector2D(0,1);
					const leftv:Vector2D=new Vector2D(-1,0);
					const rightv:Vector2D=new Vector2D(1,0);
					grap.beginFill(debugColor,0.5);
					for each(var v:Vector2D in _dirArray){
						if(MathUtil.dotProduct(v,upv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x,ltpos.y,ltpos.x+szw,ltpos.y]));
						}else if(MathUtil.dotProduct(v,downv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x,ltpos.y+szh,ltpos.x+szw,ltpos.y+szh]));
						}else if(MathUtil.dotProduct(v,leftv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x,ltpos.y,ltpos.x,ltpos.y+szh]));
						}else if(MathUtil.dotProduct(v,rightv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x+szw,ltpos.y,ltpos.x+szw,ltpos.y+szh]));
						}
					}
					grap.endFill();
				}
			}*/
	}
}