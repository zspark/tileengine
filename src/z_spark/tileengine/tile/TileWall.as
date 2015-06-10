package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.TileUtil;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.constance.TileDir;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.system.TileHandleInput;
	import z_spark.tileengine.system.TileHandleOutput;
	
	use namespace zspark_tileegine_internal;
	/**
	 * @author z_Spark
	 * 
	 */
	public class TileWall extends TileBase implements ITile
	{
		public function TileWall(tilemap:TileMap,row:int,col:int)
		{
			super(tilemap,row,col);
			_type=TileType.TYPE_WALL;
			CONFIG::DEBUG{
				_debugDrawColor=0x000000;
			};
		}
		
		public function handle(tileHandleInput:TileHandleInput,tileHandleOutput:TileHandleOutput):void
		{
			if(TileUtil.isAmbigulty(tileHandleInput.pct,this)){
				tileHandleOutput.handleStatus=TileHandleStatus.ST_DELAY;
				tileHandleOutput.delayHandleArray.push(tileHandleInput.pct);
				return;
			}
			
			var fpos:Vector2D=tileHandleInput.futurePosition;
//			var dir:int=TileUtil.getEnterDir(fpos,this,_tilemap);
			var dir:int=TileUtil.getEnterDir(fpos,tileHandleInput.pct.position);
			TileUtil.fixPosition(_row,_col,dir,tileHandleInput.cn.movementCmp,fpos);
			tileHandleInput.pct.position.reset(fpos);
			
			
			if(tileHandleInput.cn.statusCmp.status==StatusComponent.STATUS_JUMP){
				var spdVct:Vector2D=tileHandleOutput.fixSpeed;
				spdVct.reset(tileHandleInput.cn.movementCmp.speed);
				switch(dir)
				{
					case TileDir.DIR_LEFT:
					case TileDir.DIR_RIGHT:
					{
						spdVct.mulComponent(_bounceDecrease-2,-_frictionDecrease);
						break;
					}
					case TileDir.DIR_TOP:
					case TileDir.DIR_DOWN:
					{
						spdVct.mulComponent(-_frictionDecrease,_bounceDecrease-2);
						break;
					}
					default:
					{
						break;
					}
				}
			}
			
			tileHandleOutput.dir=dir;
			tileHandleOutput.handleStatus=TileHandleStatus.ST_FIXED;
			tileHandleOutput.hitWallParticleCount++;
			
		}
		
	}
}