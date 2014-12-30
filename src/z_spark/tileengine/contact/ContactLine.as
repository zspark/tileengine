package z_spark.tileengine.contact
{
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.constance.ContactType;
	import z_spark.tileengine.math.MathUtil;
	import z_spark.tileengine.math.Vector2D;
	import z_spark.tileengine.primitive.Particle;

	public class ContactLine extends Contact
	{
		public function ContactLine(a:Particle,b:Particle)
		{
			_type=ContactType.CTYPE_LINE;
			super(a,b);
		}
		
		override zspark_tileegine_internal function update():void{
			var tmp:Vector2D=_b.posVector.clone();
			tmp.sub(_a.posVector);
			var overLength:Number=tmp.mag-_maxLength;
			if(overLength>0){
				//>pos..
				tmp.normalize();
				var ac:Vector2D=tmp.clone();
				var bc:Vector2D=tmp.clone();
				tmp.mul(overLength);
				
				//>a;
				_a.posVector.addScale(tmp,.6);
				//>b;
				_b.posVector.addScale(tmp,-.5);
				
				//>spd..
				ac.mul(MathUtil.dotProduct(ac,_a.spdVector));
				_a.spdVector.sub(ac);
				bc.mul(MathUtil.dotProduct(bc,_b.spdVector));
				_b.spdVector.sub(bc);
				
				var sumv:Vector2D=ac.clone();
				sumv.add(bc);
				sumv.mul(.5);
				
				_a.spdVector.add(sumv);
				_b.spdVector.add(sumv);
			}
		}
	}
}