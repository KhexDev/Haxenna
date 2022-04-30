// STOLEN FROM KADE ENGINE AKA POG ENGINE
package smShit;

import Options.Option;
import Section.SwagSection;
import haxe.Exception;
import haxe.Json;
import lime.app.Application;
import lime.utils.Assets;
#if sys
import sys.io.File;
#end

class SMFile
{
	public static function loadFile(path:String):SMFile
	{
		// Debug.stop(path);

		// trace(Assets.getText(path));

		// return new SMFile(File.getContent(path).split('\n'));

		return new SMFile(Assets.getText(path).split('\n'));
	}

	private var _fileData:Array<String>;

	public var isDouble:Bool = false;

	public var isValid:Bool = true;

	public var _readTime:Float = 0;

	public var header:SMHeader;
	public var measures:Array<SMMeasure>;

	public var bpm:Float = 0;
	public var crochet:Float = 0;
	public var step:Float = 0;

	var bpmList:Array<Array<Float>> = [];

	public function new(data:Array<String>)
	{
		trace("making da conversion");

		// trace(data);

		try
		{
			_fileData = data;

			// Gather header data
			var headerData = "";
			var inc = 0;
			while (!StringTools.contains(data[inc + 1], "//"))
			{
				headerData += data[inc];
				inc++;
				trace(data[inc]);
			}

			// trace(headerData);

			var checkData = headerData.split(";");

			for (i in checkData)
			{
				var value = i.split(":")[0];
				var daValue = i.split(":")[1];
				trace(value + "->" + daValue);

				if (value == "#BPMS")
				{
					var daBpm = daValue.split("=")[1];
					trace(daValue);
					bpm = Std.parseFloat(daBpm);
					trace(bpm);
				}

				if (value == "#OFFSET")
				{
					trace(daValue);
					var daOffset = Std.parseFloat(daValue);
					Conductor.offsets = daOffset;
				}
			}

			trace("we good");

			header = new SMHeader(headerData.split(';'));

			trace("we good 2");

			if (_fileData.toString().split("#NOTES").length > 2)
			{
				Application.current.window.alert("The chart must only have 1 difficulty, this one has "
					+ (_fileData.toString().split("#NOTES").length - 1),
					"SM File loading ("
					+ header.TITLE
					+ ")");
				isValid = false;
				return;
			}

			trace("we good 3");

			/*if (!StringTools.contains(header.MUSIC.toLowerCase(), "ogg"))
				{
					Application.current.window.alert("The music MUST be an OGG File, make sure the sm file has the right music property.",
						"SM File loading (" + header.TITLE + ")");
					isValid = false;
					return;
			}*/

			trace("we good 4");

			// check if this is a valid file, it should be a dance double file.
			inc += 3; // skip three lines down
			/*if ((!StringTools.contains(data[inc], "dance-double:") || !StringTools.contains(data[inc], "dance-couple:"))
					&& !StringTools.contains(data[inc], "dance-single"))
				{
					Application.current.window.alert("The file you are loading is neither a Dance Double chart or a Dance Single chart",
						"SM File loading (" + header.TITLE + ")");
					isValid = false;
					return;
			}*/

			trace("we good 5");

			if (StringTools.contains(data[inc], "dance-double:"))
				isDouble = true;
			if (isDouble)
				trace('this is dance double');

			trace("we good 6");

			inc += 5; // skip 5 down to where da notes @

			measures = [];

			var measure = "";

			trace(data[inc - 1]);

			for (ii in inc...data.length)
			{
				var i = data[ii];
				if (StringTools.contains(i, ",") || StringTools.contains(i, ";"))
				{
					measures.push(new SMMeasure(measure.split('\n')));
					// trace(measures);
					trace(measures.length);
					measure = "";
					continue;
				}
				measure += i + "\n";
			}
			trace(measures.length + " Measures");
		}
		catch (e:Exception)
		{
			Application.current.window.alert("Failure to load file.\n" + e, "SM File loading");
		}
	}

