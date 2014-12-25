package z_spark.tileengine.tile
{
	import flash.display.Graphics;
	
	import z_spark.tileengine.math.MathUtil;
	import z_spark.tileengine.math.Vector2D;
	

	public class CollisionSolver implements ITile
	{
		protected var _type:int;
		protected var _row:int;
		protected var _col:int;
		protected var _localPos:Vector2D;//referance;
		protected var _dirVector:Vector2D;//referance
		
		CONFIG::DEBUG{
			protected var debugDrawColor:uint=0x000000;
		};
		
		public function CollisionSolver(roww:int,column:int,localPos:Vector2D,dirV:Vector2D){
			_row=roww;
			_col=column;
			_localPos=localPos;
			_dirVector=dirV;
		}
		
		public function testCollision(tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):Boolean
		{
			//检查targetSpd的速度方向是否与该格子正方向同向；
			var dir_spd_projection:Number=MathUtil.dotProduct(targetSpd,_dirVector);
			if(dir_spd_projection>0){
				return handleSameDir(dir_spd_projection,tilesize, targetPos,targetSpd);
			}else{
				return handleDifferentDir(dir_spd_projection,tilesize,targetPos,targetSpd);
			}
		}
		
		protected function handleDifferentDir(spdProjection:Number, tilesize:uint, targetPos:Vector2D, targetSpd:Vector2D):Boolean
		{
			//计算目标点到平面的距离；
			var tmp:Vector2D=new Vector2D(_localPos.x+_col*tilesize,_localPos.y+_row*tilesize);
			tmp.sub(targetPos);
			var dis_half:Number=MathUtil.dotProduct(_dirVector,tmp);
			if(dis_half>0){
				
				//物体已经穿过了斜面；
				
				/*计算位置*/
				tmp.resetV(_dirVector);
				tmp.mul(2*dis_half);
				targetPos.add(tmp);
				
				/*计算速度*/
				tmp.resetV(_dirVector);
				tmp.mul(-2*spdProjection);
				targetSpd.add(tmp);
				
				return false;
			}else{
				return false;
			}
		}
		
		protected function handleSameDir(spdProjection:Number,tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):Boolean
		{
			return false;
		}
		
		CONFIG::DEBUG{
			protected function toString():String{
				return "[ type:"+_type+",col:"+_col+",row:"+_row+",dirv:"+_dirVector.toString()+" ]";
			}
			
			public function debugDraw(grap:Graphics, sz:int):void
			{
				
			}
			
			public function get col():int
			{
				return _col;
			}
	
			public function get row():int
			{
				return _row;
			}
		};
		
	}
}