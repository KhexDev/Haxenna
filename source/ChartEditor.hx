import Section.SwagSection;
import Song;
import _cool_Util.Paths;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class ChartEditor extends FlxState
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

	public var SONG:SwagSong;

	public var songName:String;

	var zoom:Float = 2;

	var notRenderedNotes:Array<Note> = [];
	var renderedNotes:FlxTypedGroup<Note> = new FlxTypedGroup<Note>();

	var strumTimes:Array<Float> = [];

	var beats:Array<Float> = [];

	override public function create()
	{
		songName = PlayState.songName;

		SONG = ChartReader.readJson(songName);

		trace(SONG.song);

		playing = false;

		chartBG = new FlxSprite().makeGraphic(500, 2000, FlxColor.WHITE);
		chartBG.screenCenter(X);
		chartBG.x -= 200;
		chartBG.y = 0;
		add(chartBG);

		playerStrums = new FlxTypedGroup<FlxSprite>();
		add(playerStrums);
		receptors = new FlxTypedGroup<FlxSprite>();
		add(receptors);
		notes = new FlxTypedGroup<Note>();
		add(notes);

		// add(notWork);

		var dataPos = ["LEFT", "DOWN", "UP", "RIGHT"];
		var dataPos2 = ["left", "down", "up", "right"];

		for (i in 0...4)
		{
			strumLine = new FlxSprite();
			staticArrow = new FlxSprite(); // .makeGraphic(100, 100, FlxColor.RED);

			staticArrow.frames = Paths.getSparrowAtlas("normal/Arrows");
			staticArrow.animation.addByPrefix('static', "arrow" + dataPos[i], 24, false);
			// staticArrow.animation.addByPrefix('pressed', dataPos2[i] + " press", 24, false);
			// staticArrow.animation.addByPrefix('confirm', dataPos2[i] + " confirm", 24, false);
			staticArrow.animation.play('static');

			staticArrow.setGraphicSize(Std.int(staticArrow.width * 0.5));

			staticArrow.y = 60;
			staticArrow.x = (FlxG.width / 2) - 470;
			staticArrow.x += ((staticArrow.width - 30) * i);
			strumLine.x = (staticArrow.x + staticArrow.width / 2);

			strumLine.alpha = 0;

			receptors.add(staticArrow);
			playerStrums.add(strumLine);
		}

		FlxG.sound.playMusic(Paths.getMusic(songName + ".ogg"));
		FlxG.sound.music.pause();
		Conductor.songPosition = 0;

		loadNotes();

		super.create();
	}

	var numSection:Int = 0;

	public var sections:Array<SwagSection> = [];

	public function loadNotes()
	{
		for (section in SONG.notes)
		{
			for (dataNotes in section.sectionNotes)
			{
				// trace(dataNotes);
				var strumTime:Float = dataNotes[0];
				var noteData:Int = Std.int(dataNotes[1] % 4);

				var daNote:Note = new Note(playerStrums.members[noteData].x, strumTime, noteData, "normal", true);
				notes.add(daNote);
			}

			Conductor.changeBPM(section.bpm);

			sections.push(section);
		}

		for (i in 0...sections.length)
		{
			strumTimes.push((Conductor.bpm / Conductor.crochet) * i);
			// trace(strumTimes);
		}

		add(notes);
	}

	public function addNote(noteData:Int)
	{
		var isPresentList = [false, false, false, false];
		var rowNote:Array<Note> = [];
		var needRemove:Bool = false;

		for (note in notes)
		{
			if (note.strumTime == Conductor.songPosition)
			{
				isPresentList[note.noteData] = true;
				rowNote.push(note);
			}
		}

		for (note in rowNote)
		{
			if (isPresentList[noteData])
			{
				trace('removing note at ' + Conductor.songPosition + "noteData : " + noteData);

				// isPresentList[noteData] = false;

				for (note in notes)
					if (note.strumTime == Conductor.songPosition)
						if (note.noteData == noteData)
						{
							needRemove = true;
							note.kill();
							notes.remove(note, true);
							note.destroy();
						}
			}
		}

		if (!needRemove)
		{
			trace('placing note at ' + Conductor.songPosition + "noteData : " + noteData);

			var daNote:Note = new Note(playerStrums.members[noteData].x, Conductor.songPosition, noteData, "normal", true);
			notes.add(daNote);
		}
	}

	var snap:Float = 8;
	var curBeat:Int;

	var curSection:SwagSection;

	var curStartTime:Float;

	var closestNotes:Array<Note> = [];
	var prevNotes:Array<Note> = [];

	var needResync:Bool = false;

	var lastNote:Note;

	var daPos:Int = 0;

	var daSectionInt:Float = 0;

	override public function update(elapsed:Float)
	{
		FlxG.watch.addQuick("strumTime", Conductor.songPosition);
		// FlxG.watch.addQuick("songPosition", FlxG.sound.music.time);
		FlxG.watch.addQuick("wheel", FlxG.mouse.wheel * 1000);
		FlxG.watch.addQuick("snap", snap);
		FlxG.watch.addQuick("notes", notes.length);
		FlxG.watch.addQuick("closestNotes", closestNotes.length);
		FlxG.watch.addQuick("curBeat", curBeat);
		FlxG.watch.addQuick("number of section", numSection);
		FlxG.watch.addQuick("section maybe??", daPos);
		FlxG.watch.addQuick("shit test", (Conductor.songPosition / Conductor.crochet));

		if (curSection != null)
			curBeat = Math.floor(Conductor.songPosition / Conductor.crochet);

		for (i in 0...sections.length)
		{
			if (sections[i].startTime < Conductor.songPosition)
			{
				curSection = sections[i];
				break;
			}
		}

		if (curSection != null)
		{
			FlxG.watch.addQuick("cur startTime", curSection.startTime);
		}
		else {}

		if (FlxG.keys.justPressed.SPACE)
			playing = !playing;

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

		daSectionInt = Conductor.songPosition / Conductor.crochet / 4;

		if (FlxG.keys.justPressed.RIGHT && snap + 1 != 192)
			snap += 1;
		if (FlxG.keys.justPressed.LEFT && snap - 1 != -4)
			snap -= 1;

		if (FlxG.keys.pressed.CONTROL)
		{
			if (FlxG.mouse.wheel < 0)
			{
				zoom += 0.1;
			}
			if (FlxG.mouse.wheel > 0)
			{
				zoom -= 0.1;
			}
		}
		else
		{
			// add
			if (FlxG.mouse.wheel < 0)
			{
				daSectionInt = Conductor.songPosition / (Conductor.steps / 4) + (Conductor.steps * snap);
				Conductor.songPosition += (Conductor.steps / 4);
			}

			// sub
			if (FlxG.mouse.wheel > 0)
			{
				daSectionInt = Conductor.songPosition / (Conductor.steps / 4) - (Conductor.steps * snap);
				Conductor.songPosition -= (Conductor.steps / 4);
			}

			// rendering shit
			notes.forEachAlive(function(daNote:Note)
			{
				daNote.y = receptors.members[daNote.noteData].y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(zoom, 2));

				if (daNote.wasHit && daNote.strumTime == Conductor.songPosition)
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

				if (daNote.strumTime > Conductor.songPosition && daNote.strumTime < Conductor.songPosition + 1000)
				{
					if (!closestNotes.contains(daNote))
					{
						closestNotes.push(daNote);
						closestNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
					}
				}
				else
				{
					closestNotes.remove(daNote);

					lastNote = daNote;
				}
			});

			if (FlxG.keys.justPressed.R)
				FlxG.resetState();

			if (FlxG.keys.justPressed.A)
				Conductor.songPosition = 0;

			if (FlxG.keys.justPressed.ENTER)
				FlxG.switchState(new PlayState());

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

			super.update(elapsed);
		}
	}
}
