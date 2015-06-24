package z_spark.tileengine.component
{
	import flash.display.Sprite;
	
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.zspark_tileegine_internal;
	
	use namespace zspark_tileegine_internal;
	public class RenderCompnent
	{
		private var _sprite:Sprite;
		private var _scaleX:Number=1.0;
		private var _scaleY:Number=1.0;
		
		public function RenderCompnent(){}
		
		public function set sprite(value:Sprite):void
		{
			_sprite = value;
		}

		zspark_tileegine_internal function render(globalPos:Vector2D):void{
			/*_sprite.scaleX=_scaleX;
			_sprite.scaleY=_scaleY;*/
			_sprite.x=globalPos.x;
			_sprite.y=globalPos.y;
			
//			_sprite.x=int(globalPos.x);
		}
		
		/*CONFIG::DEBUG
		zspark_tileegine_internal function debugRender(vct:Vector.<Particle>):void{
			if(_sprite==null)return;
			_sprite.graphics.clear();
			_sprite.graphics.beginFill(0xFF0000,.5);
			for each(var pct:Particle in vct){
				_sprite.graphics.drawRect(pct.position.x,pct.position.y,1,1);
			}
			_sprite.graphics.endFill();
		}*/
		
	}
}