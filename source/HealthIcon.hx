package;

import flixel.FlxSprite;
import openfl.display.BitmapData;
import sys.FileSystem;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function changeCharacter(char:String){
		
		antialiasing = true;
		if (TitleState.curDir != "assets"){
			trace(char, TitleState.curDir + '/images/icon-' + char + '.png');
			
			if(FileSystem.exists(TitleState.curDir+'/images/icon-'+char+'.png')){
			
			loadGraphic(BitmapData.fromFile(TitleState.curDir+'/images/icon-'+char+'.png'), true, 150, 150);
			animation.add(char, [0, 1], 0, false);
			}else{
				
				loadGraphic(Paths.image('iconGrid'), true, 150, 150);
				animation.add('face', [10, 11], 0, false);
			}
			
		}else if (char == 'pinkie'){
		loadGraphic(Paths.image('icons'), true, 150, 150);

		animation.add('pinkie', [0, 1], 0, false);
		}else if (char == 'pinkie-hd'){
		loadGraphic(Paths.image('icons-hd'), true, 150, 150);

		animation.add('pinkie-hd', [0, 1], 0, false);
		}else{
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		animation.add('bf', [0, 1], 0, false);
		animation.add('bf-car', [0, 1], 0, false);
		animation.add('bf-christmas', [0, 1], 0, false);
		animation.add('spooky', [2, 3], 0, false);
		animation.add('pico', [4, 5], 0, false);
		animation.add('mom', [6, 7], 0, false);
		animation.add('mom-car', [6, 7], 0, false);
		animation.add('tankman', [8, 9], 0, false);
		animation.add('face', [10, 11], 0, false);
		animation.add('dad', [12, 13], 0, false);
		animation.add('bf-old', [14, 15], 0, false);
		animation.add('gf', [16], 0, false);
		animation.add('lizzy', [16], 0, false);
		animation.add('parents-christmas', [17], 0, false);
		animation.add('monster', [19, 20], 0, false);
		animation.add('monster-christmas', [19, 20], 0, false);
		animation.add('bf-pixel', [21, 21], 0, false);
		animation.add('senpai', [22, 22], 0, false);
		animation.add('senpai-angry', [22, 22], 0, false);
		animation.add('spirit', [23, 23], 0, false);
		animation.add('bf-neb', [24, 25], 0, false);
		}
		if(animation.getByName(char)!=null)
			animation.play(char);
		else
			animation.play("face");
	}
	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		flipX=isPlayer;
		changeCharacter(char);

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
