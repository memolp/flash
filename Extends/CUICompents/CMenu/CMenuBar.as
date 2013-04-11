package Extends.CUICompents.CMenu
{
	import Extends.CUICompents.CText.CMLabel;
	import Extends.CustomApp.CustomEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CMenuBar extends Sprite 
	{
		static public const WM_CM_ITEM_SELECT:String = "WM_CM_ITEM_SELECT";
		
		private var ms_MenuList:* = null;
		private var ms_menuItemData:Object =  new Object();
		private var ms_canSeeLevel:Array = new Array();
		public function CMenuBar() 
		{
			this.addEventListener("WM_UPDATE_LIST", update);
			this.addEventListener(MouseEvent.CLICK, OnItemClick) ;
		}
		
		public function MenuDataXml(xml:XML):void
		{
			ms_MenuList = xml.children();
		}
		
		public function MenuDataList(nlist:Array):void
		{
			ms_MenuList = nlist;
		}
		
		private function _createMenu():void
		{
			if (ms_MenuList is XMLList)
			{
				for each(var m:XML in ms_MenuList)
				{
					if (m.hasOwnProperty("@label") && isInLevel(int(m.@level)))
					{
						var Label:CMLabel = new CMLabel(m.@label);
						Label.setMouseStatus();
						ms_menuItemData[Label.text] = {"display":Label,"data":m};
						this.addChild(Label);
					}
				}
			}
			if (ms_MenuList is Array)
			{
				for each(var am:Object in ms_MenuList)
				{
					if (am.hasOwnProperty("label") && isInLevel(int(am.level)))
					{
						var MLabel:CMLabel = new CMLabel(am.label);
						MLabel.setMouseStatus();
						ms_menuItemData[MLabel.text] = {"display":Label,"data":am};
						this.addChild(MLabel);
					}
				}
			}
			this.dispatchEvent(new CustomEvent("WM_UPDATE_LIST"));
		}
		private function update(evt:CustomEvent):void
		{
			for (var i:int = 0; i < this.numChildren; i++)
			{
				var l:* = this.getChildAt(i);
				l.y = l.height * i + 2;
			}
		}
		
		private function clear():void
		{
			for each(var m:Object in ms_menuItemData)
			{
				try
				{
					this.removeChild(m.display);
				}
				catch(err:Error)
				{
					trace(err.message);
				}
			}
			/*for (var i:int = 0; i < this.numChildren; i++)
			{
				this.removeChildAt(i);
			}*/
		}
		
		public function onShow(value:Array):void
		{
			ms_canSeeLevel = value;
			this.clear();
			this._createMenu();
		}
		
		private function OnItemClick(evt:MouseEvent):void
		{
			if (evt.target is CMLabel)
			{
				//trace(ms_menuItemData[evt.target]);
				var event:CustomEvent = new CustomEvent(WM_CM_ITEM_SELECT);
				event.data = ms_menuItemData[evt.target.text];
				this.dispatchEvent(event);
			}
		}
		
		private function isInLevel(level:int):Boolean
		{
			if (ms_canSeeLevel.length == 0)
			{
				return true;
			}
			else
			{
				for each(var l:int in ms_canSeeLevel)
				{
					if (l == level)
					{
						return true;
					}
				}
			}
			return false;
		}
	}

}
