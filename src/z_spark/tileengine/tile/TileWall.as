package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.node.CollisionNode;
	import z_spark.tileengine.primitive.MovementComponent;
	import z_spark.tileengine.primitive.Particle;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 普通格子；包括矩形与三角形的；
	 * @author z_Spark
	 * 
	 */
	public class TileWall extends TileBase implements ITile
	{
		protected var _localPos:Vector2D;//referance;
		protected var _positiveVct:Vector2D;//referance
		
		public function TileWall(tilemap:TileMap,type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(tilemap,type,row,col);
			_localPos=pos;
			CONFIG::DEBUG{
				_dirArray=dirv;
			};
			_positiveVct=dirv[0];
		}
		
		public function testCollision(tilesize:uint,gravity:Vector2D, cn:CollisionNode):int
		{
			/*var globalPos:Vector2D=new Vector2D(_localPos.x+_col*tilesize,_localPos.y+_row*tilesize);
			//计算目标点到平面的距离；
			var tmp:Vector2D=globalPos.clone();
			tmp.sub(cn.movementCmp.position);//新位置到平面上的点的向量；
			var dis:Number=MathUtil.dotProduct(_positiveVct,tmp);
			if(dis>0 ){
				//物体已经穿过了斜面；
				var targetSpd:Vector2D=cn.movementCmp.velocity;
				
				//计算目标点到平面的距离；
				tmp.resetScale(_positiveVct,TileWorldConst.MIN_NUMBER+dis);
				cn.movementCmp.position.add(tmp);
				
				//速度衰减,切向与法向;
				var n:Vector2D=_positiveVct.clone();
				n.mul(MathUtil.dotProduct(targetSpd,_positiveVct));
				var t:Vector2D=n.clone();
				t.sub(targetSpd);
				targetSpd.addScale(n,-(2-_bounceFactor));
				targetSpd.addScale(t,_frictionFactor);
				
				var mag:Number=gravity.mag;
				if(dis<=mag && targetSpd.mag<mag){
					cn.statusCmp.status=StatusComponent.STATUS_STAY;
				}
				
				CONFIG::DEBUG_DRAW_TIMELY{
					if(_recovered){
						TileDebugger.debugDraw(this);
						_intervalId=setTimeout(recoverDebugDraw,200);
						_recovered=false;
					}
				};
				
				return TileHandleStatus.ST_FIXED;
			}else{
				var overlap:Number=dis+cn.physicsCmp.rightO
			}*/
			return TileHandleStatus.ST_PASS;
		}
		
		public function handleTileMove(tilesize:uint, gravity:Vector2D, mc:MovementComponent,pct:Particle,fpos:Vector2D=null):int
		{
			var result:Number;
			var tmp:Number;
			switch(getEnterDir(tilesize,fpos))
			{
				case TileBase.X_MINUS:
				{
					tmp=_col*tilesize;
					result=fpos.x-tmp;
					fpos.x=tmp;
					mc.fixPos(-result,0);
					break;
				}
				case TileBase.X_PLUS:
				{
					tmp=(_col+1)*tilesize;
					result=fpos.x-tmp;
					fpos.x=tmp;
					mc.fixPos(-result,0);
					
					break;
				}
				case TileBase.Y_MINUS:
				{
					tmp=_row*tilesize;
					result=fpos.y-tmp;
					fpos.y=tmp;
					mc.fixPos(0,-result);
					break;
				}
				case TileBase.Y_PLUS:
				{
					tmp=(_row+1)*tilesize;
					result=fpos.y-tmp;
					fpos.y=tmp;
					mc.fixPos(0,-result);
					
					break;
				}
				default:
				{
					break;
				}
			}
			
			pct.position.reset(fpos);
			
			return TileHandleStatus.ST_PASS;
		}
		
		CONFIG::DEBUG{
			public function toString():String{
				return "[ type:"+_type+",col:"+_col+",row:"+_row+",dirVct:"+_positiveVct.toString()+" ]";
			}
			
			private var _dirArray:Array;//referance
			public function get dirArray():Array{
				return _dirArray;
			}
		};
	}
}