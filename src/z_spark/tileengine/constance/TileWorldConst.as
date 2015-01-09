package z_spark.tileengine.constance
{
	import z_spark.tileengine.math.Vector2D;

	public class TileWorldConst
	{
		private static const F:Number=Math.SQRT2*.5;
		
		public static const DIRVECTOR_LEFT_TOP_OUTER:Array=[new Vector2D(-F,-F)];
		public static const DIRVECTOR_RIGHT_TOP_OUTER:Array=[new Vector2D(F,-F)];
		public static const DIRVECTOR_LEFT_TOP:Array=[new Vector2D(-F,-F)];
		public static const DIRVECTOR_TOP:Array=[new Vector2D(0,-1)];
		public static const DIRVECTOR_RIGHT_TOP:Array=[new Vector2D(F,-F)];
		public static const DIRVECTOR_LEFT:Array=[new Vector2D(-1,0)];
		public static const DIRVECTOR_MIDDLE:Array=[new Vector2D(0,0)];
		public static const DIRVECTOR_RIGHT:Array=[new Vector2D(1,0)];
		public static const DIRVECTOR_LEFT_DOWN:Array=[new Vector2D(-F,F)];
		public static const DIRVECTOR_DOWN:Array=[new Vector2D(0,1)];
		public static const DIRVECTOR_RIGHT_DOWN:Array=[new Vector2D(F,F)];
		public static const DIRVECTOR_LEFT_AND_TOP:Array=[new Vector2D(0,-1),new Vector2D(-1,0)];
		public static const DIRVECTOR_RIGHT_AND_TOP:Array=[new Vector2D(1,0),new Vector2D(0,-1)];
		
		public static const MIN_NUMBER:Number=.000001;
		public static const MIN_NUMBER_BIGGER_THAN_ONE:Number=1+MIN_NUMBER;
	}
}