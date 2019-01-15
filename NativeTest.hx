package;

import openfl.Lib;

#if android
import lime.system.JNI;
#end

class NativeTest
{	
	private static var title:String;
	private static var message:String;

	public static function showAlert(title:String, message:String):Void
	{
		NativeTest.title = title;
		NativeTest.message = message;
		haxe.Timer.delay(delayAlert, 30);
	}
	
	private static function delayAlert():Void
	{
		#if ios
		iosAlert(title, message);
		#end
		
		#if android
		if(androidAlert == null)
		{
			androidAlert = JNI.createStaticMethod("NativeTest", "showAlert", "(Ljava/lang/String;Ljava/lang/String;)V", true);
		}
		
		androidAlert([title, message]);
		#end
	}

	#if android
	private static var androidAlert:Dynamic;
	#end

	#if ios
	static var iosAlert = Lib.load("nativetest", "ios_alert", 2);
	#end
}