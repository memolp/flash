package Extends.CUtils
{
	import flash.utils.ByteArray;

	public class CHexValue
	{
		public function CHexValue()
		{
		}
		public static function strToHex(nstr:String):String
		{
			var res:ByteArray = new ByteArray();
			res.writeMultiByte(nstr,"utf-8");
			return HexString(res);
		}
		
		public static function hexToStr(nstr:String):String
		{
			var res:ByteArray = saveStringHex(nstr);
			return res.readUTFBytes(res.length);
		}
		
		public static function shortToHex(nstr:String):String
		{
			var res:ByteArray = new ByteArray();
			res.writeShort(Number(nstr));
			return HexString(res);
		}
		public static function hexToShort(nstr:String):String
		{
			if(nstr.length == 4)
			{
				var res:ByteArray = saveStringHex(nstr);
				return res.readShort().toString();
			}
			return ""
		}
		public static function intToHex(nstr:String):String
		{
			var res:ByteArray = new ByteArray();
			res.writeInt(Number(nstr));
			return HexString(res);
		}
		
		public static function hexToInt(nstr:String):String
		{
			if(nstr.length == 8)
			{
				var res:ByteArray = saveStringHex(nstr);
				return res.readInt().toString();
			}
			return ""
		}
		
		public static function floatToHex(nstr:String):String
		{
			var res:ByteArray = new ByteArray();
			res.writeFloat(Number(nstr));
			return HexString(res);
		}
		
		public static function hexToFloat(nstr:String):String
		{
			if(nstr.length == 8)
			{
				var res:ByteArray = saveStringHex(nstr);
				return res.readFloat().toString();
			}
			return ""
		}
		
		public static function doubleToHex(nstr:String):String
		{
			var res:ByteArray = new ByteArray();
			res.writeDouble(Number(nstr));
			return HexString(res);
		}
		
		public static function hexToDouble(nstr:String):String
		{
			if(nstr.length == 16)
			{
				var res:ByteArray = saveStringHex(nstr);
				return res.readDouble().toString();
			}
			return ""
		}
		
		public static function toHexNum(n:uint):String
		{
			return n<=0xF?"0"+n.toString(16):n.toString(16);
		}
		
		public static function HexString(byte:ByteArray):String
		{
			var tmp:String = "";
			var oldp:uint = byte.position;
			byte.position = 0;
			for (var i:uint =0;i<byte.length;i++)
			{
				tmp += toHexNum(byte.readUnsignedByte());
			}
			byte.position = oldp;
			return tmp
		}
		
		public static function saveStringHex(nstr:String):ByteArray
		{
			var res:ByteArray = new ByteArray();
			for(var i:uint=0;i<nstr.length;i+=2)
			{
				res.writeByte(Number("0x"+nstr.slice(i,i+2)));
			}
			res.position = 0;
			return res;
		}
	}
}