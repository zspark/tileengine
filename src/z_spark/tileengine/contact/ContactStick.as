package z_spark.tileengine.contact
{
	import z_spark.tileengine.constance.ContactType;
	import z_spark.tileengine.primitive.Particle;

	public class ContactStick extends Contact
	{
		public function ContactStick(a:Particle,b:Particle)
		{
			_type=ContactType.CTYPE_STICK;
			super(a,b);
		}
	}
}