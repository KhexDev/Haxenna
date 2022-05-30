import Section.SwagSection;
import Song;
import _cool_Util.Paths;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import lime.app.Application;
import smShit.TimingStruct;
import sys.FileSystem;

class ChartEditor extends MusicBeatState
{
	var playing:Bool;

	var notWork:FlxText = new FlxText(10, 100, 0, "DOESNT WORK YET", 50);

	var savedNotes:Array<Dynamic> = FlxG.save.data.notes;
	var chartBG:FlxSprite;

	var staticArrow:FlxSprite;
	var daNote:Note;
	var ghostNote:Note;

	public var notes:FlxTypedGroup<Note>;

	var strumLine:FlxSprite;
	var playerStrums:FlxTypedGroup<FlxSprite>;

	static public var receptors:FlxTypedGroup<FlxSprite>;

	public var lastSongPosition:Float;

	static public var SONG:SwagSong;

	public var songName:String;

	var zoom:Float = 2;

	var notRenderedNotes:Array<Note> = [];
	var renderedNotes:FlxTypedGroup<Note> = new FlxTypedGroup<Note>();

	var strumTimes:Array<Float> = [];

	var beats:Array<Float> = [];

	var bpm:Float;
	var crochet:Float;

	var beatLine:FlxSprite;
	var beatLineGroup:FlxTypedGroup<FlxSprite>;

	var musicVolume:Float = 1;

	// option shit
	var hitSound_checkBox:FlxUICheckBox;
	var canHitSound:Bool;

	var beatHitSound_checkBox:FlxUICheckBox;
	var canBeatHitSound:Bool;

	var beatHitSound:FlxSound;
	var hitSound:FlxSound;

	var mustHitSection_checkBox:FlxUICheckBox;
	var mustHitSection:Bool;

	var goModchart:FlxUIButton;

	override public function create()
	{
		beatHitSound = FlxG.sound.load(Paths.getSound('sound beat tick.wav'));
		hitSound = FlxG.sound.load(Paths.getSound('sound note tick.wav'));

		songName = PlayState.songName;

		SONG = PlayState.SONG;

		trace(SONG.song);
		trace(SONG.eventObjects);

		playing = false;

		chartBG = new FlxSprite().makeGraphic(1000, 2000, FlxColor.GRAY);
		chartBG.screenCenter(X);
		chartBG.x -= 200;
		chartBG.y = 0;
		add(chartBG);

		canHitSound = false;
		hitSound_checkBox = new FlxUICheckBox((chartBG.x + chartBG.width) + 30, chartBG.y, null, null, "hitSound ?", 100, null, function()
		{
			canHitSound = !canHitSound;
		});
		hitSound_checkBox.textIsClickable = false;
		add(hitSound_checkBox);

		canBeatHitSound = false;
		beatHitSound_checkBox = new FlxUICheckBox((chartBG.x + chartBG.width) + 130, chartBG.y, null, null, "beat hit sound ?", 100, null, function()
		{
			canBeatHitSound = !canBeatHitSound;
		});
		beatHitSound_checkBox.textIsClickable = false;
		add(beatHitSound_checkBox);

		mustHitSection_checkBox = new FlxUICheckBox(hitSound_checkBox.x, hitSound_checkBox.y + 30, null, null, "mustHitSection ?", 100, null);
		mustHitSection_checkBox.textIsClickable = false;
		add(mustHitSection_checkBox);

		goModchart = new FlxUIButton(hitSound_checkBox.x, FlxG.height, "MODCHART", function()
		{
			FlxG.switchState(new ModchartEditor());
		});
		goModchart.y -= (goModchart.height + 20);
		add(goModchart);

		beatLineGroup = new FlxTypedGroup<FlxSprite>();
		add(beatLineGroup);

		loadBeatBar();

		playerStrums = new FlxTypedGroup<FlxSprite>();
		add(playerStrums);
		receptors = new FlxTypedGroup<FlxSprite>();
		add(receptors);
		notes = new FlxTypedGroup<Note>();
		add(notes);

		// add(notWork);

		var dataPos = ["LEFT", "DOWN", "UP", "RIGHT"];
		var dataPos2 = ["left", "down", "up", "right"];

		for (i in 0...8)
		{
			strumLine = new FlxSprite();
			staticArrow = new FlxSprite(); // .makeGraphic(100, 100, FlxColor.RED);

			staticArrow.frames = Paths.getSparrowAtlas("NoteType/og/Arrows");
			staticArrow.animation.addByPrefix('static', "arrow" + dataPos[Std.int(i % 4)], 24, false);
			// staticArrow.animation.addByPrefix('pressed', dataPos2[i] + " press", 24, false);
			staticArrow.animation.addByPrefix('confirm', dataPos2[i] + " confirm", 24, false);
			staticArrow.animation.play('static');

			staticArrow.setGraphicSize(Std.int(staticArrow.width * 0.5));

			staticArrow.y = 60;
			staticArrow.x = (FlxG.width / 2) - 600;
			staticArrow.x += ((staticArrow.width - 60) * i) + (i >= 4 ? 50 : 0);
			strumLine.x = (staticArrow.x + staticArrow.width / 2);

			strumLine.alpha = 0;

			receptors.add(staticArrow);
			playerStrums.add(strumLine);
		}

		FlxG.sound.playMusic(Paths.getMusic(songName + ".ogg"));
		FlxG.sound.music.pause();
		Conductor.songPosition = 0;

		TimingStruct.clearTimings();

		loadNotes();

		trace("bpm is " + Conductor.bpm);
		// time to load all timing

		crochet = (bpm / 60) * 1000;

		for (i in 0...150)
		{
			var startBeat = crochet * i;
			var endBeat = crochet * (i + 1);

			TimingStruct.addTiming(startBeat, bpm, endBeat, 0);

			//  trace("startBeat -> "
			// + TimingStruct.getTimingAtBeat(startBeat).startBeat
			// + " endBeat -> "
			// + TimingStruct.getTimingAtBeat(endBeat).endBeat);
		}

		super.create();
	}

