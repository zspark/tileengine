package z_spark.tileengine.entity
{
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.component.RenderCompnent;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.sensor.Sensor;
	

	public interface IEntity
	{
		/*function get acceleration():Vector2D;
		
		function set acceleration(value:Vector2D):void;
		
		function get velocity():Vector2D;
		
		function setacceleration(x:Number,y:Number):void;
		
		function set velocity(value:Vector2D):void ;
		
		function setVelocity(x:Number,y:Number):void ;
		
		function get position():Vector2D;
		
		function set position(value:Vector2D):void;
		
		function setPosition(x:Number,y:Number):void;
		
		function get lastPosition():Vector2D;
		
		function get futurePosition():Vector2D;
		
		function get status():uint;
		
		function addStatus(stat:uint):void;
		
		function removeStatus(stat:uint):void;
		*/
		
		function get sensor():Sensor;
		
		function set sensor(value:Sensor):void;
		
		function get movementComponent():MovementComponent;
		
		function set movementComponent(value:MovementComponent):void;
		
		function get statusComponent():StatusComponent;
		
		function set statusComponent(value:StatusComponent):void;
		
		function get renderComponent():RenderCompnent;
		
		function set renderComponent(value:RenderCompnent):void;
	}
}