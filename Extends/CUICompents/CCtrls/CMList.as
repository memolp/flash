package Extends.CUICompents.CCtrls 
{
	import Extends.CUICompents.CCanvas.CMCanvas;
	import Extends.CUICompents.CText.CMLabel;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CMList extends CMCanvas 
	{
		protected var ms_LabelField:String = "label";
		protected var ms_dataList:Object = new Object();
		public function CMList() 
		{
			super();
			this.addEventListener(MouseEvent.ROLL_OVER,OnMouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT,OnMouseOut);
		}
		
		override protected function onInitCanvas():void 
		{
			super.onInitCanvas();
			this.setListStyle();
		}
		
		private function OnMouseOver(evt:MouseEvent):void
		{
			trace(evt.target,evt.currentTarget);
			if(evt.currentTarget is CMLabel)
			{
				(evt.target as CMLabel).setTextFilter(new GlowFilter(0xFF00FF),true);
			}
		}
		
		private function OnMouseOut(evt:MouseEvent):void
		{
			if(evt.currentTarget is CMLabel)
			{
				(evt.target as CMLabel).setTextFilter([],true);
			}
		}
		
		protected function setListStyle():void
		{
			this.graphics.lineStyle(1);
			this.graphics.drawRect(0, 0, 100, 200) ;
		}
		/**
		 * @param value : 设置列表显示的字段属性,默认是label
		 */
		public function set labelField(value:String):void
		{
			ms_LabelField = value;
		}
		
		/**
		 * @param value : 必须是数组类型 或者是 XMLList类型
		 */
		public function set dataProvider(value:Object):void
		{
			if (value is Array || value is XMLList)
			{
				for each(var node:Object in value)
				{
					var label:String = "";
					if (node.hasOwnProperty(ms_LabelField))
					{
						label = node[ms_LabelField].toString();
					}
					else
					{
						label = node.toString();
					}
					this.addItem(label, node);
				}
			}
			else
			{
				throw Error("dataProvider 只接受数组Array 和 XMLList 类型");
			}
		}
		
		/**
		 * 列表中单个选项插入
		 * @param	label  选项的标题内容
		 * @param	data   选项的内容
		 * @return
		 */
		protected function addItem(label:String, data:Object):int
		{
			var itemLabel:CMLabel = new CMLabel(label);
			return this._addItem(itemLabel, data);
		}
		
		/**
		 * 
		 * @param	ui
		 * @param	data
		 * @return
		 */
		protected function _addItem(ui:DisplayObject, data:Object):int
		{
			var childNum:int = this.numChildren;
			if (childNum >= 1)
			{
				var previousUI:DisplayObject = this.getChildAt(childNum - 1);
				ui.x = previousUI.x;
				ui.y = previousUI.y + previousUI.height;
				this.addChild(ui);
				ms_dataList[childNum.toString()] = {"data":data,"display":ui};
				return childNum;
			}
			else
			{
				this.addChild(ui);
				ms_dataList['0'] = {"data":data,"display":ui};
				return 0;
			}
		}
		
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
		}
	}

}