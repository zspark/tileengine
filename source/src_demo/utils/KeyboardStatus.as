package utils
{
	import flash.display.Stage;
	
	import z_spark.bkgrasper.SPKKeySet;
	import z_spark.bkgrasper.SPKKeyboardControl;
	import z_spark.core.utils.KeyboardConst;

	public class KeyboardStatus
	{
		private var _keyStatus:Array=[];

		public function set spaceDownFn(value:Function):void
		{
			_spaceDownFn = value;
		}

		public function set spaceUpFn(value:Function):void
		{
			_spaceUpFn = value;
		}

		public function get keyStatus():Array
		{
			return _keyStatus;
		}
		
		public function KeyboardStatus(stage:Stage)
		{
			////////////////////////////////////////////////////////keyboard//
			var kbc:SPKKeyboardControl=new SPKKeyboardControl();
			kbc.stage=stage;
			
			var ks:SPKKeySet=new SPKKeySet();
			ks.registKey(KeyboardConst.LEFT,onLeftUp,onLeftDown);
			ks.registKey(KeyboardConst.RIGHT,onRightUp,onRightDown);
			ks.registKey(KeyboardConst.UP,onUpUp,onUpDown);
			ks.registKey(KeyboardConst.DOWN,onDownUp,onDownDown);
			ks.registKey(KeyboardConst.SPACE,onSpaceUp,onSpaceDown);
			kbc.registKeySet("Demo",ks,true);
			/////////////////////////////////////////////////////////end////
		}
		
		private var _spaceDownFn:Function;
		private var _spaceUpFn:Function;
		
		private function onSpaceUp():void
		{
			if(_spaceUpFn)_spaceUpFn();
		}
		
		private function onSpaceDown():void
		{
			if(_spaceDownFn)_spaceDownFn();
		}
		
		protected function onLeftDown():void
		{
			_keyStatus[KeyboardConst.LEFT+'']=1;
		}
		
		protected function onRightDown():void
		{
			_keyStatus[KeyboardConst.RIGHT+'']=1;
		}
		
		protected function onUpDown():void
		{
			_keyStatus[KeyboardConst.UP+'']=1;
		}
		
		protected function onDownDown():void
		{
			_keyStatus[KeyboardConst.DOWN+'']=1;
		}
		protected function onDownUp():void
		{
			_keyStatus[KeyboardConst.DOWN+'']=0;
		}
		
		protected function onUpUp():void
		{
			_keyStatus[KeyboardConst.UP+'']=0;
		}
		
		protected function onRightUp():void
		{
			_keyStatus[KeyboardConst.RIGHT+'']=0;
		}
		
		protected function onLeftUp():void
		{
			_keyStatus[KeyboardConst.LEFT+'']=0;
			
		}
	}
}