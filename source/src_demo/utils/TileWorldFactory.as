package utils
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileGlobal;
	import z_spark.tileengine.TileWorld;
	import z_spark.tileengine.debug.TileDebugger;

	public class TileWorldFactory
	{
		public static function createNewWorld(stage:Stage,mapInfo:Array,debugCanvas:Sprite):TileWorld{
			//创建格子世界；
			var world:TileWorld=new TileWorld(stage);
			
			//设置世界重力方向，360度都可以；
			world.gravity=new Vector2D(0,600);
			
			//设置世界格子大小，可以不是正方形；
			const tileSize:uint=700/25;
			world.tileSize(tileSize,tileSize);
			
			//设置世界格子数据；
			world.tileMap.tileMapRawInfo=mapInfo;
			
			//设置世界最大速率；
			TileGlobal.MAX_VELOCITY=400;
			
			//调试信息：显示格子；
			TileDebugger.initAndDraw(world.tileMap,debugCanvas);
			
			//启动格子世界；
			world.engineStart();
			
			return world;
		}
	}
}