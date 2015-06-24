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
			
			var mc:MovementComponent=tileHandleInput.cn.movementCmp;
			if(tileHandleInput.corner==MovementComponent.LEFT_BOTTOM ||
				tileHandleInput.corner==MovementComponent.RIGHT_BOTTOM){
				
				var fpos:Vector2D=tileHandleInput.futurePos;
				var tmp:Number;
				var dir:int=TileUtil.getEnterDir(tileHandleInput);
				tileHandleOutput.dir=dir;
				switch(dir)
				{
					case TileDir.DIR_TOP:
					{
						tmp=_row*TileGlobal.TILE_H-TileWorldConst.MIN_NUMBER;
						tileHandleOutput.fixPivot.resetComponent(0,-(fpos.y-tmp));
						
						tileHandleOutput.hitWallParticleCount++;
						tileHandleOutput.fixSpeed.reset(tileHandleInput.cn.movementCmp.speed);
						tileHandleOutput.fixSpeed.mulComponent(-_frictionDecrease,_bounceDecrease-2);
						break;
					}
					case TileDir.DIR_DOWN:
					case TileDir.DIR_LEFT:
					case TileDir.DIR_RIGHT:
					default:{
						break;
					}
				}
			}
			tileHandleOutput.handleStatus=TileHandleStatus.ST_FIXED;
		}
	}
}