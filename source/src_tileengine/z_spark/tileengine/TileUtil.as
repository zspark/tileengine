package z_spark.tileengine
{
	import z_spark.linearalgebra.Vector2D;
	import z_spark.tileengine.component.MovementComponent;
	import z_spark.tileengine.constance.TileDir;
	import z_spark.tileengine.constance.TileWorldConst;
	import z_spark.tileengine.system.TileHandleInput;

	use namespace zspark_tileegine_internal;
	final public class TileUtil
	{
		
		/**
		*有个问题就是有可能‘未来点’处在对角线上，此时哪个方向谁先判断
		*最后的方向就是哪边，导致对象在墙的边缘一直不能继续前进；
		*修复这个问题的办法就是将该粒子最后处理，即先处理其他粒子，他们可能会对坐标进行修正，从而再次判断该粒子的时候
		 * 情况发生变化；如果其他粒子没有进行坐标修正，此时哪个方向都可行；
		*/
		/*zspark_tileegine_internal static function getEnterDir(fpos:Vector2D,tile:ITile,tilemap:TileMap):int{
			var yOverlapDis:Number=fpos.y-TileGlobal.TILE_H*tile.row;
			var xOverlapDis:Number=fpos.x-TileGlobal.TILE_W*tile.col;
			var oyOverlapDis:Number=TileGlobal.TILE_H-yOverlapDis;
			var oxOverlapDis:Number=TileGlobal.TILE_W-xOverlapDis;
			
			var adjTile:ITile;
			var result:int;
			var minDis:Number=Number.MAX_VALUE;
			
			if(yOverlapDis<minDis){
				adjTile=tilemap.getTileByRC(tile.row-1<0?0:tile.row-1,tile.col);
				if(adjTile.type==TileType.TYPE_NONE){
					minDis=yOverlapDis;
					result=TileDir.DIR_TOP;
				}
			}
			
			if(xOverlapDis<minDis){
				adjTile=tilemap.getTileByRC(tile.row,tile.col-1<0?0:tile.col-1);
				if(adjTile.type==TileType.TYPE_NONE){
					minDis=xOverlapDis;
					result=TileDir.DIR_LEFT;
				}
			}
			
			if(oyOverlapDis<minDis){
				adjTile=tilemap.getTileByRC(tile.row+1>tilemap.mapRowNum?tile.row:tile.row+1,tile.col);
				if(adjTile.type==TileType.TYPE_NONE){
					minDis=oyOverlapDis;
					result=TileDir.DIR_DOWN;
				}
			}
			
			if(oxOverlapDis<minDis){
				adjTile=tilemap.getTileByRC(tile.row,tile.col+1>tilemap.mapColNum?tile.col:tile.col+1);
				if(adjTile.type==TileType.TYPE_NONE){
					minDis=oxOverlapDis;
					result=TileDir.DIR_RIGHT;
				}
			}
			
			return result;
		}*/
		
		
		zspark_tileegine_internal static function getEnterDir(input:TileHandleInput):int{
			var fpos:Vector2D=input.futurePos;
			var cpox:Vector2D=input.currentPos;
			 
			if(int(fpos.x/TileGlobal.TILE_W)==int(cpox.x/TileGlobal.TILE_W)){
				//垂直方向相同，肯定是从上下进入的；
				if(int(fpos.y/TileGlobal.TILE_H)>int(cpox.y/TileGlobal.TILE_H))return TileDir.DIR_TOP;
				else if(int(fpos.y/TileGlobal.TILE_H)<int(cpox.y/TileGlobal.TILE_H))return TileDir.DIR_DOWN;
				else return -1;
			}else if(int(fpos.x/TileGlobal.TILE_W)>int(cpox.x/TileGlobal.TILE_W)){
				//左边进入;
				if(int(fpos.y/TileGlobal.TILE_H)>int(cpox.y/TileGlobal.TILE_H)){
					//左上进入
					if(input.corner==MovementComponent.RIGHT_TOP)return TileDir.DIR_LEFT;
					else if(input.corner==MovementComponent.LEFT_BOTTOM)return TileDir.DIR_TOP;
					else return TileDir.DIR_LEFT;
				}else if(int(fpos.y/TileGlobal.TILE_H)<int(cpox.y/TileGlobal.TILE_H)){
					//左下；
					if(input.corner==MovementComponent.RIGHT_BOTTOM)return TileDir.DIR_LEFT;
					else if(input.corner==MovementComponent.LEFT_TOP)return TileDir.DIR_DOWN;
					else return TileDir.DIR_LEFT;
				}else return TileDir.DIR_LEFT;
			}else{
				//右边进入
				if(int(fpos.y/TileGlobal.TILE_H)>int(cpox.y/TileGlobal.TILE_H)){
					//右上进入
					if(input.corner==MovementComponent.RIGHT_BOTTOM)return TileDir.DIR_TOP;
					else if(input.corner==MovementComponent.LEFT_TOP)return TileDir.DIR_RIGHT;
					else return TileDir.DIR_RIGHT;
				}else if(int(fpos.y/TileGlobal.TILE_H)<int(cpox.y/TileGlobal.TILE_H)){
					//右下；
					if(input.corner==MovementComponent.RIGHT_TOP)return TileDir.DIR_DOWN;
					else if(input.corner==MovementComponent.LEFT_BOTTOM)return TileDir.DIR_RIGHT;
					else return TileDir.DIR_DOWN;
				}else return TileDir.DIR_RIGHT;
			}
		}
		
		zspark_tileegine_internal static function fixPosition(row:uint,col:uint,toDir:int,fpos:Vector2D,fixVector:Vector2D):void{
			var tmp:Number;
			fixVector.clear();
			switch(toDir)
			{
				case TileDir.DIR_LEFT:
				{
					tmp=col*TileGlobal.TILE_W-TileWorldConst.MIN_NUMBER;
					fixVector.addComponent(-(fpos.x-tmp),0);
					break;
				}
				case TileDir.DIR_RIGHT:
				{
					tmp=(col+1)*TileGlobal.TILE_W;
					fixVector.addComponent(-(fpos.x-tmp),0);
					break;
				}
				case TileDir.DIR_TOP:
				{
					tmp=row*TileGlobal.TILE_H-TileWorldConst.MIN_NUMBER;
					fixVector.addComponent(0,-(fpos.y-tmp));
					break;
				}
				case TileDir.DIR_DOWN:
				{
					tmp=(row+1)*TileGlobal.TILE_H;
					fixVector.addComponent(0,-(fpos.y-tmp));
					break;
				}
				default:
				{
					break;
				}
			}
		}
	}
}