package;
import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author bbpanzu
 */
class StageDebug extends MusicBeatState
{
	
	public function new(stageName:String) 
	{
		
		super();
		
		switch(stageName){
			
			case "discord":
				bgColor = 0xFFA2E9AD;
				addSprite( -908.45, -125.35, "pinkie/discord/hills",0.2);
				addSprite( -378.85, -879.85, "pinkie/discord/bigcloud",0.25);
				
				addSprite( 1046.55, 43.95, "pinkie/discord/floathouse2",0.3);
				addSprite( 1198.5, 105.9, "pinkie/discord/groundpiece",0.35);
				addSprite( 210.8, -96.65, "pinkie/discord/tree",0.2);
				
				addAnimPrefix( 355.3, 89.5, "pinkie/discord/cottoncloud1","cottoncloud1",0.2);
				
				addSprite( 575.2, -210.15, "pinkie/discord/floathouse",0.4);
				addSprite( 1106.15, -553.45, "pinkie/discord/citthall",0.5);
				
				addAnimPrefix( 894.65, -38.05, "pinkie/discord/cottoncloud2","cottoncloud2",0.6);
				addAnimPrefix( -148.6, -103.5, "pinkie/discord/cottoncloud3","cottoncloud3",0.7);
				
				addSprite( -447.8, 355.05, "pinkie/discord/discordground", 1);
				
				var bf:Character = new Character(879.2, 234.05, "bf", true);
				add(bf);
				
		}
		
		
		
		
	}
	
	override function update(elapsed:Float) 
	{
		super.update(elapsed);
		var sp = 5;
		if (FlxG.keys.pressed.SHIFT) sp = 20;
		
		if(FlxG.keys.pressed.LEFT)FlxG.camera.scroll.x -= sp;
		if(FlxG.keys.pressed.UP)FlxG.camera.scroll.y -= sp;
		if(FlxG.keys.pressed.RIGHT)FlxG.camera.scroll.x += sp;
		if (FlxG.keys.pressed.DOWN) FlxG.camera.scroll.y += sp;
		
		if(FlxG.keys.pressed.Q)FlxG.camera.zoom -= 0.05;
		if(FlxG.keys.pressed.E)FlxG.camera.zoom += 0.05;
	}
	
	
	public function addSprite(x,y,path:String,scrollFactor:Float=1){
		var sprite:FlxSprite = new FlxSprite(x,y).loadGraphic(Paths.image(path, "shared"));
		sprite.scrollFactor.set(scrollFactor, scrollFactor);
		sprite.active = false;
		sprite.antialiasing = true;
		add(sprite);
	}
	
	public function addAnimPrefix(x,y,path:String,prefix:String,scrollFactor:Float=1){
		var sprite:FlxSprite = new FlxSprite(x, y);
		sprite.frames = Paths.getSparrowAtlas(path, "shared");
		sprite.animation.addByPrefix(prefix,prefix,24);
		sprite.animation.play(prefix);
		sprite.antialiasing = true;
		sprite.scrollFactor.set(scrollFactor, scrollFactor);
		add(sprite);
	}
	public function addAnimIndices(x,y,path:String,prefix:String,indices:Array<Int>,scrollFactor:Float=1){
		var sprite:FlxSprite = new FlxSprite(x, y);
		sprite.frames = Paths.getSparrowAtlas(path, "shared");
		sprite.animation.addByIndices(prefix, prefix, indices, "", 24);
		sprite.animation.play(prefix);
		sprite.antialiasing = true;
		sprite.scrollFactor.set(scrollFactor, scrollFactor);
		add(sprite);
	}
	
}