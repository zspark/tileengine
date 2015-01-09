package z_spark.tileengine.tile
{
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.math.MathUtil;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.primitive.IElement;

	public class TileBase
	{
		protected var _tilemap:TileMap;
		protected var _type:int;
		protected var _row:int;	
		protected var _col:int;
		protected var _bounceFactor:Number=.7;
		protected var _frictionFactor:Number=.5;
		
		public function TileBase(tilemap:TileMap,type:int,row:int,col:int)
		{
			_tilemap=tilemap;
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
		
		public function get type():int
		{
			return _type;
		}
		
		protected function fixTarget(positiveDir:Vector2D,gravity:Vector2D,dis_half:Number, elem:IElement):int
		{
			var targetSpd:Vector2D=elem.velocity;
			//计算目标点到平面的距离；
			//物体已经穿过了斜面；
			/*计算位置*/
			var tmp:Vector2D=new Vector2D();
			tmp.resetScale(positiveDir,2*dis_half);
			elem.position.add(tmp);
			
			/*计算速度*/
			tmp.resetScale(positiveDir,-2*MathUtil.dotProduct(targetSpd,positiveDir));
			targetSpd.add(tmp);
			
			/*衰减*/
			tmp.resetScale(positiveDir,-_bounceFactor);
			tmp.addComponentScale(positiveDir.x-targetSpd.x,positiveDir.y-targetSpd.y,_frictionFactor);
			targetSpd.add(tmp);
			
			CONFIG::DEBUG_DRAW_TIMELY{
				if(_recovered){
					TileDebugger.debugDraw(this);
					_intervalId=setTimeout(recoverDebugDraw,200);
					_recovered=false;
				}
			};
			
			return TileHandleStatus.ST_FIXED;
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