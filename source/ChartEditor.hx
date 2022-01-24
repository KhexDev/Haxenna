import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class ChartEditor extends FlxState
{
	var playing:Bool;

	var notWork:FlxText = new FlxText(10, 100, 0, "DOESNT WORK YET", 50);

	var savedNotes:Array<Dynamic> = FlxG.save.data.notes;

	var chartBG:FlxSprite;

	var fromPlayState:PlayState;

	var staticArrow:Receptors;
	var daNote:Note;
	var ghostNote:Note;

	public var notes:FlxTypedGroup<Note>;

	var strumLine:FlxSprite;
	var playerStrums:FlxTypedGroup<FlxSprite>;

	static public var receptors:FlxTypedGroup<Receptors>;

	override public function create()
	{
		playing = false;

		chartBG = new FlxSprite().makeGraphic(500, 2000, FlxColor.WHITE);
		chartBG.screenCenter(X);
		chartBG.y = 0;
		add(chartBG);

		playerStrums = new FlxTypedGroup<FlxSprite>();
		add(playerStrums);
		receptors = new FlxTypedGroup<Receptors>();
		add(receptors);
		notes = new FlxTypedGroup<Note>();
		add(notes);

		add(notWork);

		var dataPos = ["LEFT", "DOWN", "UP", "RIGHT"];
		var dataPos2 = ["left", "down", "up", "right"];

		for (i in 0...4)
		{
			strumLine = new FlxSprite();
			staticArrow = new Receptors(); // .makeGraphic(100, 100, FlxColor.RED);

			// staticArrow.loadGraphic("assets/images/NOTE_assets");
			staticArrow.frames = Paths.getSparrowAtlas("Arrows");
			staticArrow.animation.addByPrefix('static', "arrow" + dataPos[i], 24, false);
			staticArrow.animation.addByPrefix('pressed', dataPos2[i] + " press", 24, false);
			staticArrow.animation.addByPrefix('confirm', dataPos2[i] + " confirm", 24, false);
			staticArrow.animation.play('static');

			staticArrow.setGraphicSize(Std.int(staticArrow.width * 0.5));
			staticArrow.y = 50;
			staticArrow.x = (FlxG.width / 2) - 270;
			staticArrow.x += ((staticArrow.width - 30) * i);
			strumLine.x = (staticArrow.x + staticArrow.width / 2);
			strumLine.alpha = 0;
			receptors.add(staticArrow);
			playerStrums.add(strumLine);
		}

		trace(savedNotes);

		for (i in 0...savedNotes.length)
		{
			generateArrow(savedNotes[i][1], savedNotes[i][0]);
		}
		super.create();
	}

	public function generateArrow(noteData:Int, songPosition:Float)
	{
		daNote = new Note(playerStrums.members[noteData].x - 80, songPosition - 500, noteData, 'normal', true); // shit offset i know
		notes.add(daNote);
	}

	override public function update(elapsed:Float)
	{
		ghostNote = new Note(0, 0, 0, "normal", false);
		ghostNote.x = FlxG.mouse.x - (ghostNote.width / 2);
		ghostNote.y = FlxG.mouse.y - (ghostNote.height / 2);
		ghostNote.alpha = 0.3;

		if (!ghostNote.exists)
			add(ghostNote);

		if (FlxG.keys.justPressed.SPACE)
			playing = !playing;

		for (note in notes)
		{
			if (playing)
				note.y -= 20;
			else
				note.y += (FlxG.mouse.wheel * 144);
		}

		if (FlxG.keys.justPressed.BACKSPACE)
			FlxG.switchState(new PlayState());

		super.update(elapsed);
	}
}