	public function convertToFNF(saveTo:String):String
	{
		// array's for helds
		var heldNotes:Array<Array<Dynamic>>;

		if (isDouble) // held storage lanes
			heldNotes = [[], [], [], [], [], [], [], []];
		else
			heldNotes = [[], [], [], []];

		// variables

		var measureIndex = 0;
		var currentBeat:Float = 0;
		var output = "";

		// init a fnf song

		var song = {
			song: header.TITLE,
			notes: [],
			eventObjects: [],
			bpm: header.getBPM(0),
			needsVoices: true,
			player1: 'bf',
			player2: 'gf',
			gfVersion: 'gf',
			noteStyle: 'normal',
			stage: 'stage',
			speed: 1.0,
			validScore: false,
			chartVersion: "",
		};

		// lets check if the sm loading was valid

		if (!isValid)
		{
			var json = {
				"song": song
			};

			var data:String = Json.stringify(json, null, " ");
			// File.saveContent(saveTo, data);
			return data;
		}

		// aight time to convert da measures

		trace("Converting measures");

		// adding all timing possible i guess ?
		crochet = (bpm / 60) * 1000;

		for (i in 0...100)
		{
			var startBeat = crochet * i;
			var endBeat = crochet * (i + 1);

			// trace("startBeat : " + crochet * i + " endBeat : " + crochet * (i + 1));

			TimingStruct.addTiming(startBeat, bpm, endBeat, 0);

			// trace(TimingStruct.getTimeFromBeat(currentBeat));

			trace("startBeat : " + TimingStruct.AllTimings[i].startBeat + " endBeat : " + TimingStruct.AllTimings[i].endBeat + "i: " + i);
		}

		for (measure in measures)
		{
			trace("converting...1");
			// private access since _measure is private
			@:privateAccess
			var lengthInRows = 192 / (measure._measure.length - 1);

			trace("converting...2");

			var rowIndex = 0;

			// section declaration

			var section = {
				sectionNotes: [],
				lengthInSteps: 16,
				typeOfSection: 0,
				startTime: 0.0,
				endTime: 0.0,
				mustHitSection: false,
				bpm: header.getBPM(0),
				changeBPM: false,
				altAnim: false
			};

			// if it's not a double always set this to true

			if (!isDouble)
			{
				Option.middleScroll = true;
				section.mustHitSection = true;
			}
			else
			{
				Option.middleScroll = false;
			}

			// trace("converting...3");

			@:privateAccess
			for (i in 0...measure._measure.length - 1)
			{
				// trace("converting...3.1");
				var noteRow = (measureIndex * 192) + (lengthInRows * rowIndex);

				var notes:Array<String> = [];

				for (note in measure._measure[i].split(''))
				{
					// trace("converting...3.2");
					// output += note;
					notes.push(note);
				}

				currentBeat = noteRow / 48;

				if (currentBeat % 4 == 0)
				{
					// ok new section time
					song.notes.push(section);
					section = {
						sectionNotes: [],
						lengthInSteps: 16,
						typeOfSection: 0,
						startTime: 0.0,
						endTime: 0.0,
						mustHitSection: false,
						bpm: header.getBPM(0),
						changeBPM: false,
						altAnim: false
					};
					if (!isDouble)
						section.mustHitSection = true;
				}

				var seg = TimingStruct.getTimingAtBeat(currentBeat);

				var timeInSec:Float = (seg.startTime + ((currentBeat) / (seg.bpm / 60))) - Conductor.offsets;

				// trace("converting...3.5");

				var rowTime = timeInSec * 1000;

				// output += " - Row " + noteRow + " - Time: " + rowTime + " (" + timeInSec + ") - Beat: " + currentBeat + " - Current BPM: " + header.getBPM(currentBeat) + "\n";

				var index = 0;

				for (i in notes)
				{
					// if its a mine lets skip (maybe add mines in the future??)
					if (i == "M")
					{
						trace("found mine");
						index++;
						continue;
					}

					// trace("converting...3.4");

					// get the lane and note type
					var lane = index;
					var numba = Std.parseInt(i);

					// switch through the type and add the note

					switch (numba)
					{
						case 1: // normal
							section.sectionNotes.push([rowTime, lane, 0, 0, currentBeat]);
						case 2: // held head
							heldNotes[lane] = [rowTime, lane, 0, 0, currentBeat];
						case 3: // held tail
							var data = heldNotes[lane];
							var timeDiff = rowTime - data[0];
							section.sectionNotes.push([data[0], lane, timeDiff, 0, data[4]]);
							heldNotes[index] = [];
						case 4: // roll head
							heldNotes[lane] = [rowTime, lane, 0, 0, currentBeat];
					}
					index++;
				}

				rowIndex++;
			}

			// trace("converting...4");

			// push the section

			song.notes.push(section);

			// output += ",\n";

			measureIndex++;
		}

		for (i in 0...song.notes.length) // loops through sections
		{
			var section = song.notes[i];

			var currentBeat = 4 * i;

			var currentSeg = TimingStruct.getTimingAtBeat(currentBeat);

			var start:Float = (currentBeat - currentSeg.startBeat) / (currentSeg.bpm / 60);

			section.startTime = (currentSeg.startTime + start) * 1000;

			if (i != 0)
				song.notes[i - 1].endTime = section.startTime;
			section.endTime = Math.POSITIVE_INFINITY;
		}

		// File.saveContent("fuac" + header.TITLE, output);

		/*if (header.changeEvents.length != 0)
			{
				song.eventObjects = header.changeEvents;
		}*/
		/*var newSections = [];
			for (s in 0...song.notes.length) // lets go ahead and make sure each note is actually in their own section haha
			{
				var sec:SwagSection = {
					startTime: song.notes[s].startTime,
					endTime: song.notes[s].endTime,
					lengthInSteps: 16,
					bpm: song.bpm,
					changeBPM: false,
					mustHitSection: song.notes[s].mustHitSection,
					sectionNotes: [],
					typeOfSection: 0,
					altAnim: song.notes[s].altAnim
				};
				for (i in song.notes)
				{
					for (ii in i.sectionNotes)
					{
						if (ii[0] >= sec.startTime && ii[0] < sec.endTime)
							sec.sectionNotes.push(ii);
					}
				}
				newSections.push(sec);
		}*/

		// WE ALREADY DO THIS

		// song.notes = newSections;

		// save da song

		// song.chartVersion = Song.latestChart;

		var json = {
			"song": song
		};

		var data:String = Json.stringify(json, null, " ");
		// File.saveContent(saveTo, data);
		return data;
	}
}
