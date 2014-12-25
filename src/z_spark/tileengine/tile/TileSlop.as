package z_spark.tileengine.tile
{
	import flash.display.Graphics;
	
	import z_spark.as3lib.utils.ColorUtil;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.math.MathUtil;
	import z_spark.tileengine.math.Vector2D;

	use namespace zspark_tileegine_internal;
	/**
	 * 平地表； 
	 * @author z_Spark
	 * 
	 */
	public class TileSlop extends CollisionSolver
	{
		protected var _amendVctArray:Array;
		public function TileSlop(row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(row,col,pos,dirv);
			_type=TileType.TYPE_SLOP;
			CONFIG::DEBUG{
				debugDrawColor=ColorUtil.COLOR_GRAY;
			};
		}
		
		override public function testCollision(tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):Boolean
		{
			//获取参与计算的格子正方向；
			var right_vct:Vector2D;
			if(_dirArray.length==1)right_vct=_dirArray[0];
			else{
				var old_pos_to_local_pos_vct:Vector2D=new Vector2D(_localPos.x-targetPos.x+targetSpd.x,_localPos.y-targetPos.y+targetSpd.y);
				//这里做了粗略处理，将==0的差积处理使用了_dirArray[1]的方向向量；
				right_vct=MathUtil.crossPZmag(old_pos_to_local_pos_vct,targetSpd)>=0 ? _dirArray[1] : _dirArray[0];
			}
			
			//检查targetSpd的速度方向是否与该格子正方向同向；
			var dir_spd_projection:Number=MathUtil.dotProduct(targetSpd,right_vct);
			if(dir_spd_projection<0){
				return handleCollide(dir_spd_projection,tilesize,right_vct, targetPos,targetSpd);
			}else return false;
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