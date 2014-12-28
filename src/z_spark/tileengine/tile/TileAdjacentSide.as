package z_spark.tileengine.tile
{
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.math.MathUtil;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 相邻边的格子；
	 * @author z_Spark
	 * 
	 */
	public class TileAdjacentSide extends TileBase implements ITile
	{
		protected var _localPos:Vector2D;//referance;
		protected var _dirArray:Array;//referance
		
		public function TileAdjacentSide(type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(type,row,col);
			_localPos=pos;
			_dirArray=dirv;
		}
		
		public function testCollision(tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):int
		{
			var globalPos:Vector2D=new Vector2D(_localPos.x+_col*tilesize,_localPos.y+_row*tilesize);
			//获取参与计算的格子方向；
			var right_vct:Vector2D;
			if(_dirArray.length==1)right_vct=_dirArray[0];
			else{
				var tmp:Vector2D=new Vector2D(globalPos.x-targetPos.x+targetSpd.x,globalPos.y-targetPos.y+targetSpd.y);
				//这里做了粗略处理，将==0的差积处理使用了_dirArray[1]的方向向量；
				right_vct=MathUtil.crossPZmag(tmp,targetSpd)>=0 ? _dirArray[1] : _dirArray[0];
			}
			
			return fixTarget(right_vct,globalPos,targetPos,targetSpd);
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
			
			public function get dirArray():Array{
				return _dirArray;
			}
		};
	}
}