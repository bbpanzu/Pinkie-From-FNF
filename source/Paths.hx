package;

import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets.FlxSoundAsset;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import openfl.media.Sound;
import openfl.utils.Assets as OpenFlAssets;
import sys.FileSystem;
import sys.io.File;

using StringTools;
class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;
	public static var imgCache:Map<String,FlxGraphic> = new Map<String,FlxGraphic>();
	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}

	public static function getPath(file:String, type:AssetType, library:Null<String>)
	{
		if (TitleState.curDir != "assets")
		{
			var path = TitleState.curDir + "/" + file;
			
			if(FileSystem.exists(path)){
				return path;
			}
			
		}
		if (library != null)
			return getLibraryPath(file, library);

		if (currentLevel != null)
		{
			var levelPath = getLibraryPathForce(file, currentLevel);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			levelPath = getLibraryPathForce(file, "shared");
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;
		}
		

		return getPreloadPath(file);
	}
	static public function getLibraryPath(file:String, library = "preload")
	{
		return if (library == "preload" || library == "default") getPreloadPath(file); else getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String)
	{
		return '$library:assets/$library/$file';
	}

	inline static function getPreloadPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function file(file:String, type:AssetType = TEXT, ?library:String)
	{
		
		return getPath(file, type, library);
	}

	inline static public function txt(key:String, ?library:String)
	{
		return getPath('data/$key.txt', TEXT, library);
	}

	inline static public function txtImages(key:String, ?library:String)
	{
		return getPath('images/$key.txt', TEXT, library);
	}

	inline static public function xml(key:String, ?library:String)
	{
		return getPath('data/$key.xml', TEXT, library);
	}

	inline static public function json(key:String, ?library:String)
	{
		
		return getPath('data/$key.json', TEXT, library);
	}

	inline static public function spritejson(key:String, ?library:String)
	{
		
		return getPath('images/$key.json', TEXT, library);
	}

	static public function sound(key:String, ?library:String):Any
	{
		var file:Sound = returnSongFile(TitleState.curDir+"/sounds/"+key+'.ogg');
		if(file != null) {
			return file;
		}
		
		
		return getPath('sounds/$key.$SOUND_EXT', SOUND, library);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
	{
		return sound(key + FlxG.random.int(min, max), library);
	}

	inline static public function music(key:String, ?library:String):Any
	{
		var file:Sound = returnSongFile(TitleState.curDir+"/music/"+key+'.ogg');
		if(file != null) {
			return file;
		}
		
		return getPath('music/$key.$SOUND_EXT', MUSIC, library);
	}

	inline static public function voices(song:String):Any
	{
		var file:Sound = returnSongFile(TitleState.curDir+"/songs/"+(song.toLowerCase().replace(' ', '-') + '/Voices.ogg'));
		if(file != null) {
			return file;
		}
		
		return 'songs:assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function inst(song:String):Any
	{
		//if (TitleState.curDir != "assets") return Sound.fromFile(TitleState.curDir + "/songs/${song.toLowerCase()}/Inst.$SOUND_EXT");
		
		
		var file:Sound = returnSongFile(TitleState.curDir+"/songs/"+(song.toLowerCase().replace(' ', '-') + '/Inst.ogg'));
		if(file != null) {
			return file;
		}
		
		return 'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}
	inline static private function returnSongFile(file:String):Sound
	{
		var DASHIT = null;
		if(TitleState.curDir != "assets"){
			if(FileSystem.exists(file)) {
				DASHIT = Sound.fromFile(file);
			}
		}
		return DASHIT;
	}
	
	inline static public function lua(script:String,?library:String){
			return getPath('data/$script.lua',TEXT,library);
	}

	inline static public function modchart(song:String,?library:String){
		return getPath('data/$song/modchart.lua',TEXT,library);
	}

	inline static public function image(key:String, ?library:String):Any
	{
		
		var file:BitmapData=null;
		
		if (TitleState.curDir != 'assets'){
			file = BitmapData.fromFile(TitleState.curDir + "/images/" + key + ".png");
		}
		
		//trace(TitleState.curDir + "/images/" + key, FileSystem.exists(TitleState.curDir + "/images/" + key+".png"));
		if(file != null) {
			return file;
		}
		
		
		//trace(key);
		return getPath('images/$key.png', IMAGE, library);
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}
	
	
	
	static public function getbmp(key:String,includePath:Bool=true):FlxGraphic{
		
		if (!imgCache.exists(key)){
			
			var path = "";
			var pulllfromAssets:Bool = false;
			var balls:Array<String> = [TitleState.curDir, "assets"];
			var foundshit = false;
			for (i in balls){
				if (!foundshit){
					var tits = "";
					if(includePath)tits= i.replace('shared:','')  + "/shared/images/";
						//trace(tits + key + ".png");
					if (FileSystem.exists(tits + key + ".png")){
						if(i == "assets")pulllfromAssets = true;
						foundshit = true;
						path = tits + key + ".png";
						trace(path);
					}
				}
			}
			var gra:FlxGraphic;
			var bmp:BitmapData;
			
						trace(TitleState.curDir);
						trace(pulllfromAssets);
			if (pulllfromAssets){
				bmp = OpenFlAssets.getBitmapData("shared:"+path);
			}else{
				bmp = BitmapData.fromFile(path);
			}
			gra = FlxGraphic.fromBitmapData(bmp, false, key);
			gra.persist = true;
			imgCache.set(key, gra);
		}
		return imgCache.get(key);
	}
	

	static public function getTextFile(key:String):String{
		
			
			var path = "";
			var pulllfromAssets:Bool = false;
			var balls:Array<String> = [TitleState.curDir, "assets"];
			var foundshit = false;
			for (i in balls){
				if (!foundshit){
					if (FileSystem.exists(key)){
						if(i == "assets")pulllfromAssets = true;
						foundshit = true;
						path = key;
						trace(path);
					}
				}
			}
			
						trace(TitleState.curDir);
						trace(pulllfromAssets);
						var txt:String = '';
			if (pulllfromAssets){
				txt = OpenFlAssets.getText("shared:"+path);
			}else{
				txt = File.getContent(path);
			}
		return txt;
	}
	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		
		
		
		

		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function getPackerAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}
}
