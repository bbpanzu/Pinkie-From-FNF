package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;
import sys.io.File;

using StringTools;

typedef VelocityChange = {
		var startTime:Float;
		var multiplier:Float;
}

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var bpm:Int;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var validScore:Bool;
	var noBG:Bool;
	@:optional var pixelStage:Bool;
	@:optional var sliderVelocities:Array<VelocityChange>;
	@:optional var camBeats:Array<Float>;
	@:optional var initialSpeed:Float;
	@:optional var noteskin:String;
	@:optional var strumskin:String;
	@:optional var notescale:Float;
	@:optional var version:Int;
}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var bpm:Int;
	public var needsVoices:Bool = true;
	public var noBG:Bool = false;
	public var pixelStage:Bool = false;
	public var noteskin:String = 'NOTE_assets';
	public var strumskin:String = 'NOTE_assets';
	public var speed:Float = 1;
	public var noteccale:Float = 0.7;
	public var initialSpeed:Float = 1;
	public var sliderVelocities:Array<VelocityChange>=[];
	public var camBeats:Array<Float>=[];
	public var player1:String = 'bf';
	public var player2:String = 'dad';
	public var version:Int = 1;

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
		
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SwagSong
	{
		var rawJson = File.getContent(Paths.json(folder.toLowerCase() + '/' + jsonInput.toLowerCase())).trim();

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
		}


		return parseJSONshit(rawJson);
	}

	public static function parseJSONshit(rawJson:String):SwagSong
	{
		var cumData = Json.parse(rawJson);
		var swagShit:SwagSong = cast cumData.song;
		swagShit.initialSpeed=1;
		if(cumData.sliderVelocities!=null){
			var shit:Array<VelocityChange> = cast cumData.sliderVelocities;
			shit.sort((a,b)->Std.int(a.startTime-b.startTime));
			swagShit.sliderVelocities = shit;

		}else{
			trace("SLIDERS");
			swagShit.sliderVelocities = [
				{
					startTime:0,
					multiplier:1
				}
			];
		}
		swagShit.validScore = true;
		
		if (swagShit.noteskin == null) swagShit.noteskin = 'NOTE_assets';
		if (swagShit.strumskin== null) swagShit.strumskin = 'NOTE_assets';
		if (swagShit.notescale == null) swagShit.notescale = 0.7;
		return swagShit;
	}
}
