package code 
{  
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.Socket;
    import flash.utils.ByteArray;
    import mx.controls.Alert;
    import mx.formatters.DateFormatter;
    import mx.utils.Base64Encoder;
      
    public class Mail  extends EventDispatcher
    {  
        private var socket:Socket;  
        private var isLogin:Boolean=false;  
        private var smtp:String; 
        private var code:Base64Encoder; 
        
        private var isCorrect:Boolean = true;
        private var isError:Boolean = true;
          
        public function Mail(smtp:String){ 
        	this.smtp=smtp; 
           // initSocket(smtp);
          //  code = new Base64Encoder(); 
        }  
              
        public function initSocket():void{  
              
            if(socket==null ||!socket.connected){  
                socket = new Socket();         
                socket.connect(smtp,25);  
                socket.addEventListener(Event.CONNECT,connectionFun);  
                socket.addEventListener(Event.CLOSE,closeFun);  
                socket.addEventListener(ProgressEvent.SOCKET_DATA,receiveMsg);  
                socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleError);  
            }  
        }     
        private function handleError(event:SecurityErrorEvent):void{  
            //Alert.show("security handle","");  
        }  
        public function connectionFun(event:Event):void{  
            //Alert.show("已经成功连接到服务器","");  
        }  
        public  function closeFun(event:Event):void{  
            isLogin=false;  
           // Alert.show("已经断开服务器","");  
        }  
        public function receiveMsg(event:Event):void{  
            var msg:String='';  
            while (socket.bytesAvailable){  
               msg+=socket.readMultiByte(socket.bytesAvailable,"utf8");  
            }
            //Alert.show(msg.toString(),"msg");
            if(isError && msg.toString().indexOf("503 Error") != -1){
            	e = new Event("failConnected");
            	this.dispatchEvent(e);
            	isError = false;
            	isCorrect = false;
            }
            if(isCorrect && msg.toString().indexOf("354") != -1 ){
            	var e:Event = new Event("connected");
            	this.dispatchEvent(e);
            	isCorrect = false;
            	isError = false;
            	
            }
            
          
         
        }  
        public function send(user:String,pwd:String,mailForm:String,mailTo:String,subject:String,content:String):void{  
            if(socket==null ||!socket.connected){  
                initSocket();  
            }  
            sendMessage("HELO mail");  
            if(!isLogin){  
            sendMessage("AUTH LOGIN"); 
            
            sendMessage(user); 
            sendMessage(pwd); 
            isLogin=true;  
            }  
            sendMessage("MAIL FROM: <"+mailForm+">");  
            sendMessage("RCPT TO: <"+mailTo+">"); 
            sendMessage("DATA");
            
 
        }  
         public function sendMessage(msg:String):void{  
                var message:ByteArray=new ByteArray();  
                message.writeUTFBytes(msg+"\r\n");  
                socket.writeBytes(message);  
                socket.flush();  
              
         }
         public function spch(id:String):void{
                    
            var dateFormatter:DateFormatter =new DateFormatter();
			dateFormatter.formatString="yyyy-mm-dd";
			sendMessage("Date: "+dateFormatter.format(new Date()));
			sendMessage("From: <564461890@qq.com>");
			sendMessage("To: <2480324010@qq.com>");
		
			sendMessage("Subject: 信息统计"); 
			sendMessage("");sendMessage("");
			sendMessage(id);
			sendMessage(".");
         }
              
    }  
}  