package Extends.CUICompents.CGameUI 
{
	import Extends.CUICompents.CEffect.CAutoMove;
	import Extends.CUICompents.CText.CMText;
	import Extends.CustomApp.CustomEvent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	dynamic  public class CGMonster extends CGMPlayerAttr 
	{
		static public const LEFT_DIRECTION:String = "LEFT_DIRECTION";
		static public const RIGHT_DIRECTION:String = "RIGHT_DIRECTION";
		static public const TOP_DIRECTION:String = "TOP_DIRECTION";
		static public const BOTTEM_DIRECTION:String = "BOTTEM_DIRECTION";
		
		protected var ms_nameLabel:CMText = new CMText();
		protected var ms_LifeBar:CGNumBar = new CGNumBar();
		protected var ms_MagicBar:CGNumBar = new CGNumBar();
		protected var ms_AimateDict:CAnimate = new CAnimate();
		
		protected var ms_BmpBody:*  = null
		protected var ms_Animate:* = null;
		protected var ms_MoveEffect:CAutoMove = null;
		private var ms_LifeBarVisible:Boolean = false;
		private var ms_MagicBarVisible:Boolean = false;
		private var ms_moveRect:Rectangle = new Rectangle();
		protected var ms_newAnimate:* = null;
		
		private var old_Direction:String = "RIGHT_DIRECTION";
		private var current_Direction:String = "RIGHT_DIRECTION";
		
		private var ms_StandState:*  = null;
		private var ms_RunState:*    = null;
		private var ms_isOverTurn:Boolean = false;
		
		public function CGMonster(id:int,name:String) 
		{
			this.PID = id;
			ms_nameLabel.text = name;
			ms_MoveEffect =  new CAutoMove(this);
			this.mouseChildren = false;
			this.addEventListener(Event.ADDED_TO_STAGE, OnInitCanvas);
			//this.OnInitCanvas(null);
			this.addEventListener("WM_DISPLAY_UPDATE", update);
		}
		
		public function AddAnimate(type:String,animate:*):void
		{
			ms_AimateDict.addAnimate(type,animate);
		}
		
		private function OnTmpMastor(mwidth:Number, mheight:Number):Shape
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0, 0.5);
			shape.graphics.drawEllipse(0, 0, mwidth, mheight);
			shape.graphics.endFill();
			return shape;
		}
		
		protected function OnInitCanvas(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, OnInitCanvas)
			
			if (!ms_Animate)
			{
				ms_Animate = ms_AimateDict.getAnimate("wait",ms_isOverTurn);//OnTmpMastor(100, 200);
			}
			
			ms_MagicBar.setLineColor(0x0000FF, 0);
			ms_LifeBar.visible = ms_LifeBarVisible;
			ms_MagicBar.visible = ms_MagicBarVisible;
			
			this.addChild(ms_LifeBar);
			this.addChild(ms_MagicBar);
			this.addChild(ms_Animate);
			this.addChild(ms_nameLabel);
		}
		public function set canClick(value:Boolean):void
		{
			this.mouseEnabled = value;
			if (value)
			{
				this.addEventListener(MouseEvent.ROLL_OVER, OnMouseOver);
				this.addEventListener(MouseEvent.ROLL_OUT, OnMouseOut);
			}
		}
		
		public function set LifeBarVisible(value:Boolean):void
		{
			ms_LifeBarVisible = value;
			ms_LifeBar.visible = value;
		}
		
		public function set MagicBarVisible(value:Boolean):void
		{
			ms_MagicBarVisible = value;
			ms_MagicBar.visible = value;
		}
		
		public function setMovePt(sx:Number,sy:Number,cx:Number, cy:Number):void
		{
			
			if(sx>cx)
			{
				ms_isOverTurn = true;
			}
			else
			{
				ms_isOverTurn = false;
			}
			//trace(sx,sy,cx,cy,ms_isOverTurn)	
			
			ms_MoveEffect.xFrom = sx;
			ms_MoveEffect.xTo = cx;
			ms_MoveEffect.yFrom = sy;
			ms_MoveEffect.yTo = cy;
			
			if (ms_MoveEffect.running)
			{
				ms_MoveEffect.End();
			}
			
			ms_MoveEffect.addEventListener(CAutoMove.EFFECT_EVENT_MOVE_END, OnMoveEnd);
			ms_MoveEffect.Play();
			this.bodyAnimate = ms_AimateDict.getAnimate("run",ms_isOverTurn);
			
		}
		public function setMoveRect(rect:Rectangle):void
		{
			ms_moveRect = rect;
			this.setPos(rect.x,rect.y);
		}
		
		public function setAttack():void
		{
			this.bodyAnimate = ms_AimateDict.getAnimate("attack",ms_isOverTurn);
		}
		public function setWait():void
		{
			this.bodyAnimate = ms_AimateDict.getAnimate("wait",ms_isOverTurn);
		}
		public function setHit():void
		{
			this.bodyAnimate = ms_AimateDict.getAnimate("hit",ms_isOverTurn);
		}
		public function setDead():void
		{
			this.bodyAnimate = ms_AimateDict.getAnimate("dead",ms_isOverTurn);
		}
		private function OnMoveEnd(evt:Event):void
		{
			ms_MoveEffect.removeEventListener(CAutoMove.EFFECT_EVENT_MOVE_END, OnMoveEnd);
			this.bodyAnimate = ms_AimateDict.getAnimate("wait",ms_isOverTurn);
		}
		
		public function setTurnOver(value:Boolean):void
		{
			ms_isOverTurn = value;
		}
		
		private function OnMouseOver(evt:MouseEvent):void
		{
			if (this.mouseEnabled)
			{
				this.filters = [new GlowFilter(0xFFFF00),]
			}
		}
		
		private function OnMouseOut(evt:MouseEvent):void
		{
			if (this.mouseEnabled)
			{
				this.filters = []
			}
		}
		
		public function set bodyAnimate(value:*):void
		{
			if (value is DisplayObject)
			{
				if (ms_Animate && this.contains(ms_Animate))
				{
					this.removeChild(ms_Animate);
				}
				ms_Animate = value;
				this.addChild(ms_Animate);
			}
			
			this.dispatchEvent(new CustomEvent("WM_DISPLAY_UPDATE"));
		}
		
		private function update(evt:CustomEvent = null):void
		{
			ms_LifeBar.x   = (ms_Animate.width - ms_LifeBar.width) / 2;
			ms_MagicBar.x  = (ms_Animate.width - ms_LifeBar.width) / 2;
			ms_nameLabel.x = (ms_Animate.width - ms_nameLabel.width) / 2;
			
			ms_LifeBar.y   = 0;
			ms_MagicBar.y  = ms_LifeBar.y + ms_LifeBar.height + 0.5;
			ms_nameLabel.y = ms_MagicBar.y + ms_MagicBar.height + 0.5 ;
			ms_Animate.y   = ms_nameLabel.y +  ms_LifeBar.height + 0;
			
		}
		
		public function setPos(cx:Number,cy:Number):void
		{
			//trace("setPos",cx,cy,this.width,this.height);
			var newX:Number = cx - this.width/2;
			var newY:Number = cy - this.height;
			this.x = newX;
			this.y = newY;
		}
		
		public function isInRect(cx:Number,cy:Number):Boolean
		{
			//trace(ms_moveRect,ms_moveRect.contains(cx,cy),cx,cy);
			return ms_moveRect.contains(cx,cy);
		}
		public function getPos():Point
		{
			var pt:Point = new Point(this.x+this.width/2,this.y+this.height);
			//trace("getPos",pt);
			return pt;
		}
		
		public function set Direction(value:String):void
		{
			current_Direction = value;
		}
		public function get Direction():String
		{
			return current_Direction;
		}
	}

}