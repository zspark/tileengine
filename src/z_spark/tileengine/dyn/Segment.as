package z_spark.tileengine.dyn
{
import z_spark.linearalgebra.Vector2D;
import z_spark.tileengine.tile.IDynamic;

public class Segment implements IDynamic
{
	public function Segment()
	{
	}
	
	public function update(tilesize:uint):int
	{
		return 0;
	}
	
	public function get fixVector():Vector2D
	{
		return null;
	}
}
}