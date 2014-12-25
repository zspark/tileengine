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
		protected var _dirArray:Array;//referance
		
		CONFIG::DEBUG{
			protected var debugDrawColor:uint=0x000000;
		};
		
		public function CollisionSolver(row:int,column:int,localPos:Vector2D,dirArray:Array){
			_row=row;
			_col=column;
			_localPos=localPos;
			_dirArray=dirArray;
		}
		
		public function set dirArray(value:Array):void
		{
			_dirArray =value;
		}

		public function testCollision(tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):Boolean
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
		
		protected function handleCollide(spdProjection:Number, tilesize:uint, dirVector:Vector2D,targetPos:Vector2D, targetSpd:Vector2D):Boolean
		{
			//计算目标点到平面的距离；
			var tmp:Vector2D=new Vector2D(_localPos.x+_col*tilesize,_localPos.y+_row*tilesize);
			tmp.sub(targetPos);
			var dis_half:Number=MathUtil.dotProduct(dirVector,tmp);
			if(dis_half>0){
				
				//物体已经穿过了斜面；
				
				/*计算位置*/
				tmp.resetV(dirVector);
				tmp.mul(2*dis_half);
				targetPos.add(tmp);
				
				/*计算速度*/
				tmp.resetV(dirVector);
				tmp.mul(-2*spdProjection);
				targetSpd.add(tmp);
				
				return false;
			}else{
				return false;
			}
		}
		
		CONFIG::DEBUG{
			public function toString():String{
				var s:String;
				if(_dirArray.length==1){
					s=_dirArray[0].toString();
				}else{
					s=_dirArray[0].toString()+" , "+_dirArray[1].toString();
				}
				return "[ type:"+_type+",col:"+_col+",row:"+_row+",dirArray:"+s+" ]";
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