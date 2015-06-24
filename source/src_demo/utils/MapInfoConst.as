package utils
{
	import z_spark.tileengine.constance.TileType;
	
	public class MapInfoConst
	{
		
		private static const w:Object={type:TileType.TYPE_WALL};
		private static const n:Object={type:TileType.TYPE_NONE};
		private static const l:Object={type:TileType.TYPE_THROUGHT};
		private static const t:Object={type:TileType.TYPE_THROUGHT_TOP};
		private static const s:Object={type:TileType.TYPE_SOFT_WALL};
		
		public static const mapRawInfo:Array=[
			[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
			[w,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,w,n,n,n,n,n,w],
			[w,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,w,n,n,n,n,n,w],
			[w,n,n,n,s,s,s,s,s,s,t,s,s,s,s,n,n,n,w,n,n,n,n,n,w],
			[w,n,n,n,n,n,n,n,n,n,l,n,n,n,n,n,n,n,w,n,n,n,n,n,w],
			[w,w,w,w,w,w,n,n,n,n,l,n,n,n,s,s,s,s,w,n,n,n,n,n,w],
			[w,w,w,w,w,w,n,n,n,n,l,n,n,n,n,n,n,n,n,n,n,n,n,n,w],
			[w,n,n,n,n,n,n,n,n,n,l,n,n,n,n,n,n,n,n,n,n,n,n,n,w],
			[w,n,n,n,n,n,n,s,s,s,s,s,s,s,s,n,n,s,s,s,s,s,t,s,w],
			[w,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,l,n,w],
			[w,n,n,s,s,s,t,s,s,w,w,w,w,w,w,w,w,n,n,n,n,n,l,n,w],
			[w,n,n,n,n,n,l,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,l,n,w],
			[w,n,n,n,n,n,l,n,n,s,s,s,s,n,n,n,n,n,n,n,n,n,l,n,w],
			[w,w,w,n,n,n,l,n,n,n,n,w,w,w,s,s,s,s,s,w,n,n,l,n,w],
			[w,w,w,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,w,n,n,n,n,w],
			[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w]
		];
		
		public static const demoMapRawInfo:Array=[
			[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
			[w,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,w,n,n,n,n,n,w],
			[w,n,n,n,n,n,n,s,s,s,s,s,s,s,s,n,n,s,s,s,s,s,t,s,w],
			[w,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,l,n,w],
			[w,n,n,s,s,s,t,s,s,w,w,w,w,w,w,w,w,n,n,n,n,n,l,n,w],
			[w,n,n,n,n,n,l,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,l,n,w],
			[w,n,n,n,n,n,l,n,n,s,s,s,s,n,n,n,n,n,n,n,n,n,l,n,w],
			[w,w,w,n,n,n,l,n,n,n,n,w,w,w,s,s,s,s,s,w,n,n,l,n,w],
			[w,w,w,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,w,n,n,n,n,w],
			[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w]
		];
		
		public static const simpleMapInfo:Array=[
			[w,w,w,w,w,w,w,w,w,w,w],
			[w,n,n,n,n,n,n,n,n,n,w],
			[w,n,n,n,n,n,n,n,n,n,w],
			[w,n,n,n,n,w,n,n,n,n,w],
			[w,n,n,n,n,n,n,n,n,n,w],
			[w,n,n,n,n,n,n,n,n,n,w],
			[w,n,n,n,n,n,n,n,n,n,w],
			[w,w,w,w,w,w,w,w,w,w,w]
		];
		
		public static const simpleMapInfo2:Array=[
			[w,w,w,w,w,w,w,w,w,w,w],
			[w,n,n,n,n,n,n,n,n,n,w],
			[w,n,n,n,n,n,n,n,n,n,w],
			[w,n,s,s,s,s,t,s,s,n,w],
			[w,n,n,n,n,n,l,n,n,n,w],
			[w,n,s,s,s,n,l,n,n,n,w],
			[w,n,n,n,n,n,l,n,n,n,w],
			[w,w,w,w,w,w,w,w,w,w,w]
		];
		
	}
}