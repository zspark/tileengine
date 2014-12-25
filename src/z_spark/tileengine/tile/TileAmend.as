package z_spark.tileengine.tile
{
	import flash.display.Graphics;
	
	import z_spark.as3lib.utils.ColorUtil;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.math.Vector2D;


	/**
	 * 补偿格子； 
	 * @author z_Spark
	 * 
	 */
	public class TileAmend extends CollisionSolver
	{
		public function TileAmend(row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(row,col,pos,dirv);
			_type=TileType.TYPE_ITERATOR;
			CONFIG::DEBUG{
				debugDrawColor=ColorUtil.COLOR_RED;
			};
		}
		
		override public function testCollision(tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):Boolean
		{
			super.testCollision(tilesize,targetPos,targetSpd);
			return true;
		}
		
		CONFIG::DEBUG{
			override public function debugDraw(grap:Graphics,sz:int):void{
				grap.lineStyle(1,debugDrawColor);
				grap.moveTo(_col*sz,_row*sz);
				grap.lineTo(_col*sz+sz,_row*sz);
				grap.lineTo(_col*sz+sz,_row*sz+sz);
				grap.lineTo(_col*sz,_row*sz+sz);
				grap.lineTo(_col*sz,_row*sz);
				grap.endFill();
			}
		};

		
	}
}