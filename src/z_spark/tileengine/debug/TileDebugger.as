package z_spark.tileengine.debug
{
	import flash.display.Sprite;
	
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.tile.ITile;
	import z_spark.tileengine.tile.TileNone;

	use namespace zspark_tileegine_internal;
	public class TileDebugger
	{
		public function TileDebugger()
		{
		}
		
		public static function drawFrameLine(tileMap:TileMap,canvas:Sprite):void{
			trace('Draw debug frame line');

			canvas.graphics.clear();
			var mapInfo:Array=tileMap.debugMapInfo;
			for (var i:int=0;i<mapInfo.length;i++){
				for (var j:int=0;j<mapInfo[i].length;j++){
					var tile:ITile=mapInfo[i][j] as ITile;
					if(tile is TileNone)continue;
					tile.debugDraw(canvas.graphics,tileMap.tileSize);
				}
			}
		}
		
	}
}