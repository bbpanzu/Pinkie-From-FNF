package;

import animateatlas.AtlasFrameMaker;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import openfl.display.BitmapData;
import sys.FileSystem;
import flixel.FlxG;
import haxe.ds.Map;

using StringTools;

class Startup extends MusicBeatState
{

    /*final songPreload:Array<String> =   ["Tutorial", 
    "Bopeebo", "Fresh", "Dadbattle", 
    "Spookeez", "South", "Monster",
    "Pico", "Philly", "Blammed", 
    "Satin-Panties", "High", "Milf", 
    "Cocoa", "Eggnog", "Winter-Horrorland", 
	"Breaking-Point",
    "Green-Hill", "Racing", "Boom", "Happy-Time"];*/
	public var atlist = [
	'discord_assets',
	'discord_end'
	];
    public static var atlasFrames:Map<String, FlxFramesCollection> = new Map<String, FlxFramesCollection>();
	public static var indx = 0;
    var musicDone:Bool = false;
    var atlasDone:Bool = false;
   
	//var Cacher:GraphicsCacher;
    var loadingText:FlxText;

	override function create()
	{

        FlxG.mouse.visible = false;
        var loadingBG = new FlxSprite(0.0).loadGraphic(Paths.image('loadingscreen'));
        loadingBG.antialiasing = true;
        add(loadingBG);
        

        loadingText = new FlxText(5, FlxG.height - 30, 0, "Preloading Assets...", 24);
        loadingText.setFormat("assets/fonts/vcr.ttf", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        //add(loadingText);

        //new FlxTimer().start(1.1, function(tmr:FlxTimer)
        //{
        //    FlxG.sound.play("assets/sounds/splashSound.ogg");   
        //});
       // sys.thread.Thread.create(() -> {
            preloadAtlas();
			indx ++;
        //});
        super.create();
        
    }

    override function update(elapsed) 
    {
        
      
       if (atlasDone)
        {
        loadingText.text = "Done!";
        //FlxG.sound.play(Paths.sound('confirmMenu'));
			if (indx>=atlist.length){
				
				FlxG.switchState(new TitleState());
			}else{
				FlxG.switchState(new Startup());
			}
        }
            
        super.update(elapsed);

    }

  

    function preloadMusic():Void{
        var music = [];
        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/songs")))
            {
                music.push(i);
            }

        for (i in music)
            {
                FlxG.sound.cache(Paths.inst(i));
                //FlxG.sound.cache(Paths.voices(i));
                trace("cached " + i);
                
            }
        musicDone = true;
    }
    
    /*function preloadMusic():Void{
        for(x in songPreload){
			FlxG.sound.cache(Paths.inst(x));
			trace("Chached " + x);
		}
        musicDone = true;
    }*/

    function preloadAtlas():Void{
			var boobers:FlxFramesCollection = AtlasFrameMaker.construct('assets/shared/images/characters/' + atlist[indx]);
			
			
        atlasFrames.set(atlist[indx], boobers);
		trace(atlist[indx]);
		var testsprite:FlxSprite = new FlxSprite(0, 0);
		testsprite.frames = atlasFrames.get(atlist[indx]);
		add(testsprite);
		
        atlasDone = true;
        
    }
}
