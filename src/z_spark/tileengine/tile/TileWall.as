package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.Particle;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.TileUtil;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.constance.TileDir;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.constance.TileWorldConst;
	import z_spark.tileengine.node.CollisionNode;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 普通格子；包括矩形与三角形的；
	 * @author z_Spark
	 * 
	 */
	public class TileWall extends TileBase implements ITile
	{
		public function TileWall(tilemap:TileMap,row:int,col:int)
		{
			super(tilemap,row,col);
			_type=TileType.TYPE_WALL;
		}
		
		public function update(gravity:Vector2D, cn:CollisionNode,pct:Particle,fpos:Vector2D):int
		{
			if(TileUtil.isAmbigulty(pct,this))return TileHandleStatus.ST_DELAY;
			
 			var dir:int=handle_internal(cn.movementCmp,fpos);
			
			pct.position.reset(fpos);
			
			if(cn.statusCmp.status==StatusComponent.STATUS_JUMP){
				cn.movementCmp.fixSpeedFlag=true;
				
				var spdVct:Vector2D=cn.movementCmp.fixSpeed;
				spdVct.reset(cn.movementCmp.velocity);
				switch(dir)
				{
					case TileDir.DIR_LEFT:
					case TileDir.DIR_RIGHT:
					{
						spdVct.mulComponent(_bounceDecrease-1,1-_frictionDecrease);
						break;
					}
					case TileDir.DIR_TOP:
					{
						spdVct.mulComponent(1-_frictionDecrease,_bounceDecrease-1);
						//					var mag:Number=gravity.mag;
						//					if(spdVct.mag<mag+TileWorldConst.MIN_NUMBER){
						//						cn.statusCmp.status=StatusComponent.STATUS_STAY;
						//					}
						
						break;
					}
					case TileDir.DIR_DOWN:
					{
						spdVct.mulComponent(1-_frictionDecrease,_bounceDecrease-1);
						break;
					}
					default:
					{
						break;
					}
				}
			}
			
			return TileHandleStatus.ST_PASS;
		}
		
		private function handle_internal(mc:MovementComponent,fpos:Vector2D):int{
			var fix:Number;
			var tmp:Number;
			var dir:int=TileUtil.getEnterDir(fpos,this,_tilemap);
			switch(dir)
			{
				case TileDir.DIR_LEFT:
				{
					tmp=_col*TileGlobal.TILE_W-TileWorldConst.MIN_NUMBER;
					fix=fpos.x-tmp;
					fpos.x=tmp;
					mc.fixPos(-fix,0);
					break;
				}
				case TileDir.DIR_RIGHT:
				{
					tmp=(_col+1)*TileGlobal.TILE_W;
					fix=fpos.x-tmp;
					fpos.x=tmp;
					mc.fixPos(-fix,0);
					
					break;
				}
				case TileDir.DIR_TOP:
				{
					tmp=_row*TileGlobal.TILE_H-TileWorldConst.MIN_NUMBER;
					fix=fpos.y-tmp;
					fpos.y=tmp;
					mc.fixPos(0,-fix);
					break;
				}
				case TileDir.DIR_DOWN:
				{
					tmp=(_row+1)*TileGlobal.TILE_H;
					fix=fpos.y-tmp;
					fpos.y=tmp;
					mc.fixPos(0,-fix);
					
					break;
				}
				default:
				{
					break;
				}
			}
			
			return dir;
		}
	}
}