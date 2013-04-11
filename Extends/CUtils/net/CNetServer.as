package Extends.CUtils.net
{
	import Extends.CEvent.CustomEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class CNetServer extends EventDispatcher
	{
		public static const NETWORK_CONNET_END:String = "NETWORK_CONNET_END";
		public static const NETWORK_CLOSED:String = "NETWORK_CLOSED";
		
		private var _sock:Socket = new Socket();
		//private var ms_struct:StructByteArray = new StructByteArray();
		//private var _netserver:NetServer;
		private var _rData:ByteArray = new ByteArray();
		
		private var mv_Host:String;
		private var mv_Port:int ;
		public function CNetServer()
		{
			super(null);
		}
		public function Connect(host:String,port:int):void
		{
			mv_Port = port;
			mv_Host = host;
			_sock.connect(host,port);
			_sock.addEventListener(IOErrorEvent.IO_ERROR,NetError);
			_sock.addEventListener(ProgressEvent.SOCKET_DATA,RecvData);
			_sock.addEventListener(Event.CONNECT,NetConnet);
			_sock.addEventListener(Event.CLOSE,OnServerClose);
			//this.addEventListener("CUSTOM_RECV_DATA",DispatchMsg);
			this.addEventListener("CUSTOM_RECV_DATA",CustomSockData);
		}
		
		public function NetConnet(event:Event):void
		{
			var evt:CustomEvent = new CustomEvent(NETWORK_CONNET_END);
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
				_rData.position = _rData.length;
				_rData.writeBytes(_rdata);
				var evt:CustomEvent = new CustomEvent("CUSTOM_RECV_DATA");
				this.dispatchEvent(evt);
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
		
		public function CustomSockData(event:CustomEvent):void
		{
			while(this._sock.connected)
			{
				if(_rData.length>=4)
				{
					_rData.position = 0;
					_rData.endian = Endian.LITTLE_ENDIAN;
					var nlen:int = _rData.readShort();
					if(nlen <= _rData.length)
					{
						_rData.endian = Endian.BIG_ENDIAN;
						var msg:int = _rData.readShort();
						var temp:ByteArray = new ByteArray();
						//trace("102wwww:",nlen,_rData.length)
						_rData.readBytes(temp,0,nlen-4);
						var et:CustomEvent = new CustomEvent(msg.toString());
						et.event_data  = temp;
						et.msg  = msg;
						this.dispatchEvent(et);
						temp.length = 0;
						_rData.readBytes(temp);
						_rData.length = 0;
						_rData = temp;
						_rData.position = 0;
						
					}
					else
					{
						trace("_data.lenght",nlen);
						break;
					}
				}
				else
				{
					break;
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
			var evt:CustomEvent = new CustomEvent(NETWORK_CLOSED);
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