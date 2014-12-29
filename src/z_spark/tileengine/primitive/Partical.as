package z_spark.tileengine.primitive
{
	import flash.display.Sprite;
	
	import z_spark.as3lib.utils.ColorUtil;
	import z_spark.as3lib.utils.UIFactory;
	
	public class Partical extends Sprite
	{
		public function Partical()
		{
			super();
			var sp:Sprite=UIFactory.getColoredSprite(4,4,ColorUtil.COLOR_PURPLE);
			sp.x=-2;
			sp.y=-2;
			addChild(sp);
		}
	}
}