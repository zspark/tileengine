package z_spark.tileengine.contact
{
	import z_spark.tileengine.zspark_tileegine_internal;
	import z_spark.tileengine.primitive.Particle;

	public class Contact
	{
		protected var _a:Particle;
		protected var _b:Particle;
		
		protected var _type:int;
		protected var _maxLength:Number=100;//pixel
		protected var _rotation:Number=0;
		protected var _damping:Number=.7;
		public function Contact(a:Particle,b:Particle)
		{
			_a=a;
			_b=b;
		}

		public function get b():Particle
		{
			return _b;
		}

		public function set b(value:Particle):void
		{
			_b = value;
		}

		public function get a():Particle
		{
			return _a;
		}

		public function set a(value:Particle):void
		{
			_a = value;
		}

		public function get damping():Number
		{
			return _damping;
		}
		
		public function set damping(value:Number):void
		{
			_damping = value;
		}
		
		public function get rotation():Number
		{
			return _rotation;
		}

		public function set rotation(value:Number):void
		{
			_rotation = value;
		}

		public function get maxLength():Number
		{
			return _maxLength;
		}

		public function set maxLength(value:Number):void
		{
			_maxLength = value;
		}

		zspark_tileegine_internal function update():void{}
	}
}