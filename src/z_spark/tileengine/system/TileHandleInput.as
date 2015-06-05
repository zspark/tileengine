package z_spark.tileengine.system
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.Particle;
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
		
		public var velocity:Vector2D=new Vector2D();
		/**
		 * 未来粒子可能出现的位置，独立向量； 
		 */
		public var futurePosition:Vector2D=new Vector2D();
		public var pct:Particle;
		
		public function clear():void{
			cn=null;
			gravity=null;
			velocity.clear();
			futurePosition.clear();
			pct=null;
			sensor=null;
		}
	}
}