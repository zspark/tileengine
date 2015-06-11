package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileGlobal;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.TileUtil;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.constance.TileDir;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.constance.TileWorldConst;
	import z_spark.tileengine.system.TileHandleInput;
	import z_spark.tileengine.system.TileHandleOutput;
	
	use namespace zspark_tileegine_internal;
	public class TileSoftWall extends TileBase implements ITile
	{
		private var _tmpVct:Vector2D;
		public function TileSoftWall(tilemap:TileMap, row:int, col:int)
		{
			super(tilemap,row,col);
			_type=TileType.TYPE_SOFT_WALL;
			_tmpVct=new Vector2D();
			CONFIG::DEBUG{
				_debugDrawColor=0x3333FF;
			};
		}
		
		public function handle(tileHandleInput:TileHandleInput,tileHandleOutput:TileHandleOutput):void
		{
			if(TileUtil.isAmbigulty(tileHandleInput.pct,this)){
				tileHandleOutput.handleStatus=TileHandleStatus.ST_DELAY;
				tileHandleOutput.delayHandleArray.push(tileHandleInput.pct);
				return;
			}
			
			var flag:Boolean=true;
			var mc:MovementComponent=tileHandleInput.cn.movementCmp;
			var fpos:Vector2D=tileHandleInput.futurePosition;
			var tmp:Number;
			var dir:int=TileUtil.getEnterDir(fpos,tileHandleInput.pct.position);
			tileHandleOutput.dir=dir;
			switch(dir)
			{
				case TileDir.DIR_TOP:
				{
					tileHandleInput.cn.movementCmp.getCenterPosition(_tmpVct);
					var tile:ITile=tileHandleInput.tileMap.getTileByVector(_tmpVct);
					if(tile.type!=TileType.TYPE_SOFT_WALL){
						tmp=_row*TileGlobal.TILE_H-TileWorldConst.MIN_NUMBER;
						mc.fixPosition(0,-(fpos.y-tmp));
						fpos.y=tmp;
						
						tileHandleInput.pct.position.reset(fpos);
						flag=false;
						
						tileHandleOutput.hitWallParticleCount++;
						tileHandleOutput.fixSpeed.reset(tileHandleInput.cn.movementCmp.speed);
						tileHandleOutput.fixSpeed.mulComponent(-_frictionDecrease,_bounceDecrease-2);
					}
					break;
				}
				case TileDir.DIR_DOWN:
				case TileDir.DIR_LEFT:
				case TileDir.DIR_RIGHT:
				default:{
					break;
				}
			}
			if(flag){
				tileHandleInput.pct.position.reset(tileHandleInput.futurePosition);
			}
			
			tileHandleOutput.handleStatus=TileHandleStatus.ST_FIXED;
		}
	}
}