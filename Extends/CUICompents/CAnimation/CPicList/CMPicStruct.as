package Extends.CUICompents.CAnimation.CPicList 
{
	/**
	 * 序列图结构类
	 * 序列图的地址
	 * 序列图的内容描述
	 * 每行序列图的个数
	 * 多行序列图的行数
	 * ...
	 * @author JeffXun
	 */
	public class CMPicStruct 
	{
		private var ms_imageSource:String = null;
		private var ms_imageLines:int = 1;
		private var ms_imageRows:int = 1;
		private var ms_imageXmlContent:String = null;
		public function CMPicStruct() 
		{
			
		}
		
		public function set source(value:String):void
		{
			ms_imageSource = value;
		}
		public function get source():String
		{
			if (ms_imageSource)
			{
				return ms_imageSource; 
			}
			else
			{
				throw new Error("have not image source path");
			}
		}
		
		public function set imageLine(value:int):void
		{
			ms_imageLines = value;
		}
		
		public function get imageLine():int
		{
			if (ms_imageLines <= 1)
			{
				return 1;
			}
			else
			{
				return ms_imageLines;
			}
		}
		
		public function set imageRow(value:int):void
		{
			ms_imageRows = value;
		}
		
		public function get imageRow():int
		{
			if (ms_imageRows <= 1)
			{
				return 1;
			}
			else
			{
				return ms_imageRows;
			}
		}
		
		public function set xmlContent(value:String):void
		{
			ms_imageXmlContent = value;
		}
		
		public function get xmlContent():String
		{
			return ms_imageXmlContent;
		}
	}

}
