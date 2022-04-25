package;
import flixel.*;

/**
 * ...
 * @author 
 */
class CutsceneState extends MusicBeatState
{
	var vido:String = "mods/introMod/_append/Twi End Cutscene.mp4";
	var next:Void->Void;
	public function new(vido:String = "mods/introMod/_append/Twi End Cutscene.mp4",next:Void->Void) 
	{
		super();
		this.vido = vido;
		this.next = next;
	}
	
	override function create() 
	{
		super.create();
		FlxG.sound.music.stop();
		
		var vid = new FlxVideo(vido);
		vid.finishCallback = next;
		add(vid);
	}
	
	public static function end(){
		Conductor.changeBPM(110);
		FlxG.switchState(new StoryMenuState());
	}
	
}