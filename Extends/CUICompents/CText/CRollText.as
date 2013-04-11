package Extends.CUICompents.CText
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	public class CRollText extends CMText
	{
		private var ms_scrollRect:Rectangle = null;
		private var ms_textList:Array = new Array();
		private var ms_curIndex:uint = 0;
		private var ms_changeTime:Timer = null;
		private var ms_rollTimer:Timer = null;
		private var ms_curStyle:String = CRollTextModel.TEXT_STYLE_HROLL;
		private var ms_rollZeroStop:Boolean = false;
		
		public function CRollText(swidth:Number,sheight:Number)
		{
			super();
			ms_scrollRect = new Rectangle(0,0,swidth,sheight);
			this.scrollRect = ms_scrollRect;
			this.addEventListener(Event.ADDED_TO_STAGE,OnAddToStage);
		}
		
		private function OnAddToStage(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,OnAddToStage);
			this.autoWarp = true;
			this.width = ms_scrollRect.width;
			this.height = ms_scrollRect.height;
		}
		
		private function OnRollText(evt:TimerEvent):void
		{
			//
			switch(ms_curStyle)
			{
				case CRollTextModel.TEXT_STYLE_HROLL:
					
					this.OnHRollText(true);
					break;
				case CRollTextModel.TEXT_STYLE_VROLL:
					
					this.OnVRollText();
					break;
				case CRollTextModel.TEXT_STYLE_HROLL_ONCE:
					//ms_text.x = ms_scrollRect.width;
					this.OnHRollText(true);
					break;
				case CRollTextModel.TEXT_STYLE_VROLL_ONCE:
					//ms_text.y = ms_scrollRect.height;
					this.OnVRollText(true);
					break;
				default:
					break;
			}
		}
		private function OnChangeText(evt:TimerEvent):void
		{
			ms_changeTime.removeEventListener(TimerEvent.TIMER_COMPLETE,OnChangeText);
			ms_rollTimer.removeEventListener(TimerEvent.TIMER,OnRollText);
			ms_changeTime.stop();
			ms_rollTimer.stop();
			if(ms_curIndex >= ms_textList.length)
			{
				ms_curIndex = 0;
			}
			var text:CRollTextModel = ms_textList[ms_curIndex++];
			//trace("OnChangeText",ms_curIndex,ms_textList.length)
			if(text)
			{
				this._rollText(text);
			}
		}
		
		
		private function OnHRollText(stopEnd:Boolean=false):void
		{
			if(!stopEnd)
			{
				if(Math.abs(ms_text.x)<=ms_scrollRect.width)
				{
					ms_text.x -= 5;
				}
				else
				{
					ms_text.x = ms_scrollRect.width;
				}
			}
			else
			{
				if(ms_text.x >= 5 )
				{
					ms_text.x -= 5;
				}
				else
				{
					ms_text.x = 0;
					ms_rollTimer.reset();
				}
			}
		}
		
		private function OnVRollText(stopEnd:Boolean=false):void
		{
			if(!stopEnd)
			{
				if(Math.abs(ms_text.y)<=ms_scrollRect.height)
				{
					ms_text.y -= 1;
				}
				else
				{
					ms_text.y = ms_scrollRect.height;
				}
			}
			else
			{
				if(ms_text.y >= 1 )
				{
					ms_text.y -= 1;
				}
				else
				{
					ms_text.y = 0;
					ms_rollTimer.reset();
				}
			}
			
		}
		public function set dataProvider(value:Array):void
		{
			ms_textList.length = 0;
			for each(var txt:CRollTextModel in value)
			{
				this.addText(txt);
			}
		}
		public function addText(value:CRollTextModel):void
		{
			ms_textList.push(value);
			if(ms_changeTime && ms_rollTimer && !ms_changeTime.running && !ms_rollTimer.running)
			{
				this.startRoll();
			}
		}
		
		public function addSpecialText(value:CRollTextModel):void
		{
			this.stopRoll();
			this._rollText(value);
		}
		
		public function set rollRectAnimate(animate:DisplayObject):void
		{
			if(animate)
			{
				this.addChild(animate);
			}
		}
		public function stopRoll():void
		{
			if(ms_changeTime && ms_changeTime.running)
			{
				ms_changeTime.stop();
			}
			if(ms_rollTimer && ms_rollTimer.running)
			{
				ms_rollTimer.stop();
			}
		}
		public function startRoll():void
		{
			//trace("startRoll",ms_curIndex)
			if(ms_curIndex <ms_textList.length)
			{
				var text:CRollTextModel = ms_textList[ms_curIndex++];
				//trace(",s",ms_curIndex,text.rollStyle)
				if(text)
				{
					this._rollText(text);
				}
			}
		}
		
		private function _rollText(Text:CRollTextModel):void
		{
			if(Text.txt)
			{
				this.text = Text.txt;
				this.setTextFormat(Text.textFmt);
				ms_curStyle = Text.rollStyle;
				//this.setTextLeft()
				if(ms_curStyle == CRollTextModel.TEXT_STYLE_HROLL || ms_curStyle == CRollTextModel.TEXT_STYLE_HROLL_ONCE)
				{
					ms_text.x = ms_scrollRect.width;
				}
				else
				{
					ms_text.y = ms_scrollRect.height;
				}
				ms_rollTimer = new Timer(Text.speedTime);
				ms_rollTimer.addEventListener(TimerEvent.TIMER,OnRollText);
				if(Text.waitTime)
				{
					ms_changeTime = new Timer(Text.waitTime,1);
					ms_changeTime.addEventListener(TimerEvent.TIMER_COMPLETE,OnChangeText);
					ms_changeTime.start();
				}
				ms_rollTimer.start();
			}
			else
			{
				
			}
		}
	}
}