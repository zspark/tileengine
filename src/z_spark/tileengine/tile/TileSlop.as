package z_spark.tileengine.tile
{
	import flash.display.Graphics;
	
	import z_spark.as3lib.utils.ColorUtil;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.math.Vector2D;

	use namespace zspark_tileegine_internal;
	/**
	 * 平地表； 
	 * @author z_Spark
	 * 
	 */
	public class TileSlop extends CollisionSolver
	{
		public function TileSlop(row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(row,col,pos,dirv);
			_type=TileType.TYPE_SLOP;
			CONFIG::DEBUG{
				debugDrawColor=ColorUtil.COLOR_GRAY;
			};
		}
		
		CONFIG::DEBUG{
			override public function debugDraw(grap:Graphics,sz:int):void{
				grap.lineStyle(1,debugDrawColor);
				if(_localPos.x==0 && _localPos.y==0){
					
					grap.moveTo(_col*sz,_row*sz);
					grap.lineTo(_col*sz+sz,_row*sz+sz);
					grap.lineTo(_col*sz,_row*sz+sz);
					grap.lineTo(_col*sz,_row*sz);
				}else{
					grap.moveTo(_col*sz+sz,_row*sz);
					grap.lineTo(_col*sz+sz,_row*sz+sz);
					grap.lineTo(_col*sz,_row*sz+sz);
					grap.lineTo(_col*sz+sz,_row*sz);
				}
				grap.endFill();
			}
		};
	}
}