package utils
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import z_spark.tileengine.entity.RigidEntity;

	public class RigidEntityFactory
	{
		public static function createNewRigidEntity(pivotX:Number,pivotY:Number,ctn:DisplayObjectContainer):RigidEntity
		{
			const size:uint=20;
//			const sizeH:uint=50;
			
			//创建一个刚体
			var body:RigidEntity=new RigidEntity();
			
			//为刚体运动分量数据创建锚点粒子（锚点粒子用于定位显示对象）；
			body.movementComponent.setSize(pivotX,pivotY,size,size);
			
			//创建一个显示对象；
			var disp:Sprite=TileEngineDemoUtils.getColoredSprite(size,size,TileEngineDemoUtils.getRandomColor());
			
			//将显示对象指定给刚体的渲染分量；
			body.renderComponent.sprite=disp;
			
			//确定将该显示对象添加到了现实列表；
			ctn.addChild(disp);
			
			return body;
		}
	}
}