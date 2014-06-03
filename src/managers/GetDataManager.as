/* File:GetDataManager.as
 *=======================
 *this file is created by Sun Pengcheng on 2010-01-15 15:18
 *to get data of students' scores from upc.edu.cn
 */

package managers
{
	import events.ReceivedDataEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.System;
	
	import mx.controls.Alert;
	
	public class GetDataManager extends EventDispatcher
	{
		private var urlRequest:URLRequest;
		private var urlLoader:URLLoader;
		private var studentObj:Object;
		private var subjectObjArr:Array;
		private var studentName:String;
		
		public function GetDataManager()
		{
			System.useCodePage = true;
			studentObj = {};                //学生实体
//			subjectObjArr = [];             //课程存储
			
			urlRequest = new URLRequest();
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, resultHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErroHandler);
		}
		
		/*  外部通过调用getData函数，获取数据   */
		public function getData(term:String, studentID:String):void{
			
			if(studentID == "08081424") studentID = "08081423";
			
			var url:String;
			
			if(term.length == 0){
				url = "http://jiaoxue.hdpu.edu.cn/jwgl/jwxs/xsxk/Xk_CjZblist_excel2.asp?Sql=select+*+from+V_Cj_XsCjZb+where" + 
					         "+Xh+%3D+%27" + studentID + "%27++";		        
			}else if(term.length == 10){
				url = "http://jiaoxue.hdpu.edu.cn/jwgl/jwxs/xsxk/Xk_CjZblist_excel2.asp?Sql=select+*+from+V_Cj_XsCjZb+where" + 
					         "+Xh+%3D+%27" + studentID + "%27++and+%28Xnxqh+%3D%27" + term+ "1" + "%27++or+Xnxqh+%3D%27" + term + "2+%27%29"; 
			}else{
				url = "http://jiaoxue.hdpu.edu.cn/jwgl/jwxs/xsxk/Xk_CjZblist_excel2.asp?Sql=select+*+from+V_Cj_XsCjZb+where" + 
					         "+Xh+%3D+%27" + studentID + "%27++and+%28Xnxqh+%3D%27" + term + "%27%29";
//				url = "http://jiaoxue.hdpu.edu.cn/jwgl/jwxs/xsxk/Xk_CjZblist_excel2.asp?Sql=select+*+from+V_Cj_XsCjZb+where" + 
//					         "+Xh+%3D+%27" + studentID + "%27++and+%28Xnxqh+%3D%27" + "2009-2010-1" + "%27++or+%28Xnxqh+%3D%27" + "2009-2010-2";
			}
			
	      
		    urlRequest.url = url;
		    urlLoader.load(urlRequest);
		}
		
		private function analyString(data:String):void{
			//Alert.show(data); return;
			//将有用信息留下，其余信息删掉
			var i:int = data.indexOf("姓名:",0);
			var j:int = data.indexOf("姓名:",i+3);
			data = data.substring(i-3,j+10);
			//信息有管理函数进行分析
			analyDataManager(data);
		}
		
		/* set URLLoader Handlers   */
		private function resultHandler(evt:Event):void{

			
			var data:String = evt.target.data;
			//Alert.show(data,"");
			analyString(data);
			
		}
		
		private function errorHandler(evt:IOErrorEvent):void{
			//Alert.show(evt.target.data,"error");
			//Alert.show(evt.errorID.toString(),"error");
			var data:String = evt.target.data;
			analyString(data);
			
		}
		
		private function securityErroHandler(evt:SecurityErrorEvent):void{
			Alert.show(evt.errorID.toString(),"error");
		}
		
		/*  取来的数据既包含姓名数据也包含课程数据，通过管理函数，将其分解开来  */
		private function analyDataManager(data:String):void{
			//取得课程信息
			var i:int = data.indexOf("Font.size",0);
			var j:int = data.indexOf("\").Delete",i);
			var subjectInfo:String = data.substring(i,j);
			//取得学生本人信息
			i = data.indexOf("\"专业",j);
			j = data.indexOf("\"",i);
			var studentInfo:String = data.substr(i,j);
            
			analyStudentInfo(studentInfo);
			analySubjectInfo(subjectInfo);
			
			broadCaseEvent();                        //通知主程序我的任务已经完成
		}
		
		/* 对从网页上提取的信息进行分析   */
		private function analyStudentInfo(data:String):void{
			//当无对应信息的时候
			if(data == ""){
				studentObj.major = "无信息";
				studentObj.grade = "无信息";
				studentObj.studentID = "无信息";
				studentObj.studentName = "无信息";
				return;
			}
			//以下截取对应的信息
			var i:int = data.indexOf("专业:",0);
			var j:int = data.indexOf(" ",i);
			studentObj.major = data.substring(i+3,j);
			i = data.indexOf("班级:",j);
			j = data.indexOf(" ",i);
			studentObj.grade = data.substring(i+3,j);
			i = data.indexOf("学号:",j);
			j = data.indexOf(" ",i);
			studentObj.studentID = data.substring(i+3,j);
			i = data.indexOf("姓名:",j);
			j = data.indexOf("\"",i);
			studentObj.studentName = data.substring(i+3,j);
			this.studentName = studentObj.studentName;             //记住当前学生的名字
		}
		
		private function analySubjectInfo(data:String):void{
			//分组，将数据从“设置导入进度”将数据分成N组
			var subjectsStr:Array = [];
			//var oneStudentArr:Array = [];
			subjectsStr = data.split("设置导入进度");    
			
			var i:int;
			var j:int;
			var oneSubject:String;
			
			subjectObjArr = new Array();
			
			//逐步提取每门课的信息
			for(var k:int = 0; k < subjectsStr.length-1; k++){
				oneSubject = subjectsStr[k].toString();
				var subject:Object = {};
				
				i = oneSubject.indexOf("2) = \"",0)+6;
				j = oneSubject.indexOf("\"",i);
				subject.subjectName = oneSubject.substring(i,j);
				
				i = oneSubject.indexOf("3) = \"",j) + 6;
				j = oneSubject.indexOf("\"",i);
				subject.subjectScore = oneSubject.substring(i,j);
				
				i = oneSubject.indexOf("4) = \"",j) + 6;
				j = oneSubject.indexOf("\"",i);
				subject.subjectCredit = oneSubject.substring(i,j);
				
				i = oneSubject.indexOf("6) = \"",j) + 6;
				j = oneSubject.indexOf("\"",i);
				subject.subjectKind = oneSubject.substring(i,j);
				
				
				subject.studentName = this.studentName;            //课程中加一个名字标识
				
				
				//将每一门成绩暂存在数组中
				//subjectObjArr.push(subject); 
				pushSubjectToArr(subject);                               
			}

		}
		private function pushSubjectToArr(obj:Object):void{
			for each(var prop:Object in subjectObjArr){
				if(prop.studentName == obj.studentName){
					if(prop.subjectName == obj.subjectName){
						if(Number(prop.subjectScore) < Number(obj.subjectScore)){
							//Alert.show(prop.subjectScore,obj.subjectScore);
							prop.subjectScore = obj.subjectScore;
							
							
						}
						return;
					}
				}
			}
			subjectObjArr.push(obj);
		}
		private function broadCaseEvent():void{
			var e:ReceivedDataEvent = new ReceivedDataEvent(ReceivedDataEvent.RECEIVE_DATA,studentObj,subjectObjArr);
			this.dispatchEvent(e);
		}

	}
}