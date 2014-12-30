package z_spark.tileengine.solver
{
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.contact.Contact;

	use namespace zspark_tileegine_internal;
	public class ContactSolver
	{
		public function ContactSolver()
		{
		}
		
		zspark_tileegine_internal function update(_contactList:Vector.<Contact>):void
		{
			for each(var ctt:Contact in _contactList){
				ctt.update();
			}
		}
	}
}