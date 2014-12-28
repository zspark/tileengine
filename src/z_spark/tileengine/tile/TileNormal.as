package z_spark.tileengine.tile
{
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.math.Vector2D;
	
	use namespace zspark_tileegine_internal;
	/**
	 * 普通格子；包括矩形与三角形的；
	 * @author z_Spark
	 * 
	 */
	public class TileNormal extends TileBase implements ITile
	{
		protected var _localPos:Vector2D;//referance;
		CONFIG::DEBUG{
			protected var _dirArray:Array;//referance
		};
		protected var _dirVct:Vector2D;//referance
		
		public function TileNormal(type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(type,row,col);
			_localPos=pos;
			CONFIG::DEBUG{
				_dirArray=dirv;
			};
			_dirVct=dirv[0];
		}
		
		public function testCollision(tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):int
		{
			var globalPos:Vector2D=new Vector2D(_localPos.x+_col*tilesize,_localPos.y+_row*tilesize);
			return fixTarget(_dirVct,globalPos,targetPos,targetSpd);
		}
		
		CONFIG::DEBUG{
			public function toString():String{
				return "[ type:"+_type+",col:"+_col+",row:"+_row+",dirVct:"+_dirVct.toString()+" ]";
			}
			
			public function get dirArray():Array{
				CONFIG::DEBUG{
					return _dirArray;
				};
				return [_dirVct];
			}
		};
	}
}