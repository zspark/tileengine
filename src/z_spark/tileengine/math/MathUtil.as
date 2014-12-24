package z_spark.tileengine.math
{
	final public class MathUtil
	{
		/**
		 * 计算点积 ；
		 * @param v1
		 * @param v2
		 * @return 
		 * 
		 */
		public static function dotProduct(v1:Vector2D,v2:Vector2D):Number{
			return v1.x*v2.x+v1.y*v2.y;
		}
		
		public static function add(v1:Vector2D,v2:Vector2D):void{
			v1.add(v2);
		}
		
		/**
		 * 计算v2向量在v1向量的基础上旋转的正负；
		 * 参考向量差乘； 
		 * @param v1
		 * @param v2
		 * @return 
		 * 
		 */
		public static function crossPZmag(v1:Vector2D,v2:Vector2D):Number{
			return v1.x*v2.y-v1.y*v2.x;
		}
	}
}