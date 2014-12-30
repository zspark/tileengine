package z_spark.tileengine.tile
{
	import z_spark.tileengine.constance.TileType;
	import z_spark.tileengine.math.MathUtil;
	import z_spark.tileengine.math.Vector2D;


	/**
	 * 纯补偿格子； 
	 * @author z_Spark
	 * 
	 */
	final public class TileAmend extends TileBase implements ITile
	{
		private var _amendDirArray:Array;
		private var _amendPos:Vector2D;
		
		public function TileAmend(type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(type,row,col);
			_amendPos=pos;
			_amendDirArray=dirv;
			_type=TileType.TYPE_AMEND;
		}

		private function refreshAmendInfo(tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):void{
			var _curAmendDir:Vector2D;
			//方向相同者抛弃；
			for (var i:int=0;i<_amendDirArray.length;i++){
				var v:Vector2D=_amendDirArray[i];
				if(MathUtil.dotProduct(v,targetSpd)>=0){
					_curAmendDir=v;
					return;
				}
				else{
				}
			}
			
			//方向没有相同的
			var right_vct:Vector2D;
			if(_amendDirArray.length==1)right_vct=_amendDirArray[0];
			else{
				var old_pos_to_amend_pos_vct:Vector2D=new Vector2D(_amendPos.x+_col*tilesize-targetPos.x+targetSpd.x,_amendPos.y+_row*tilesize-targetPos.y+targetSpd.y);
				//这里做了粗略处理，将==0的差积处理使用了_dirArray[1]的方向向量；
				right_vct=MathUtil.crossPZmag(old_pos_to_amend_pos_vct,targetSpd)>=0 ? _amendDirArray[1] : _amendDirArray[0];
			}
		}
		
		public function testCollision(tilesize:uint,gravity:Vector2D, targetPos:Vector2D,targetSpd:Vector2D):int
		{
			return 0;
		}
		
		CONFIG::DEBUG{
			public function toString():String{
				return "";
			}
			
			public function get dirArray():Array{
				return _amendDirArray;
			}
		};
	}
}