package z_spark.tileengine.system
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.node.RenderNode;

	use namespace zspark_tileegine_internal;
	final public class RenderSystem
	{
		public function RenderSystem(){}
		
		zspark_tileegine_internal function render(rn:RenderNode):void{
			var fpos:Vector2D=rn.movementCmp._pivot;
			rn.renderCmp.render(fpos);
			return ;
			/*CONFIG::DEBUG{
				rn.renderCmp.debugRender(rn.movementCmp._particleVct);
				return;
			}*/
			
			
		}
		
	}
}