package Extends.CUtils 
{
	import Extends.CEvent.CustomEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	public class TcpClient extends Sprite 
	{
		public static const EVENT_TCP_COMPLETE:String = "EVENT_TCP_COMPLETE";
		
		private var _sock:Socket = new Socket();
		private var mv_Host:String;
		private var mv_Port:int ;

		public function TcpClient(host:String=null,port:int=0)
		{
			super();
			if(host)
			{
				mv_Host = host;
			}
			if(port)
			{
				mv_Port = port;
			}
		}
		
		public function Connect(host:String=null,port:int=0):Socket
		{
			if(host)
			{
				mv_Host = host;
			}
			if(port)
			{
				mv_Port = port;
			}
			if(mv_Host && mv_Port)
			{
				_sock.connect(mv_Host,mv_Port);
				_sock.addEventListener(IOErrorEvent.IO_ERROR,NetError);
				_sock.addEventListener(ProgressEvent.SOCKET_DATA,RecvData);
				_sock.addEventListener(Event.CONNECT,NetConnet);
				_sock.addEventListener(Event.CLOSE,OnServerClose);
			}
			return _sock;
		}
		
		public function NetConnet(event:Event):void
		{
			var evt:CustomEvent = new CustomEvent(EVENT_TCP_COMPLETE);
			this.dispatchEvent(evt);
		}
		
		public function NetError(err:IOErrorEvent):void
		{
			trace(err.text);
		}
		public function Close():void
		{
			_sock.close();
		}
		
		public function get m_Host():String
		{
			return mv_Host;
		}
		
		public function RecvData(event:Event):void
		{
			var _rdata:ByteArray = new ByteArray();
			try
			{
				_sock.readBytes(_rdata);
				this.CustomSockData(_rdata);
			}
			catch(err:Error)
			{
				if(!_sock.connected)
				{
					trace("网络连接关闭");
					_sock.close();
				}
				else
				{
					trace("接收数据异常");
				}
			}
		}
		
		public function CustomSockData(data:ByteArray):void
		{
			if(data.length>=4)
			{
				data.position = 0;
				data.endian = Endian.LITTLE_ENDIAN;
				var nlen:int = data.readShort();
				if(nlen <= data.length)
				{
					data.endian = Endian.BIG_ENDIAN;
					var msg:int = data.readShort();
					var temp:ByteArray = new ByteArray();
					data.readBytes(temp);
					var et:CustomEvent = new CustomEvent(msg.toString());
					et.event_data  = temp;
					et.msg  = msg;
					this.dispatchEvent(et);
				}
				else
				{
					trace("_data.lenght",nlen);
				}
			}
		}
		
		public function SendData(data:ByteArray):Boolean
		{
			try
			{
				if(_sock.connected)
				{
					_sock.writeBytes(data);
					_sock.flush();
					return true;
				}
			}
			catch (err:Error)
			{
				trace(err.message);
			}
			return false
		}
		
		private function OnServerClose(event:Event):void
		{
			trace("网络连接关闭");
			var evt:CustomEvent = new CustomEvent("CUSTOM_SOCKET_CLOSE");
			this.dispatchEvent(evt);
		}
		
		public function addListener(msg:uint,fun:Function):void
		{
			this.addEventListener(msg.toString(),fun);
		}
		public function removeListener(msg:uint,fun:Function):void
		{
			this.removeEventListener(msg.toString(),fun);
		}
	}

}