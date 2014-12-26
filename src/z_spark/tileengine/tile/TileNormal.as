package z_spark.tileengine.tile
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import z_spark.as3lib.utils.ColorUtil;
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.TileWorldConst;
	import z_spark.tileengine.math.MathUtil;
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
		protected var _dirArray:Array;//referance
		
		public function TileNormal(type:int,row:int,col:int,pos:Vector2D,dirv:Array)
		{
			super(type,row,col);
			_localPos=pos;
			_dirArray=dirv;
		}
		
		public function testCollision(tilesize:uint, targetPos:Vector2D,targetSpd:Vector2D):Boolean
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
			fixTarget(right_vct,globalPos,targetPos,targetSpd);
			
			return false;
		}
		
		CONFIG::DEBUG{
			protected var debugDrawColor:uint=0x000000;
			public function toString():String{
				var s:String;
				if(_dirArray.length==1){
					s=_dirArray[0].toString();
				}else{
					s=_dirArray[0].toString()+" , "+_dirArray[1].toString();
				}
				return "[ type:"+_type+",col:"+_col+",row:"+_row+",dirArray:"+s+" ]";
			}
			public function debugDraw(grap:Graphics,sz:int):void{
				var color:uint=0x000000;
				const ltpos:Point=new Point(_col*sz,_row*sz);
				var debugPosArray:Array=[];
				
				switch(_dirArray)
				{
					case TileWorldConst.DIRVECTOR_DOWN:
					case TileWorldConst.DIRVECTOR_LEFT:
					case TileWorldConst.DIRVECTOR_TOP:
					case TileWorldConst.DIRVECTOR_RIGHT:
					case TileWorldConst.DIRVECTOR_LEFT_AND_TOP:
					case TileWorldConst.DIRVECTOR_RIGHT_AND_TOP:
					{
						color=ColorUtil.COLOR_BLUE_DARK;
						debugPosArray=[ltpos,new Point(ltpos.x+sz,ltpos.y),new Point(ltpos.x+sz,ltpos.y+sz),new Point(ltpos.x,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_LEFT_DOWN:
					{
						color=0xFF00FF;
						debugPosArray=[ltpos,new Point(ltpos.x+sz,ltpos.y),new Point(ltpos.x+sz,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_LEFT_TOP:
					{
						color=0xFF00FF;
						debugPosArray=[new Point(ltpos.x+sz,ltpos.y),new Point(ltpos.x+sz,ltpos.y+sz),new Point(ltpos.x,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_RIGHT_DOWN:
					{
						color=0xFF00FF;
						debugPosArray=[ltpos,new Point(ltpos.x+sz,ltpos.y),new Point(ltpos.x,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_RIGHT_TOP:
					{
						color=0xFF00FF;
						debugPosArray=[ltpos,new Point(ltpos.x+sz,ltpos.y+sz),new Point(ltpos.x,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_LEFT_TOP_OUTER:
					{
						debugPosArray=[ltpos,new Point(ltpos.x+sz,ltpos.y+sz)];
						break;
					}
					case TileWorldConst.DIRVECTOR_RIGHT_TOP_OUTER:
					{
						debugPosArray=[new Point(ltpos.x+sz,ltpos.y),new Point(ltpos.x,ltpos.y+sz)];
						break;
					}
					default:
					{
						break;
					}
				}
				
				
				if(debugPosArray.length>0){
					if(debugDrawColor!=0x0)color=debugDrawColor;
					grap.lineStyle(1,color);
					for (var i:int=0;i<debugPosArray.length;i++){
						if(i==0)grap.moveTo(debugPosArray[i].x,debugPosArray[i].y);
						else{
							grap.lineTo(debugPosArray[i].x,debugPosArray[i].y);
						}
					}
					grap.lineTo(debugPosArray[0].x,debugPosArray[0].y);
					
					//画方向；
					const centerPos:Point=new Point(ltpos.x+sz*.5,ltpos.y+sz*.5);
					const upv:Vector2D=new Vector2D(0,-1);
					const downv:Vector2D=new Vector2D(0,1);
					const leftv:Vector2D=new Vector2D(-1,0);
					const rightv:Vector2D=new Vector2D(1,0);
					grap.beginFill(color,0.5);
					for each(var v:Vector2D in _dirArray){
						if(MathUtil.dotProduct(v,upv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x,ltpos.y,ltpos.x+sz,ltpos.y]));
						}else if(MathUtil.dotProduct(v,downv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x,ltpos.y+sz,ltpos.x+sz,ltpos.y+sz]));
						}else if(MathUtil.dotProduct(v,leftv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x,ltpos.y,ltpos.x,ltpos.y+sz]));
						}else if(MathUtil.dotProduct(v,rightv)==1){
							grap.drawTriangles(Vector.<Number>([centerPos.x,centerPos.y,ltpos.x+sz,ltpos.y,ltpos.x+sz,ltpos.y+sz]));
						}
					}
					grap.endFill();
				}
			}
		};
	}
}