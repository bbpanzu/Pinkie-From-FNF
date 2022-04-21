package;

import flixel.FlxCamera;
import lime.utils.Assets;
import sys.io.File;

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', "NORMAL", "HARD"];

	public static function difficultyString():String
	{
		return difficultyArray[PlayState.storyDifficulty];
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}


	public static function getColorFromHex(color:String) {
		if(!color.startsWith('0x')) color = '0xff' + color;
		return Std.parseInt(color);
	}
	public static function cameraFromString(cam:String):FlxCamera {
		trace(cam);
		switch(cam.toLowerCase()) {
			case 'camhud' | 'hud': return PlayState.instance.camHUD;
		}
		return PlayState.instance.camGame;
	}

	public static function coolTextFile3(path:String):Array<String>
	{
		var daList:Array<String> = File.getContent(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function coolTextFile2(data:String):Array<String>
	{
		var daList:Array<String> = data.trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}
}
