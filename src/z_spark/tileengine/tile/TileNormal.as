package z_spark.tileengine.tile
{
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.ElementStatus;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.math.MathUtil;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.primitive.IElement;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 普通格子；包括矩形与三角形的；
	 * @author z_Spark
	 * 
	 */
	public class TileNormal extends TileBase implements ITile
	{
		protected var _localPos:Vector2D;//referance;
		CONFIG::DEBUG{
			protected var _dirArray:Array;//referance
		};
		protected var _positiveVct:Vector2D;//referance
		
		public function TileNormal(type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(type,row,col);
			_localPos=pos;
			CONFIG::DEBUG{
				_dirArray=dirv;
			};
			_positiveVct=dirv[0];
		}
		
		public function testCollision(tilesize:uint,gravity:Vector2D, elem:IElement):int
		{
			var globalPos:Vector2D=new Vector2D(_localPos.x+_col*tilesize,_localPos.y+_row*tilesize);
			//计算目标点到平面的距离；
			var tmp:Vector2D=globalPos.clone();
			tmp.sub(elem.position);
			var dis_half:Number=MathUtil.dotProduct(_positiveVct,tmp);
			if(dis_half>0 ){
//				tmp.reset(globalPos);
//				tmp.sub(elem.lastPosition);
//				dis_half=MathUtil.dotProduct(_positiveVct,tmp);
//				if(dis_half<=0){
					var targetSpd:Vector2D=elem.velocity;
					//计算目标点到平面的距离；
					//物体已经穿过了斜面；
					/*计算位置*/
					tmp.resetScale(_positiveVct,2*dis_half);
					elem.position.addScale(tmp,1.01);
					
					/*计算速度*/
					tmp.resetScale(_positiveVct,-2*MathUtil.dotProduct(targetSpd,_positiveVct));
					targetSpd.add(tmp);
					
					/*衰减*/
					tmp.resetScale(_positiveVct,-_bounceFactor);
					tmp.addComponentScale(_positiveVct.x-targetSpd.x,_positiveVct.y-targetSpd.y,_frictionFactor);
					targetSpd.add(tmp);
					
					var mag:Number=gravity.mag;
					if(dis_half<=mag && targetSpd.mag<mag+.01){
						elem.removeStatus(ElementStatus.JUMP);
						elem.addStatus(ElementStatus.STAY);
					}
					
					CONFIG::DEBUG_DRAW_TIMELY{
						if(_recovered){
							TileDebugger.debugDraw(this);
							_intervalId=setTimeout(recoverDebugDraw,200);
							_recovered=false;
						}
					};
					
					return TileHandleStatus.ST_FIXED;
//				}
			}
			return TileHandleStatus.ST_PASS;
		}
		
		public function handleTileMove(tilesize:uint, gravity:Vector2D, elem:IElement):int
		{
			//计算移动的速度在该格子平面上的切向投影；
			//该投影就是在斜面上的切向速度；
			var globalPos:Vector2D=new Vector2D(_localPos.x+_col*tilesize,_localPos.y+_row*tilesize);
			var tmp:Vector2D=globalPos.clone();
			tmp.sub(elem.position);
			var dis_half:Number=MathUtil.dotProduct(_positiveVct,tmp);
			if(dis_half>0){
				//穿进来了；
				elem.position.addScale(_positiveVct,dis_half+.01);
			}
			
			return TileHandleStatus.ST_PASS;
		}
		
		CONFIG::DEBUG{
			public function toString():String{
				return "[ type:"+_type+",col:"+_col+",row:"+_row+",dirVct:"+_positiveVct.toString()+" ]";
			}
			
			public function get dirArray():Array{
				CONFIG::DEBUG{
					return _dirArray;
				};
				return [_positiveVct];
			}
		};
	}
}