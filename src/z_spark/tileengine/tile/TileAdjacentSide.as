package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.MathUtil;
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.ElementStatus;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileWorldConst;
	import z_spark.tileengine.primitive.IElement;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 相邻边的格子；
	 * @author z_Spark
	 * 
	 */
	public class TileAdjacentSide extends TileBase implements ITile
	{
		protected var _localPos:Vector2D;//referance;
		protected var _dirArray:Array;//referance
		
		public function TileAdjacentSide(tilemap:TileMap,type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(tilemap,type,row,col);
			_localPos=pos;
			if(dirv.length!=2)throw new Error("方向必须是2个。");
			_dirArray=dirv;
		}
		
		public function testCollision(tilesize:uint,gravity:Vector2D, elem:IElement):int
		{
			var globalPos:Vector2D=new Vector2D(_localPos.x+_col*tilesize,_localPos.y+_row*tilesize);
			//获取参与计算的格子方向；
			var tmp:Vector2D=globalPos.clone();
			tmp.sub(elem.lastPosition);
			//这里做了粗略处理，将==0的差积处理使用了_dirArray[1]的方向向量；
			var _positiveVct:Vector2D=MathUtil.crossPZmag(tmp,elem.velocity)>=0 ? _dirArray[1] : _dirArray[0];
			tmp=globalPos.clone();
			tmp.sub(elem.position);
			var dis_half:Number=MathUtil.dotProduct(_positiveVct,tmp);
			if(dis_half>0 ){
				var targetSpd:Vector2D=elem.velocity;
				//计算目标点到平面的距离；
				//物体已经穿过了斜面；
				/*位置*/
				tmp.resetScale(_positiveVct,TileWorldConst.MIN_NUMBER_BIGGER_THAN_ONE*dis_half);
				elem.position.add(tmp);
				
				/*速度衰减,切向与法向；*/
				var n:Vector2D=_positiveVct.clone();
				n.mul(MathUtil.dotProduct(targetSpd,_positiveVct));
				var t:Vector2D=n.clone();
				t.sub(targetSpd);
				targetSpd.addScale(n,-(2-_bounceFactor));
				targetSpd.addScale(t,_frictionFactor);
				
				var mag:Number=gravity.mag;
				if(dis_half<=mag && targetSpd.mag<mag){
					elem.removeStatus(ElementStatus.JUMP);
				}
				
				CONFIG::DEBUG_DRAW_TIMELY{
					if(_recovered){
						TileDebugger.debugDraw(this);
						_intervalId=setTimeout(recoverDebugDraw,200);
						_recovered=false;
					}
				};
				
				return TileHandleStatus.ST_FIXED;
			}
			return TileHandleStatus.ST_PASS;
		}
		
		public function handleTileMove(tilesize:uint, gravity:Vector2D, elem:IElement,testPos:Vector2D=null):int
		{
			return TileHandleStatus.ST_PASS;
		}
		
		CONFIG::DEBUG{
			public function toString():String{
				var s:String=_dirArray[0].toString()+" , "+_dirArray[1].toString();
				return "[ type:"+_type+",col:"+_col+",row:"+_row+",dirArray:"+s+" ]";
			}
			
			public function get dirArray():Array{
				return _dirArray;
			}
		};
	}
}