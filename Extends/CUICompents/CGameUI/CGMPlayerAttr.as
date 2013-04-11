package Extends.CUICompents.CGameUI 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CGMPlayerAttr extends Sprite 
	{
		private var ms_Id:int = -1;
		private var ms_Name:String = null;
		private var ms_cx:Number = 0;
		private var ms_cy:Number = 0;
		private var ms_Level:int = 0;
		private var ms_HeadSrc:String  = null;
		private var ms_HeadID:int = 0;
		private var ms_BodySrc:String	 = null;
		private var ms_BodyID:int = 0;
		private var ms_Money:int = 0;
		private var ms_Gold:int  = 0;
		private var ms_Life:int  = 0;
		private var ms_hasLife:int = 0;
		private var ms_Magic:int  = 0;
		private var ms_hasMagic:int = 0;
		private var ms_Anger:int  = 0;
		private var ms_hasAnger:int = 0;
		
		public function CGMPlayerAttr() 
		{
			
		}
		
		public function set PID(value:int):void
		{
			ms_Id = value;
		}
		
		public function get PID():int
		{
			return ms_Id;
		}
		
		public function set NickName(value:String):void
		{
			ms_Name = value;
		}
		
		public function get NickName():String
		{
			return ms_Name;
		}
		
		public function set Level(value:int):void
		{
			ms_Level = value;
		}
		
		public function get Level():int
		{
			return ms_Level;
		}
		
		public function set fullLife(value:int):void
		{
			ms_Life = value;
		}
		
		public function get fullLife():int
		{
			return ms_Life;
		}
		
		
		public function set hasLife(value:int):void
		{
			ms_hasLife = value;
		}
		
		public function get hasLife():int
		{
			return ms_hasLife;
		}
		
		public function set fullMagic(value:int):void
		{
			ms_Magic = value;
		}
		public function get fullMagic():int
		{
			return ms_Magic;
		}
		
		public function set hasMagic(value:int):void
		{
			ms_hasMagic = value;
		}
		
		public function get hasMagic():int
		{
			return ms_hasMagic;
		}
		
		public function set HeadPicID(value:int):void
		{
			ms_HeadID = value;
		}
		
		public function get HeadPicID():int
		{
			return ms_HeadID;
		}
		
		public function set AnimateID(value:int):void
		{
			ms_BodyID = value;
		}
		
		public function get AnimateID():int
		{
			return ms_BodyID;
		}
	}

}