	function loadBeatBar()
	{
		for (i in 0...800)
		{
			var beatLine:FlxSprite = new FlxSprite(chartBG.x, 0);
			if (i % 4 == 0)
			{
				beatLine.makeGraphic(Std.int(chartBG.width), 10, FlxColor.RED);
			}
			else
			{
				beatLine.makeGraphic(Std.int(chartBG.width), 10, FlxColor.BLUE);
			}
			beatLineGroup.add(beatLine);
		}

		trace("beat members length" + beatLineGroup.members.length);
	}

	public function loadNotes()
	{
		for (section in SONG.notes)
		{
			for (dataNotes in section.sectionNotes)
			{
				// trace("we good 1");
				// trace(dataNotes);
				var strumTime:Float = dataNotes[0];
				var noteData:Int = Std.int(dataNotes[1] % 4);
				var isBF:Bool = false;

				// beatArray.push([strumTime, new FlxSprite().makeGraphic(Std.int(chartBG.width), 15, FlxColor.RED)]);
				// trace("we good 2");

				var daNote:Note = new Note(0, strumTime, noteData, "normal", true);

				if (section.mustHitSection)
				{
					if (dataNotes[1] < 4)
						isBF = true;
				}
				else
				{
					if (dataNotes[1] > 3)
						isBF = true;
				}

				if (isBF)
				{
					daNote.x = playerStrums.members[noteData + 4].x - 80;
				}
				else
				{
					daNote.x = playerStrums.members[noteData].x - 80;
				}

				daNote.setGraphicSize(Std.int(daNote.width * 0.5));
				notes.add(daNote);

				// trace("we good 3");
			}
			bpm = section.bpm;
		}

		add(notes);

		// beatArray.sort((a, b) -> Std.int(a[0] - b[0]));
	}

	function getSnapFromTime(songPosition:Float):TimingStruct
	{
		var daTiming = TimingStruct.getTimingAtBeat(TimingStruct.getBeatFromTime(songPosition));

		for (i in TimingStruct.AllTimings)
		{
			trace(i.startBeat);
		}

		return null;
	}

	function nearlyEquals(value1:Float, value2:Float, unimportantDifference:Float):Bool
	{
		return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
	}

	function noteDataFromReceptor(note:Note, diff:Float)
	{
		for (i in 0...receptors.members.length)
			if (note.x - receptors.members[i].x <= diff)
			{
				return i;
			}

		return 0;
	}

