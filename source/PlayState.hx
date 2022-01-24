package;

import flash.events.KeyboardEvent;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

typedef JsonFormat =
{
	song:
	{
		notes:{}
	}
}

typedef Shit = {}

class PlayState extends FlxState
{
	static public var sick:Int;

	var good:Int;
	var bads:Int;

	var shitSprite:FlxSprite;

	var lifeBar:FlxBar;
	var health:Int = 100;

	static public var rating:String;

	public var noteBool = [false, false, false, false];

	var holdTimer:Float = 0.0;

	var accuracyText:FlxText;

	public var staticArrow:Receptors;
	public var daNote:Note;

	public var strumLine:FlxSprite;
	public var playerStrums:FlxTypedGroup<FlxSprite>;

	public var notes:FlxTypedGroup<Note>;

	static public var receptors:FlxTypedGroup<Receptors>;

	override public function create()
	{
		FlxG.watch.add(PlayState, "sick");

		shitSprite = new FlxSprite().makeGraphic(400, 600, FlxColor.WHITE);
		add(shitSprite);

		playerStrums = new FlxTypedGroup<FlxSprite>();
		add(playerStrums);
		receptors = new FlxTypedGroup<Receptors>();
		add(receptors);
		notes = new FlxTypedGroup<Note>();
		add(notes);
		lifeBar = new FlxBar(0, 0, LEFT_TO_RIGHT, Std.int(FlxG.width / 2), 20, null, null, 0, 100);
		lifeBar.numDivisions = 150;
		lifeBar.percent = health;
		lifeBar.createColoredEmptyBar(FlxColor.RED);
		lifeBar.createColoredFilledBar(FlxColor.BLUE);
		lifeBar.screenCenter(XY);
		lifeBar.y += 300;
		add(lifeBar);

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

			staticArrow.setGraphicSize(Std.int(staticArrow.width * 0.7));
			staticArrow.y = 50;
			staticArrow.x = (FlxG.width / 2) - 270;
			staticArrow.x += ((staticArrow.width - 20) * i);
			strumLine.x = (staticArrow.x + staticArrow.width / 2);
			strumLine.alpha = 0;
			receptors.add(staticArrow);
			playerStrums.add(strumLine);
		}

		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, handInput);
		FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, realeasedInput);

		generateSong();

		FlxG.watch.add(Conductor, "songPosition");
		super.create();
	}

	public function generateArrow(noteData:Int, songPosition:Float)
	{
		daNote = new Note(playerStrums.members[noteData].x - 80, songPosition, noteData, 'normal', false); // shit offset i know
		notes.add(daNote);
	}

	// CHART LOL
	public function generateSong()
	{
		var jsonChart:String = sys.io.File.getContent("assets/data/dadbattle-hard.json");
		var chart:JsonFormat = haxe.Json.parse(jsonChart);

		trace(chart.song);

		var savedNotes = [];

		Conductor.songPosition = 0;

		/*for (i in 0...notePos.length)
			{
				generateArrow(notePos[i][0], notePos[i][1]);
		}*/

		generateArrow(0, 1000);
		generateArrow(1, 1000);
		generateArrow(3, 1000);
		generateArrow(2, 1200);
		generateArrow(3, 1400);
		generateArrow(3, 1600);
		generateArrow(0, 1800);
		generateArrow(2, 2000);
		generateArrow(3, 2000);
		generateArrow(1, 2200);
		generateArrow(2, 2400);
		generateArrow(3, 2600);
		generateArrow(0, 2800);
		///////////////////////
		generateArrow(0, 3000);
		generateArrow(1, 3200);
		generateArrow(3, 3400);
		generateArrow(2, 3600);
		generateArrow(3, 3800);
		///////////////////////
		generateArrow(3, 4000);
		generateArrow(0, 4000);
		generateArrow(2, 4000);
		generateArrow(3, 4200);
		generateArrow(1, 4200);
		generateArrow(2, 4400);
		generateArrow(3, 4400);
		generateArrow(0, 4400);
		///////////////////////
		generateArrow(0, 4600);
		generateArrow(1, 4600);
		generateArrow(3, 4600);
		generateArrow(2, 4800);
		generateArrow(3, 5000);
		generateArrow(3, 5200);
		generateArrow(0, 5200);
		generateArrow(2, 5400);
		generateArrow(3, 5600);
		generateArrow(1, 5600);
		generateArrow(2, 5800);
		generateArrow(3, 6000);
		generateArrow(0, 6000);
		///////////////////////
		generateArrow(0, 6200);
		generateArrow(1, 6400);
		generateArrow(3, 6600);
		generateArrow(2, 6600);
		generateArrow(3, 6800);
		///////////////////////
		generateArrow(3, 7000);
		generateArrow(0, 7200);
		generateArrow(2, 7400);
		generateArrow(3, 7600);
		generateArrow(1, 7800);
		generateArrow(2, 7800);
		generateArrow(3, 8000);
		generateArrow(0, 8000);
		///////////////////////

		for (i in 0...notes.length)
		{
			savedNotes.push([notes.members[i].y, notes.members[i].noteData]);
		}
		// trace(savedNotes);
		FlxG.save.data.notes = savedNotes;
	}

	// YOU KNOW WHERE THIS IS COME FROM
	public function handInput(event:KeyboardEvent)
	{
		var key:Int = -1;

		switch (event.keyCode)
		{
			case 81:
				key = 0;
			case 83:
				key = 1;
			case 76:
				key = 2;
			case 77:
				key = 3;
		}

		if (key != -1)
			noteBool[key] = true;

		for (i in 0...noteBool.length)
		{
			if (noteBool[i])
				receptors.members[i].animation.play('pressed');
		}
	}

	// YOU KNOW WHERE THIS IS COME FROM
	public function realeasedInput(event:KeyboardEvent)
	{
		var key:Int = -1;

		switch (event.keyCode)
		{
			case 81:
				key = 0;
			case 83:
				key = 1;
			case 76:
				key = 2;
			case 77:
				key = 3;
		}

		if (key != -1)
			noteBool[key] = false;

		for (i in 0...noteBool.length)
		{
			if (!noteBool[i])
				receptors.members[i].animation.play('static');
		}
	}

	public function addAccuracyText(text:String)
	{
		remove(accuracyText);
		accuracyText = new FlxText(text, 50);
		accuracyText.screenCenter(XY);
		add(accuracyText);
	}

	// SHIT INPUT
	override public function update(elapsed:Float)
	{
		// JUST BULLLSHIT OK
		Conductor.songPosition = 20;

		for (note in notes)
		{
			note.y -= (Conductor.songPosition);
		}

		if (FlxG.keys.justPressed.SEVEN)
			FlxG.switchState(new ChartEditor());

		if (FlxG.keys.justPressed.SPACE)
			generateSong();

		// J U D G E and I N P U T
		// TRASH
		// STILL WORKING ON IT
		for (note in notes)
		{
			if (note.y <= receptors.members[note.noteData].y - 90)
				note.alpha = 0.2;

			if (note.y <= receptors.members[note.noteData].y - 150)
				note.kill();

			var closestNotes = [];

			if (note.canBeHit)
			{
				if (noteBool[note.noteData] && receptors.members[note.noteData].pressed)
				{
					note.kill();
				}
			}

			/*for (i in closestNotes)
				{
					if (i.y <= receptors.members[i.noteData].y - 125)
						closestNotes.remove(i);

					if (receptors.members[i.noteData].animation.name == 'pressed')
					{
						closestNotes.remove(i);
						i.kill();
					}
			}*/
		}

		if (noteBool.contains(true))
		{
			switch (rating)
			{
				case "sick":
					addAccuracyText("SICK");
					sick++;
				case "good":
					addAccuracyText("GOOD");
					good++;
				case "bad":
					addAccuracyText("BAD");
					bads++;
			}
		}

		super.update(elapsed);
	}
}
