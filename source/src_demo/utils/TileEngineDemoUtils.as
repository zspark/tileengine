package utils
{
	import flash.display.Sprite;

	public class TileEngineDemoUtils
	{
		public static function getColoredSprite(w:int,h:int,color:uint=0x888888):Sprite{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(color);
			sp.graphics.drawRect(0,0,w,h);
			sp.graphics.endFill();
			return sp;
		}
		
		public static function getRandomColor():uint{
			return (Math.random()*0xFF)<<24|(Math.random()*0xFF)<<16 |(Math.random()*0xFF)<<8|(Math.random()*0xFF);
		}
	}
}