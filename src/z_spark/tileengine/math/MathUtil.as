package z_spark.tileengine.math
{
	final public class MathUtil
	{
		public static function dotProduct(v1:Vector2D,v2:Vector2D):Number{
			return v1.x*v2.x+v1.y*v2.y;
		}
		
		public static function add(v1:Vector2D,v2:Vector2D):void{
			v1.add(v2);
		}
	}
}