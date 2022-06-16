package;

import flixel.*;
import lime.utils.Assets;
import openfl.display.BlendMode;
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
			case 'camother' | 'other': return PlayState.instance.camOther;
		}
		return PlayState.instance.camGame;
	}

	public static function blendModeFromString(blend:String):BlendMode {
		switch(blend.toLowerCase().trim()) {
			case 'add': return ADD;
			case 'alpha': return ALPHA;
			case 'darken': return DARKEN;
			case 'difference': return DIFFERENCE;
			case 'erase': return ERASE;
			case 'hardlight': return HARDLIGHT;
			case 'invert': return INVERT;
			case 'layer': return LAYER;
			case 'lighten': return LIGHTEN;
			case 'multiply': return MULTIPLY;
			case 'overlay': return OVERLAY;
			case 'screen': return SCREEN;
			case 'shader': return SHADER;
			case 'subtract': return SUBTRACT;
		}
		return NORMAL;
	}

	public static function addSprite(x,y,path:String,scrollFactor:Float=1):FlxSprite{
		var sprite:FlxSprite = new FlxSprite(x, y).loadGraphic(Paths.image(path));
		sprite.scrollFactor.set(scrollFactor, scrollFactor);
		sprite.active = false;
		sprite.antialiasing = true;
		return sprite;
	}
	public static function addAnimPrefix(x,y,path:String,prefix:String,scrollFactor:Float=1,loop:Bool=true,fps:Int=24):FlxSprite{
		var sprite:FlxSprite = new FlxSprite(x, y);
		sprite.frames = Paths.getSparrowAtlas(path);
		sprite.animation.addByPrefix(prefix,prefix,fps,loop);
		sprite.animation.play(prefix);
		sprite.antialiasing = true;
		sprite.scrollFactor.set(scrollFactor, scrollFactor);
		return sprite;
	}
	public static function addAnimIndices(x,y,path:String,prefix:String,indices:Array<Int>,scrollFactor:Float=1,loop:Bool=true,fps:Int=24):FlxSprite{
		var sprite:FlxSprite = new FlxSprite(x, y);
		sprite.frames = Paths.getSparrowAtlas(path);
		sprite.animation.addByIndices(prefix, prefix, indices, "", fps,loop);
		sprite.animation.play(prefix);
		sprite.antialiasing = true;
		sprite.scrollFactor.set(scrollFactor, scrollFactor);
		return sprite;
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
