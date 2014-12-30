package z_spark.tileengine.tile
{
	import flash.utils.setTimeout;
	
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.debug.TileDebugger;
	import z_spark.tileengine.math.MathUtil;
	import z_spark.tileengine.math.Vector2D;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 穿越格子，能做正常的穿越逻辑；
	 * @author z_Spark
	 * 
	 */
	public class TileThrough extends TileBase implements ITile
	{
		protected var _localPos:Vector2D;//referance;
		CONFIG::DEBUG{
			protected var _dirArray:Array;//referance
		};
		protected var _dirVct:Vector2D;//referance
		
		public function TileThrough(type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(type,row,col);
			_localPos=pos;
			CONFIG::DEBUG{
				_dirArray=dirv;
			};
			_dirVct=dirv[0];
		}
		
		public function testCollision(tilesize:uint,gravity:Vector2D, targetPos:Vector2D,targetSpd:Vector2D):int
		{
			var globalPos:Vector2D=new Vector2D(_localPos.x+_col*tilesize,_localPos.y+_row*tilesize);
			//检查targetSpd的速度方向是否与该格子正方向同向；
			var dir_spd_projection:Number=MathUtil.dotProduct(targetSpd,_dirVct);
			if(dir_spd_projection<0){
				
				//计算目标点到平面的距离；
				var tmp:Vector2D=globalPos.clone();
				tmp.sub(targetPos);
				var dis_half:Number=MathUtil.dotProduct(_dirVct,tmp);
				tmp.reset(globalPos);
				tmp.subComponent(targetPos.x-targetSpd.x,targetPos.y-targetSpd.y);
				var dis_half2:Number=MathUtil.dotProduct(_dirVct,tmp);
				if(dis_half>0 && dis_half2<=0){
					//物体已经穿过了斜面；
					/*计算位置*/
					tmp.resetScale(_dirVct,2*dis_half);
					targetPos.add(tmp);
					
					/*计算速度*/
					tmp.resetScale(_dirVct,-2*dir_spd_projection);
					targetSpd.add(tmp);
					
					/*衰减*/
					tmp.resetScale(_dirVct,-_bounceFactor);
					tmp.addComponentScale(_dirVct.x-targetSpd.x,_dirVct.y-targetSpd.y,_frictionFactor);
					targetSpd.add(tmp);
					
					return TileHandleStatus.ST_FIXED;
				}
			}
			return TileHandleStatus.ST_PASS;
		}
		
		CONFIG::DEBUG{
			public function toString():String{
				return "[ type:"+_type+",col:"+_col+",row:"+_row+",dirVct:"+_dirVct.toString()+" ]";
			}
			
			public function get dirArray():Array{
				CONFIG::DEBUG{
					return _dirArray;
				};
				return [_dirVct];
			}
		};
	}
}