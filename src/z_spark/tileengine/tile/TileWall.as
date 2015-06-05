package z_spark.tileengine.tile
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.TileMap;
	import z_spark.tileengine.TileUtil;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.component.StatusComponent;
	import z_spark.tileengine.constance.TileDir;
	import z_spark.tileengine.constance.TileHandleStatus;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.constance.TileWorldConst;
	import z_spark.tileengine.sensor.event.SensorEvent;
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
			
			var mc:MovementComponent=tileHandleInput.cn.movementCmp;
			var fpos:Vector2D=tileHandleInput.futurePosition;
			var tmp:Number;
//			var dir:int=TileUtil.getEnterDir(fpos,this,_tilemap);
			var dir:int=TileUtil.getEnterDir(fpos,tileHandleInput.pct.position);
			switch(dir)
			{
				case TileDir.DIR_LEFT:
				{
					tmp=_col*TileGlobal.TILE_W-TileWorldConst.MIN_NUMBER;
					mc.fixPosition(-(fpos.x-tmp),0);
					fpos.x=tmp;
					break;
				}
				case TileDir.DIR_RIGHT:
				{
					tmp=(_col+1)*TileGlobal.TILE_W;
					mc.fixPosition(-(fpos.x-tmp),0);
					fpos.x=tmp;
					break;
				}
				case TileDir.DIR_TOP:
				{
					tmp=_row*TileGlobal.TILE_H-TileWorldConst.MIN_NUMBER;
					mc.fixPosition(0,-(fpos.y-tmp));
					fpos.y=tmp;
					break;
				}
				case TileDir.DIR_DOWN:
				{
					tmp=(_row+1)*TileGlobal.TILE_H;
					mc.fixPosition(0,-(fpos.y-tmp));
					fpos.y=tmp;
					break;
				}
				default:
				{
					break;
				}
			}
			
			tileHandleInput.pct.position.reset(fpos);
			
			
			if(tileHandleInput.cn.statusCmp.status==StatusComponent.STATUS_JUMP){
				tileHandleOutput.fixSpeedFlag=true;
				var spdVct:Vector2D=tileHandleOutput.fixSpeed
				spdVct.reset(tileHandleInput.cn.movementCmp.speed);
				switch(dir)
				{
					case TileDir.DIR_LEFT:
					case TileDir.DIR_RIGHT:
					{
						spdVct.mulComponent(_bounceDecrease-1,1-_frictionDecrease);
						break;
					}
					case TileDir.DIR_TOP:
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
			
			tileHandleOutput.dir=dir;
			tileHandleOutput.handleStatus=TileHandleStatus.ST_PASS;
			tileHandleOutput.row=_row;
			tileHandleOutput.col=_col;
			
			if(tileHandleInput.sensor){
				tileHandleInput.sensor.dispatch(SensorEvent.SOR_HIT_TILE_WALL,tileHandleOutput);
			}
			
			return;
		}
		
	}
}