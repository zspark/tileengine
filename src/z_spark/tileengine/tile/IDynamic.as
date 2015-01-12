package z_spark.tileengine.tile
{
import z_spark.tileengine.math.Vector2D;

	public interface IDynamic
	{
		function update(tilesize:uint):int;
		function get fixVector():Vector2D;
	}
}