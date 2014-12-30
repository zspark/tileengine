package z_spark.tileengine.tile
{
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.math.MathUtil;
	import z_spark.tileengine.math.Vector2D;

	public class TileBase
	{
		protected var _type:int;
		protected var _row:int;
		protected var _col:int;
		protected var _bounceFactor:Number=.4;
		protected var _frictionFactor:Number=.1;
		
		public function TileBase(type:int,row:int,col:int)
		{
			_type=type;
			_row=row;
			_col=col;
		}
		
		public function get col():int
		{
			return _col;
		}
		
		public function get row():int
		{
			return _row;
		}
		
		protected function fixTarget(planeDir:Vector2D,planeGlobalPos:Vector2D, targetPos:Vector2D,targetSpd:Vector2D):int
		{
			//检查targetSpd的速度方向是否与该格子正方向同向；
			var dir_spd_projection:Number=MathUtil.dotProduct(targetSpd,planeDir);
			if(dir_spd_projection<0){
				//计算目标点到平面的距离；
				planeGlobalPos.sub(targetPos);
				var dis_half:Number=MathUtil.dotProduct(planeDir,planeGlobalPos);
				if(dis_half>0){
					//物体已经穿过了斜面；
					/*计算位置*/
					planeGlobalPos.resetScale(planeDir,2*dis_half);
					targetPos.add(planeGlobalPos);
					
					/*计算速度*/
					planeGlobalPos.resetScale(planeDir,-2*dir_spd_projection);
					targetSpd.add(planeGlobalPos);
					
					/*衰减*/
					planeGlobalPos.resetScale(planeDir,-_bounceFactor);
					planeGlobalPos.addComponentScale(planeDir.x-targetSpd.x,planeDir.y-targetSpd.y,_frictionFactor);
					targetSpd.add(planeGlobalPos);
					
					CONFIG::DEBUG_DRAW_TIMELY{
						if(_recovered){
							TileDebugger.debugDraw(this);
							_intervalId=setTimeout(recoverDebugDraw,200);
							_recovered=false;
						}
					};
					
					return TileHandleStatus.ST_FIXED;
				}
			}
			return TileHandleStatus.ST_PASS;
		}
		
		CONFIG::DEBUG_DRAW_TIMELY{
			private var _intervalId:uint;
			private var _recovered:Boolean=true;
			public function recoverDebugDraw():void{
				if(_recovered)return;
				clearTimeout(_intervalId);
				TileDebugger.debugDraw(this);
				_recovered=true;
			}
		};
		
		CONFIG::DEBUG{
			protected var _debugDrawColor:uint=0x000000;
			public function get debugDrawColor():uint{
				return _debugDrawColor;
			}
		};
	}
}