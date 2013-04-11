package Extends.CUICompents.CGameUI 
{
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CGCharacter extends CGMonster 
	{
		public function CGCharacter(id:int,name:String) 
		{
			super(id, name);
			this.LifeBarVisible = true;
			this.MagicBarVisible = true;
		}
		
		override public function set fullLife(value:int):void
		{
			ms_LifeBar.maxValue = value;
		}
		override public function get fullLife():int
		{
			return ms_LifeBar.maxValue;
		}
		override public function set hasLife(value:int):void
		{
			ms_LifeBar.value = value;
		}
		
		override public function set fullMagic(value:int):void
		{
			ms_MagicBar.maxValue = value;
		}
		
		override public function set hasMagic(value:int):void
		{
			ms_MagicBar.value = value;
		}
		
	}

}