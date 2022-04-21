package;
import flixel.*;

/**
 * ...
 * @author 
 */
class CutsceneState extends MusicBeatState
{

	public function new() 
	{
		super();
	}
	
	override function create() 
	{
		super.create();
		FlxG.sound.music.stop();
		
		var vid = new FlxVideo("mods/introMod/_append/Twi End Cutscene.mp4");
		vid.finishCallback = end;
		add(vid);
	}
	
	private function end(){
		FlxG.switchState(new StoryMenuState());
	}
	
}