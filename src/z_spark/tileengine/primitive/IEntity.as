package z_spark.tileengine.primitive
{
	

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
		
		function frameEndCall(tile:ITile,handleStatus:int):void;*/
		
		function get mc():MovementComponent;
		
		function set mc(value:MovementComponent):void;
		
		function get sc():StatusComponent;
		
		function set sc(value:StatusComponent):void;
		
		function get rc():RenderCompnent;
		
		function set rc(value:RenderCompnent):void;
	}
}