	public function addNote(noteData:Int)
	{
		var isPresentList:Array<Int> = [];
		var rowNote:Array<Note> = [];
		var needRemove:Bool = false;

		for (note in notes)
		{
			if (nearlyEquals(note.strumTime, Conductor.songPosition, 15))
			{
				FlxG.log.add("is note data is actually: " + noteDataFromReceptor(note, 10));
				isPresentList.push(noteDataFromReceptor(note, 10));
				rowNote.push(note);
			}
		}

		if (isPresentList.contains(noteData))
		{
			trace('removing note at ' + Conductor.songPosition + "noteData : " + noteData);

			for (note in rowNote)
			{
				if (noteDataFromReceptor(note, 10) == noteData)
				{
					note.kill();
					notes.remove(note, true);
					note.destroy();

					for (i in 0...500)
					{
						var startBeat:Float = Conductor.crochet * i;
						var endBeat:Float = Conductor.crochet * (i + 1);

						if (note.strumTime >= startBeat && note.strumTime <= endBeat)
						{
							trace("removing at section : " + i);
							trace(SONG.notes[i]);
							for (data in SONG.notes[i].sectionNotes)
							{
								if (data[0] == Conductor.songPosition && data[1] == noteData)
								{
									var daSection = SONG.notes[i].sectionNotes;

									trace("deleting note data");
									trace("sectionNotes length before: " + SONG.notes[i].sectionNotes.length);
									daSection.remove(data);
									daSection.sort((a, b) -> Std.int(a[0] - b[0]));
									trace("sectionNotes length after: " + SONG.notes[i].sectionNotes.length);
									break;
								}
							}
							break;
						}
					}

					break;
				}
			}
		}
		else
		{
			try
			{
				trace('adding notes at ' + Conductor.songPosition + "noteData : " + noteData);
				var daNote:Note = new Note(receptors.members[noteData].x, Conductor.songPosition, Std.int(noteData % 4), "normal", true);
				daNote.setGraphicSize(Std.int(daNote.width * 0.5));
				notes.add(daNote);

				for (i in 0...500)
				{
					var startBeat:Float = Conductor.crochet * i;
					var endBeat:Float = Conductor.crochet * (i + 1);

					if (daNote.strumTime >= startBeat && daNote.strumTime <= endBeat)
					{
						var daSection = SONG.notes[i].sectionNotes;

						trace("adding at section : " + i);
						trace(SONG.notes[i]);
						trace("sectionNotes length before: " + SONG.notes[i].sectionNotes.length);
						daSection.push([Conductor.songPosition, noteData, 0]);
						daSection.sort((a, b) -> Std.int(a[0] - b[0]));
						trace("sectionNotes length after: " + SONG.notes[i].sectionNotes.length);
						break;
					}
				}
			}
			catch (e)
			{
				trace(e + "huh... something is wrong");
			}
		}
	}

	var snap:Int = 0;
	var snaps:Array<Int> = [1, 2, 4, 6, 8, 12, 16, 24];

	// crochet / 2 -> 8th
	// crochet / 4 -> 16th
	// crochet / 6 -> 24th
	// crochet / 8 -> 32th
	// crochet / 10 -> 40th ?
	// crochet / 12 -> 48th
	// crochet / 14 -> 56th ?
	// crochet / 16 -> 64th
	// crochet / 18 -> 72th ?
	// crochet / 20 -> 80th ?
	// crochet / 22 -> 88th ?
	// crochet / 24 -> 96th
	// crochet / 26 -> 104th ?
	// crochet / 28 -> 112th ?
	// var curBeat:Float;
	var nextBeat:Int;
	var daBeat:Int;

	var curSection:SwagSection;
	var curSectionInt:Int = 0;

	var curStartTime:Float;

	var closestNotes:Array<Note> = [];
	var prevNotes:Array<Note> = [];

	var needResync:Bool = false;

	var lastNote:Note;

	var daPos:Int = 0;

	var curTiming:TimingStruct;

	var shitOffset:Float = 0;

