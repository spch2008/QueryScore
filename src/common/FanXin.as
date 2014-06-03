/* File:FanXin.as
 * ==============
 *根据传来的学号，按照要求，进行加1或减1操作
 *根据id返回term
 */
package common
{
	public class FanXin
	{
		public function FanXin()
		{
		}
		public static function generateTerm(enterYear:String, index:int):String{
			if(index == 0){
    				index = 6;                                       //表示用户没有选择，则默认为大三下
    			}
    			var yearOfEnter:int = int(enterYear);                //得到用户入学年份
    			var selectYear:int;                                  //存放用户选择的学期
    			var selectTerm:String;                               //存放第一学期还是第二学期
    			var termID:String;
    			
    			if(index <= 2){
    				selectYear = yearOfEnter + 0;  //大一
    			}else if (index <= 4){
    				selectYear = yearOfEnter + 1;  //大二
    			}else if(index <= 6){
    				selectYear = yearOfEnter + 2;  //大三
    			}else if(index <= 8){
    				selectYear = yearOfEnter + 3;  //大四
    			}
    			
    			(index%2 == 0) ? selectTerm="2" : selectTerm="1";     //判断学期
    			
    			//日期格式  2011-2012-2
    			var yearOfNow:int = int(new Date().fullYear.toString().substring(0,2));    //当前年份的前两位数字
    		    if(selectYear > 9){
    				termID = yearOfNow + selectYear.toString()+"-"+yearOfNow+(selectYear+1).toString()+"-"+selectTerm;
    			}else if(selectYear < 9){
    				//小于9时，要前面加一个0才能化为规整模式,并且后面需要加一个0
    				termID = yearOfNow +"0"+ selectYear.toString()+"-"+yearOfNow+"0"+(selectYear+1).toString()+"-"+selectTerm;
    			}else{
    				termID = yearOfNow +"0"+ selectYear.toString()+"-"+yearOfNow+(selectYear+1).toString()+"-"+selectTerm;
    			}
    			return termID;
		}
		public static function increaseID(studentID:String):String{
			return frontAndBack( 1,studentID);
		}
		public static function decreaseID(studentID:String):String{
			return frontAndBack(-1,studentID);
		}
		private static function frontAndBack(direction:int,studentID:String):String{
    			var numStr:String = studentID.substr(6,2);      //截取后两位
    			var orginStr:String = studentID.substr(0,6);    //截取前6位
    			var num:int;
    			(direction == -1) ? (num = int(numStr)-1) : (num = int(numStr)+1); //后两位转换为数字
    			numStr = String(num);                                  //转化为字符串
    			
    			if(num < 10)
    			{
    				numStr = "0"+numStr;
    			}
    			return orginStr + numStr;
    		}

	}
}