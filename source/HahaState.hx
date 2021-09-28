package;
import flixel.FlxSprite;
import flixel.*;

/**
 * ...
 * @author bbpanzu
 */
class HahaState extends MusicBeatState
{

	public function new() 
	{
		super();
	}
	
	override function create() 
	{
		super.create();
		
		var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("pinkie/tbc"));
		add(bg);
		FlxG.sound.music.stop();
		FlxG.sound.play(Paths.sound("haha"), 1, false, null, true, goto);
	}
	
	
	function goto(){
		FlxG.switchState(new StoryMenuState());
	}
	
}