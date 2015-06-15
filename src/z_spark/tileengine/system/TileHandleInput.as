package z_spark.tileengine.system
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.node.CollisionNode;
	import z_spark.tileengine.sensor.Sensor;
	

	public final class TileHandleInput
	{
		public var cn:CollisionNode;
		public var sensor:Sensor;
		/**
		 * 重力，引用向量； 
		 */
		public var gravity:Vector2D;
		public var tileMap:TileMap;
		
		/**
		 * 独立向量； 
		 */
		public var futurePivot:Vector2D=new Vector2D();
		
		public var corner:uint=0;
		
		public var currentPos:Vector2D=new Vector2D();
		public var futurePos:Vector2D=new Vector2D();
		
		public function clear():void{
			cn=null;
			gravity=null;
			futurePivot.clear();
			futurePos.clear();
			currentPos.clear();
			sensor=null;
			tileMap=null;
		}
	}
}