package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import sys.io.File;

using StringTools;

class Portrait extends FlxSprite
{

    private var refx:Float;
    private var refy:Float;
    private var shake:Float;
    public var char:String;

    private var resize = 1;

    private var characters:Array<String> = ["bf", "gf", "pinkie"];

    var posTween:FlxTween;
    var alphaTween:FlxTween;
	
    public function new(_x:Float, _y:Float, _character:String){

        super(_x, _y);
		char = _character;
        defineCharacter(_character);
        scrollFactor.set();
        antialiasing = true;

        refx = x;
        refy = y + height;

        playFrame();
        posTween = FlxTween.tween(this, {x: x}, 0.1);
        alphaTween = FlxTween.tween(this, {alpha: alpha}, 0.1);
        hide();

    }

   public  function defineCharacter(_character){

       // _character = characters.contains(_character) ? _character : "bf";

      //  frames = Paths.getSparrowAtlas("portrait/" + _character, "dialogue");

        switch(_character){

           default:
              //  addAnim("default", "noChar instance 1");
				frames = Paths.getSparrowAtlas("portrait/" + _character, "shared");
				
				var filepath = "assets/shared/images/portrait/" + _character + "_portrait.txt";
				
				var rawdata:String = File.getContent(filepath);
				var data = rawdata.split("\n");
				
				for (i in data){
					var thing = i.split(":");
							//trace("DATA: " + thing);
					
					switch(thing[0]){
						case "indices":
							var framess = thing[2].split(",");//gets array
							var frames:Array<Int> = [];
							for (d in 0...framess.length){
								frames[d] = Std.parseInt(framess[d]);//converts stringed numbers to integers
							}
							addAnim2(thing[1], frames);
						case "prefix":
							addAnim(thing[1], thing[2]);
						case "resize":
							addAnim(thing[1], thing[2]);
							setGraphicSize(Std.int(width * Std.parseFloat(thing[1])));
							updateHitbox();
					}
				}
                animation.play("default");
				//name prefix/indices
        

        }

     

    }
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		offset.x = FlxG.random.float( -shake, shake);
		offset.y = FlxG.random.float( -shake, shake);
		
		if (shake > 0) shake-= 0.4;
		
	}
    
    public function addAnim(anim:String, prefix:String){
        animation.addByPrefix(anim,prefix, 24, true);
    }    
    public function addAnim2(anim:String, frames:Array<Int>){
        animation.addByIndices(anim,char+"_portrait",frames,"", 24, true);
    }    

    public function playFrame(?_frame:String = "default"){

        visible = true;

        animation.play(_frame);
        flipX = false;
        updateHitbox();

        x = refx;
        y = refy - height;

    }

    public function hide(){

        alphaTween.cancel();
        posTween.cancel();
        alpha = 1;
        visible = false;

    }

    public function effectFadeOut(?time:Float = 1){

        alphaTween.cancel();
        alpha = 1;
        alphaTween = FlxTween.tween(this, {alpha: 0}, time);

    }

    public function effectFadeIn(?time:Float = 1){

        alphaTween.cancel();
        alpha = 0;
        alphaTween = FlxTween.tween(this, {alpha: 1}, time);

    }

    public function effectExitStageLeft(?time:Float = 1){

        posTween.cancel();
        posTween = FlxTween.tween(this, {x: 0 - width}, time, {ease: FlxEase.circIn});

    }

    public function effectExitStageRight(?time:Float = 1){

        posTween.cancel();
        posTween = FlxTween.tween(this, {x: FlxG.width}, time, {ease: FlxEase.circIn});

    }

    public function effectFlipRight(){

        x = FlxG.width - refx - width;
        y = refy - height;

    }

    public function effectFlipDirection(){
        
        flipX = true;

    }

    public function effectEnterStageLeft(?time:Float = 1){
        
        posTween.cancel();
        var finalX = x;
        x = 0 - width;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.circOut});

    }

    public function effectEnterStageRight(?time:Float = 1){
        
        posTween.cancel();
        var finalX = x;
        x = FlxG.width;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.circOut});
    }

    public function effectToRight(?time:Float = 1){
        
        posTween.cancel();
        var finalX = FlxG.width - refx - width;
        x = refx;
        y = refy - height;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.quintOut});
    }
    public function effectAddY(?Y:Float = 1){
        
        posTween.cancel();
        var finalY = Y+FlxG.height - refy - height;
        x = refx;
        y = refy - height;
        posTween = FlxTween.tween(this, {y: y + Y}, 0.3, {ease: FlxEase.quintOut});
    }
    public function effectAddX(?X:Float = 1){
        
        posTween.cancel();
        var finalX = X+FlxG.width - refx - width;
        x = refx;
        y = refy - height;
        posTween = FlxTween.tween(this, {x: x + X}, 0.3, {ease: FlxEase.quintOut});
    }

    public function effectFromY(?Y:Float = 1){
        
        posTween.cancel();
        var finalY = Y+FlxG.height - refy - height;
        x = refx;
        y = refy - height;
        posTween = FlxTween.tween(this, {y: y + Y}, 0.3, {ease: FlxEase.quintOut,type:BACKWARD});
    }
    public function effectFromX(?X:Float = 1){
        
        posTween.cancel();
        var finalX = X+FlxG.width - refx - width;
        x = refx;
        y = refy - height;
        posTween = FlxTween.tween(this, {x: x + X}, 0.3, {ease: FlxEase.quintOut,type:BACKWARD});
    }

    public function effectToLeft(?time:Float = 1){
        
        posTween.cancel();
        var finalX = refx;
        x = FlxG.width - refx - width;
        y = refy - height;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.quintOut});
    }
    public function effectShake(?time:Float = 1){
        
       shake = time;
    }

   
}