	override public function update(elapsed:Float)
	{
		receptors.forEachAlive(function(daReceptor:FlxSprite)
		{
			if (daReceptor.animation.curAnim.name != "confirm" && daReceptor.animation.curAnim.finished)
			{
				daReceptor.animation.play('static');
			}
		});

		#if debug
		FlxG.watch.addQuick("songPosition", Conductor.songPosition);
		FlxG.watch.addQuick("wheel", FlxG.mouse.wheel * 1000);
		FlxG.watch.addQuick("snap", snap);
		FlxG.watch.addQuick("notes", notes.length);
		FlxG.watch.addQuick("closestNotes", closestNotes.length);
		FlxG.watch.addQuick("curBeat", curBeat);
		try
		{
			FlxG.watch.addQuick("curSectionNotes", SONG.notes[curSectionInt].sectionNotes);
		}
		catch (e)
		{
			trace("CAUTION SECTION IS NULL");
		}
		#end

		if (daBeat != daBeat)
		{
			trace("section startBeat -> "
				+ TimingStruct.AllTimings[Std.int(curBeat)].startBeat + ", section endBeat -> " + TimingStruct.AllTimings[Std.int(curBeat)].endBeat);
		}

		curTiming = TimingStruct.AllTimings[Std.int(curBeat)];

		if (FlxG.keys.justPressed.SPACE)
		{
			playing = !playing;
		}

		if (playing)
		{
			needResync = true;

			Conductor.songPosition += FlxG.elapsed * 1000;

			if (FlxG.sound.music.time > Conductor.songPosition + 200 || FlxG.sound.music.time < Conductor.songPosition - 200)
			{
				FlxG.sound.music.time = Conductor.songPosition;
			}

			if (!FlxG.sound.music.playing)
			{
				FlxG.sound.music.resume();
			}
		}
		else
		{
			FlxG.sound.music.pause();
			// Conductor.songPosition = daSectionInt * (Conductor.steps * snap);
		}

		if (FlxG.keys.justPressed.RIGHT && snap + 1 <= snaps.length - 1)
		{
			snap += 1;
		}
		else if (FlxG.keys.justPressed.LEFT && snap - 1 >= 0)
		{
			snap -= 1;
		}

		FlxG.watch.addQuick("current snap", snaps[snap]);

		var mouse:Float = FlxG.mouse.wheel;

		try
		{
			FlxG.sound.music.volume = musicVolume;
		}

		if (FlxG.keys.pressed.CONTROL)
		{
			if (mouse < 0)
			{
				zoom += 0.1;
			}
			if (mouse > 0)
			{
				zoom -= 0.1;
			}
		}
		else if (FlxG.keys.pressed.SHIFT)
		{
			if (mouse < 0)
			{
				shitOffset += 10;
			}
			else if (mouse > 0)
			{
				shitOffset -= 10;
			}

			if (FlxG.keys.justPressed.LEFT)
			{
				musicVolume -= 0.1;
			}
			else if (FlxG.keys.justPressed.RIGHT)
			{
				musicVolume += 0.1;
			}
		}
		else
		{
			// add
			if (mouse < 0)
			{
				if (needResync)
				{
					needResync = false;
					trace("its timing time boiii up");
					Conductor.songPosition = Conductor.crochet * (curBeat);
					FlxG.sound.music.time = Conductor.songPosition;
				}
				else
				{
					Conductor.songPosition += Conductor.crochet / snaps[snap];
				}

				try
				{
					FlxG.watch.addQuick("curSectionNotes", SONG.notes[curSectionInt].sectionNotes);
				}
				catch (e)
				{
					trace("CAUTION SECTION IS NULL");
				}
			} // sub
			else if (mouse > 0)
			{
				if (Conductor.songPosition < 0)
				{
					Conductor.songPosition = 0;
				}

				if (needResync)
				{
					needResync = false;
					trace("its timing time boiii down");

					// Conductor.songPosition = curTiming.startBeat;
					Conductor.songPosition = Conductor.crochet * (curBeat);
					FlxG.sound.music.time = Conductor.songPosition;
					needResync = false;
				}
				else
				{
					Conductor.songPosition -= Conductor.crochet / snaps[snap];
				}

				try
				{
					FlxG.watch.addQuick("curSectionNotes", SONG.notes[curSectionInt].sectionNotes);
				}
				catch (e)
				{
					trace("CAUTION SECTION IS NULL");
				}
			}
		}

		FlxG.watch.addQuick("beat offsets", shitOffset);

		// j'aurais jamais crue que des produits en croix serait utiles dans ma vie
		// crochet / 2 -> 8th
		// crochet / 4 -> 16th
		// crochet / 6 -> 24th
		// crochet / 8 -> 32th
		// crochet / 10 -> 40th ?
		// crochet / 12 -> 48th
		// crochet / 14 -> 56th ?
		// crochet / 16 -> 64th
		// crochet / 18 -> 72th ?
		// crochet / 20 -> 80th ?
		// crochet / 22 -> 88th ?
		// crochet / 24 -> 96th
		// crochet / 26 -> 104th ?
		// crochet / 28 -> 112th ?

		for (i in 0...beatLineGroup.members.length)
		{
			var daBeat = beatLineGroup.members[i];
			var spaceLineOffset = 80;

			daBeat.y = (receptors.members[0].y - daBeat.height / 2)
				- (Conductor.songPosition - (Conductor.crochet * i)) * (0.45 * FlxMath.roundDecimal(zoom, 2))
				+ spaceLineOffset;
		}

		beatLineGroup.forEachAlive(function(beatLine:FlxSprite)
		{
			if (beatLine.y < FlxG.height && beatLine.y > 0)
			{
				beatLine.active = true;
				beatLine.visible = true;
			}
			else
			{
				beatLine.active = false;
				beatLine.visible = false;
			}
		});

		// beatLineGroup.forEachAlive(function(daBeat:FlxSprite) {});

		// rendering shit
		notes.forEachAlive(function(daNote:Note)
		{
			daNote.y = (receptors.members[daNote.noteData].y - (Conductor.songPosition - daNote.strumTime)) * (0.45 * FlxMath.roundDecimal(zoom, 2));

			if (daNote.wasHit && daNote.strumTime == Conductor.songPosition)
			{
				if (daNote.y > FlxG.height || daNote.y < FlxG.height - FlxG.height - 250)
				{
					daNote.active = false;
					daNote.visible = false;
				}
				else
				{
					daNote.active = true;
					daNote.visible = true;
				}
			}

			if (daNote.strumTime < Conductor.songPosition)
			{
				// receptors.members[daNote.noteData].animation.play('confirm');
			}

			if (nearlyEquals(daNote.strumTime, Conductor.songPosition, 5) && playing && canHitSound)
			{
				trace(daNote.strumTime - Conductor.songPosition);

				FlxG.sound.play(Paths.getSound('sound note tick.wav'), 1);

				// hitSound.play();

				/*if (hitSound.playing)
					{
						hitSound.stop();
						hitSound.play();
					}
					else
					{
						hitSound.play();
				}*/

				// hitSound.play();
			}
		});

		if (FlxG.keys.justPressed.R)
			FlxG.resetState();

		if (FlxG.keys.justPressed.A)
			Conductor.songPosition = 0;

		if (FlxG.keys.justPressed.ENTER)
		{
			if (FlxG.sound.music.playing)
			{
				FlxG.sound.music.stop();
			}

			FlxG.sound.music.time = 0;

			FlxG.switchState(new PlayState());
			PlayState.fromChart = true;
		}
		if (FlxG.keys.justPressed.ONE)
		{
			addNote(0);
		}
		if (FlxG.keys.justPressed.TWO)
		{
			addNote(1);
		}
		if (FlxG.keys.justPressed.THREE)
		{
			addNote(2);
		}
		if (FlxG.keys.justPressed.FOUR)
		{
			addNote(3);
		}
		if (FlxG.keys.justPressed.FIVE)
		{
			addNote(4);
		}
		if (FlxG.keys.justPressed.SIX)
		{
			addNote(5);
		}
		if (FlxG.keys.justPressed.SEVEN)
		{
			addNote(6);
		}
		if (FlxG.keys.justPressed.EIGHT)
		{
			addNote(7);
		}

		if (curSection != null)
		{
			mustHitSection = curSection.mustHitSection;
			mustHitSection_checkBox.checked = curSection.mustHitSection;

			mustHitSection_checkBox.callback = function()
			{
				curSection.mustHitSection = !curSection.mustHitSection;
			}
		}
		else
		{
			trace("wtf");
		}

		super.update(elapsed);
	}

	var beatSound:FlxSound;

	override public function beatHit(curBeat:Int)
	{
		if (playing && canBeatHitSound)
		{
			beatHitSound.play();
		}

		if (playing && curBeat % 4 == 0)
		{
			try
			{
				curSectionInt = Math.floor(curBeat / 4);
				curSection = SONG.notes[curSectionInt];
				/*trace("\n");
					trace("BPM: " + curSection.bpm);
					trace(curSection.mustHitSection);
					trace(curSectionInt);
					try
					{
						trace(curSection.sectionNotes);
					}
					catch (e)
					{
						trace(("sectionNotes is NULL"));
				}*/
			}
			catch (e)
			{
				trace(e);
				trace("current section might be null");
			}
		}
		super.beatHit(curBeat);
	}
}
