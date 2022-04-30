// WIP
#if sys
import sys.io.File;
#end
import Song.SwagSong;
import Sys;
import lime.utils.Assets;
import smShit.SMfile;
#if sys
import sys.FileSystem;
#end

class ChartReader extends MusicBeatState
{
	public static function readTxt(songName:String):Array<Array<Float>>
	{
		// var chart = File.getContent('assets/data/charts/$songName.txt').split("\n");

		/*	var dataNotes:Array<Float> = [];

			// this is bad
			var strumTimeRestriction = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

			var bpm:String = null;

			var speed:String = null;

			var mustHitSection:String = null;

			// check shit
			for (i in 0...chart.length)
			{
				var daString = chart[i].split(" ");

				switch (daString[0])
				{
					case "bpm":
						trace("found bpm");
						bpm = daString[1];
					case "speed":
						trace("found speed");
						speed = daString[1];
					case "mustHitSection":
						mustHitSection = daString[1];
				}

				for (j in 0...strumTimeRestriction.length)
				{
					if (chart[i].charAt(0) == strumTimeRestriction[j])
					{
						var daInt = Std.parseFloat(chart[i]);
						dataNotes.push(daInt);
						break;
					}
				}
			}

			var daSpeed = Std.parseFloat(speed);

			PlayState.speed = daSpeed;

			var daBPM = Std.parseFloat(bpm);

			Conductor.changeBPM(daBPM);

			// var mustHit:Bool = Std.string(mustHitSection);

			// data notes shit
			var shitInt:Int = 0;
			var dopeArray:Array<Float> = [];
			var songNotes:Array<Array<Float>> = [];
			var daLength:Int = 2;

			switch (songName)
			{
				case "jumpin":
					daLength = 4;
				case "cough":
					daLength = 4;
			}

			for (i in 0...dataNotes.length)
			{
				shitInt++;

				dopeArray.push(dataNotes[i]);

				if (shitInt > daLength)
				{
					shitInt = 0;
					songNotes.push(dopeArray);
					dopeArray = [];
				}
			}

			return songNotes; */

		return [[]];
	}

	static public function readJson(songName:String)
	{
		// if (!FileSystem.exists('assets/data/charts/$songName.json'))
		// return null;

		// var chart = haxe.Json.parse(sys.io.File.getContent('assets/data/charts/$songName.json'));
		var chart = haxe.Json.parse(Assets.getText('assets/data/charts/$songName.json'));
		return chart.song;
	}

	static public function readSM(songName:String)
	{
		// trace(FileSystem.exists('assets/data/charts$songName.sm'));

		// Debug.stop("ah");

		// SMFile.loadFile('assets/data/charts/$songName.sm');

		var smFile:SMFile;

		smFile = SMFile.loadFile('assets/data/charts/$songName.sm');

		var daChart = haxe.Json.parse(smFile.convertToFNF("assets/data/sm/converted.json"));
		trace(Conductor.bpm);

		return daChart.song;
	}
}
