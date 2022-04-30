package;

import Options.Option;
import Section.SwagSection;
import Section;
import Song;
import Sys;
import _cool_Util.CoolShit;
import _cool_Util.Paths;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.FlxTrail;
import flixel.addons.text.FlxTextField;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.actions.FlxActionManager;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import from_another_world.ChartParser;
import lime.app.Application;
import lime.graphics.Image;
import openfl.Assets;
import openfl.events.KeyboardEvent;
import openfl.utils.Assets as OpenFlAssets;
import smShit.TimingStruct;

using StringTools;

#if sys
import sys.FileSystem;
#end

class PlayState extends MusicBeatState
{
	// scroll speeed
	static public var speed:Float = 2.5;

	var edition:String = "PUBLIC-ALPHA";

	static public var songName:String;

	var lifeBar:FlxBar;
	var health:Float = 100;

	var songPositionBar:FlxBar;

	static public var rating:String;

	public var noteBool = [false, false, false, false];
	public var holdBool = [false, false, false, false];

	var holdTimer:Float = 0.0;
	var accuracyText:FlxText;

	var staticArrow:FlxSprite;
	var strumLine:FlxSprite;
	var playerStrums:FlxTypedGroup<FlxSprite>;
	var cpuStrums:FlxTypedGroup<FlxSprite>;

	public var notes:FlxTypedGroup<Note>;
	public var holdNotes:FlxTypedGroup<Note>;

	public var receptors:FlxTypedGroup<FlxSprite>;
	public var cpuReceptors:FlxTypedGroup<FlxSprite>;

	public var daSong:FlxSound;

	var infoText:FlxText;
	var watermark:FlxText;
	var debugInfos:FlxText;

	public var accuracy:Float = 100.000;
	public var totalHit:Float;
	public var totalPlayed:Float;

	public var sick:Int;
	public var good:Int;
	public var bad:Int;
	public var misses:Int;

	public var elapsTimer:Float;

	public var downScroll:Bool = false;

	public var started:Bool;

	public var vocals:FlxSound;

	var actionManager:FlxActionManager;
	var controls:Control;

	var offsetsTest:Bool = false;

	var shitBG:FlxSprite;

	var camGAME:FlxCamera;
	var camHUD:FlxCamera;

	var camFollow:FlxObject;

	var bf:Character;

	var isSM:Bool = false;

	function generateStaticArrow(player:Int = 0)
	{
		if (player == 0)
		{
			var dataPos = ["LEFT", "DOWN", "UP", "RIGHT"];
			var dataPos2 = ["left", "down", "up", "right"];

			for (i in 0...4)
			{
				strumLine = new FlxSprite();
				staticArrow = new FlxSprite(); // .makeGraphic(100, 100, FlxColor.RED);

				staticArrow.scrollFactor.set();

				staticArrow.frames = Paths.getSparrowAtlas("og/Arrows");

				staticArrow.animation.addByPrefix('static', "arrow" + dataPos[i], 24, false);
				staticArrow.animation.addByPrefix('pressed', dataPos2[i] + " press", 24, false);
				staticArrow.animation.addByPrefix('confirm', dataPos2[i] + " confirm", 24, false);
				staticArrow.animation.play('static');

				staticArrow.setGraphicSize(Std.int(staticArrow.width * 0.7));
				staticArrow.antialiasing = true;
				staticArrow.y = 30;
				staticArrow.x = (FlxG.width / 2) - 270; // 270 midllescroll
				staticArrow.x += ((staticArrow.width - 35) * i);
				staticArrow.centerOffsets();

				strumLine.x = (staticArrow.x + staticArrow.width / 2);
				strumLine.y = (staticArrow.y + staticArrow.height / 2);
				strumLine.alpha = 0;
				receptors.add(staticArrow);
				playerStrums.add(strumLine);
			}
		}

		if (player == 1)
		{
			var dataPos = ["LEFT", "DOWN", "UP", "RIGHT"];
			var dataPos2 = ["left", "down", "up", "right"];

			for (i in 0...4)
			{
				strumLine = new FlxSprite();
				staticArrow = new FlxSprite(); // .makeGraphic(100, 100, FlxColor.RED);

				staticArrow.scrollFactor.set();

				staticArrow.frames = Paths.getSparrowAtlas("og/Arrows");

				staticArrow.animation.addByPrefix('static', "arrow" + dataPos[i], 24, false);
				staticArrow.animation.addByPrefix('pressed', dataPos2[i] + " press", 24, false);
				staticArrow.animation.addByPrefix('confirm', dataPos2[i] + " confirm", 24, false);
				staticArrow.animation.play('static');

				staticArrow.setGraphicSize(Std.int(staticArrow.width * 0.7));
				staticArrow.antialiasing = true;
				staticArrow.y = 30;
				staticArrow.x = (FlxG.width / 2); // 270 midllescroll
				staticArrow.x += ((staticArrow.width - 35) * i);
				staticArrow.centerOffsets();

				strumLine.x = (staticArrow.x + staticArrow.width / 2);
				strumLine.y = (staticArrow.y + staticArrow.height / 2);
				strumLine.alpha = 0;
				receptors.add(staticArrow);
				playerStrums.add(strumLine);
			}
		}

		if (player == 2)
		{
			var dataPos = ["LEFT", "DOWN", "UP", "RIGHT"];
			var dataPos2 = ["left", "down", "up", "right"];

			for (i in 0...4)
			{
				strumLine = new FlxSprite();
				staticArrow = new FlxSprite(); // .makeGraphic(100, 100, FlxColor.RED);

				staticArrow.scrollFactor.set();

				staticArrow.frames = Paths.getSparrowAtlas("og/Arrows");

				staticArrow.animation.addByPrefix('static', "arrow" + dataPos[i], 24, false);
				staticArrow.animation.addByPrefix('pressed', dataPos2[i] + " press", 24, false);
				staticArrow.animation.addByPrefix('confirm', dataPos2[i] + " confirm", 24, false);
				staticArrow.animation.play('static');

				staticArrow.setGraphicSize(Std.int(staticArrow.width * 0.7));
				staticArrow.antialiasing = true;
				staticArrow.y = 30;
				staticArrow.x = (FlxG.width / 2) - 650; // 270 midllescroll
				staticArrow.x += ((staticArrow.width - 35) * i);
				staticArrow.centerOffsets();

				strumLine.x = (staticArrow.x + staticArrow.width / 2);
				strumLine.y = (staticArrow.y + staticArrow.height / 2);
				strumLine.alpha = 0;
				cpuReceptors.add(staticArrow);
				cpuStrums.add(strumLine);
			}
		}
	}

	override public function create()
	{
		actionManager = new FlxActionManager();
		controls = new Control();
		actionManager.addActions([controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT]);

		FlxG.inputs.add(actionManager);

		songName = Option.songName;

		// camGame = new FlxCamera()

		// FlxG.cameras.reset()

		camFollow = new FlxObject();
		camFollow.visible = false;
		add(camFollow);

		FlxG.camera.follow(camFollow);

		shitBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		// add(shitBG);

		bf = new Character();
		bf.x = (FlxG.width / 2) + 100 - (bf.width / 2);
		// add(bf);

		rating = null;

		playerStrums = new FlxTypedGroup<FlxSprite>();
		add(playerStrums);
		cpuStrums = new FlxTypedGroup<FlxSprite>();
		add(cpuStrums);
		cpuReceptors = new FlxTypedGroup<FlxSprite>();
		add(cpuReceptors);
		receptors = new FlxTypedGroup<FlxSprite>();
		add(receptors);
		notes = new FlxTypedGroup<Note>();
		add(notes);

		// notSpawnNotes = new FlxTypedGroup<Note>();
		// add(notSpawnNotes);

		lifeBar = new FlxBar(0, 0, LEFT_TO_RIGHT, Std.int(FlxG.width / 2), 20, null, 'health', 0, 100, true);
		lifeBar.createColoredEmptyBar(FlxColor.RED);
		lifeBar.createColoredFilledBar(FlxColor.BLUE);
		lifeBar.screenCenter(XY);
		lifeBar.y += 300;
		lifeBar.numDivisions = 1000;
		lifeBar.scrollFactor.set();
		add(lifeBar);

		songPositionBar = new FlxBar(FlxG.width / 2, 10, LEFT_TO_RIGHT, Std.int(FlxG.width / 2), 20, null, null, 0, 100);
		songPositionBar.createColoredEmptyBar(FlxColor.BLACK, false);
		songPositionBar.createColoredFilledBar(FlxColor.GREEN, false);
		// add(songPositionBar);

		if (Option.middleScroll)
		{
			generateStaticArrow();
		}
		else
		{
			generateStaticArrow(Std.int(Option.players));
			generateStaticArrow(2);
		}

		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, handInput);
		FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, realeasedInput);

		// FlxG.sound.cache(Paths.getMusic('$songName.ogg'));
		FlxG.sound.playMusic(Paths.getMusic('$songName.ogg'), 1, false);
		FlxG.sound.music.volume = 0;

		generateSong(songName);

		// just in case
		Conductor.songPosition = 0;
		FlxG.sound.music.time = 0;

		infoText = new FlxText(0, 0, 0, "Combo Break: 0 / " + " Accuracy: " + Std.string(100), 16);
		infoText.y = FlxG.height - 50;
		infoText.x = (FlxG.width / 2) - 250;
		infoText.scrollFactor.set();
		add(infoText);

		watermark = new FlxText(0, FlxG.height, 0, "KHEX ENGINE | " + edition + " | v1.5 | " + songName, 26);
		watermark.font = Paths.getFonts("funkin");
		watermark.y -= 30;
		watermark.scrollFactor.set();
		add(watermark);

		add(accuracyText);

		if (songName == "disruption")
		{
			var noGhost:FlxText = new FlxText(0, FlxG.height - 150, 0, "GHOST TAPPING FORCED OFF FUCK YOU", 28);
			noGhost.scrollFactor.set();
			add(noGhost);
		}

		super.create();
	}

	var songStarted:Bool = false;

	#if debug
	public function generateArrow(noteData:Int, songPosition:Float, susLength:Float = 0, isLift:Bool = false)
	{
		var daNote = new Note(playerStrums.members[Std.int(noteData)].x - 80, songPosition, noteData, 'normal', false, false, false, (isLift ? true : false));
		daNote.susLength = susLength;
		notes.add(daNote);

		if (susLength != 0)
		{
			for (i in 0...Std.int(susLength - 1))
			{
				var susNote = new Note(playerStrums.members[noteData].x - 80, daNote.strumTime, noteData, 'normal', false, true, false);
				susNote.antialiasing = true;
				// trace(i);
				susNote.x += 40;
				susNote.strumTime += ((daNote.height - 130) * i);
				susNote.isChildren = true;
				daNote.children.push(susNote);
				notes.add(susNote);
				// trace(susNote.isTail);
			}
		}
	}
	#end

	public function loadChart(name:String) {}

	public var notSpawnNotes:Array<Note> = [];
	public var notSpawnSus:Array<Note> = [];

	var SONG:SwagSong;

	public function generateSong(songName:String)
	{
		var savedNotes = [];

		health = 50;

		var type:Int = 1;

		for (i in 0...150)
		{
			var startBeat = Conductor.crochet * i;
			var endBeat = Conductor.crochet * (i + 1);

			TimingStruct.addTiming(startBeat, Conductor.bpm, endBeat, Conductor.offsets);

			// trace(TimingStruct.get)
		}

		#if !sys
		type = 0;
		#else
		if (FileSystem.exists('assets/data/charts/$songName.sm'))
		{
			type = 2;
			isSM = true;
		}
		else if (FileSystem.exists("assets/data/charts/" + songName + ".json"))
		{
			type = 0;
		}
		#end

		if (type == 0)
		{
			SONG = ChartReader.readJson(songName);

			speed = SONG.speed;

			for (section in SONG.notes)
			{
				Conductor.changeBPM(section.bpm);

				for (dataNotes in section.sectionNotes)
				{
					#if debug
					trace(dataNotes);
					#end

					if (dataNotes[1] == -1)
						continue;

					if (dataNotes[1] > 7)
						trace("found mine ?" + dataNotes[1]);

					var gottaHit:Bool = false;

					var strumTime:Float = dataNotes[0];
					var noteData:Int = Std.int(dataNotes[1] % 4);
					var susLenght = dataNotes[2];

					if (Option.opponent)
					{
						// da code
						if (section.mustHitSection)
							if (dataNotes[1] > 3)
								gottaHit = true;
						if (!section.mustHitSection)
							if (dataNotes[1] < 4)
								gottaHit = true;
					}
					else
					{
						if (section.mustHitSection)
							if (dataNotes[1] < 4)
								gottaHit = true;
						if (!section.mustHitSection)
							if (dataNotes[1] > 3)
								gottaHit = true;
					}

					if (gottaHit)
					{
						var daNote:Note = new Note(playerStrums.members[Std.int(noteData)].x, strumTime, noteData, "normal");

						daNote.scrollFactor.set();

						daNote.mustPress = true;

						if (susLenght != 0 && susLenght > 10)
						{
							for (i in 0...Math.floor(susLenght))
							{
								var susNote:Note = new Note(playerStrums.members[noteData].x, strumTime, noteData, "normal", false, true, false, false);

								var stepHeight = ((0.45 * Conductor.stepCrochet) * FlxMath.roundDecimal(Option.scrollSpeed == 1 ? PlayState.speed : Option.scrollSpeed,
									2));

								susNote.scrollFactor.set();

								susNote.mustPress = true;

								susNote.scale.y = 5;
								// susNote.scale.y = 5 / ();
								susNote.updateHitbox();

								// i want to kill myself
								susNote.strumTime += ((susNote.height * i) / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed));

								// susNote.strumTime += ((daNote.y + (susNote.height * i)));
								susNote.x += 64;
								susNote.parent = daNote;
								// notSpawnNotes.push(susNote);

								if (susNote.strumTime >= Math.floor(daNote.strumTime + susLenght))
								{
									susNote.isTail = true;
									break;
								}
							}
						}
						notSpawnNotes.push(daNote);
						notSpawnNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
					}
					else if (!Option.middleScroll)
					{
						var daNote:Note = new Note(cpuStrums.members[Std.int(noteData)].x, strumTime, noteData, "normal");

						daNote.scrollFactor.set();

						daNote.mustPress = false;

						if (susLenght != 0 && susLenght > 10)
						{
							for (i in 0...Math.floor(susLenght))
							{
								var susNote:Note = new Note(cpuStrums.members[noteData].x, strumTime, noteData, "normal", false, true, false, false);

								susNote.mustPress = false;

								susNote.scrollFactor.set();

								// susNote.scale.y = (Conductor.steps * 0.45) / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed);
								susNote.height = 5;
								susNote.updateHitbox();

								// var curTiming = TimingStruct.

								// i want to kill myself
								// susNote.strumTime += ((daNote.y + (susNote.height / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed))) * i);
								susNote.strumTime += ((susNote.height * i) / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed));
								susNote.x += 64;
								susNote.parent = daNote;
								// notSpawnNotes.push(susNote);

								if (susNote.strumTime >= Math.floor(daNote.strumTime + susLenght))
								{
									susNote.isTail = true;
									break;
								}
							}
						}
						notSpawnNotes.push(daNote);
						notSpawnNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
					}
				}
			}

			Conductor.songPosition = 0;
			Conductor.songPosition -= Conductor.crochet * 5;
		}
		else if (type == 1)
		{
			var songNotes:Array<Array<Float>> = [];

			songNotes = ChartReader.readTxt(songName);

			for (dalNote in songNotes)
			{
				var noteData:Int = 0;

				// seems logic to me
				switch (Math.round(dalNote[1] % 4))
				{
					case 0:
						noteData = 0;
					case 1:
						noteData = 1;
					case 2:
						noteData = 2;
					case 3:
						noteData = 3;
				}

				var strumTime:Float = dalNote[0];

				var daNote:Note = new Note(playerStrums.members[noteData].x, strumTime, noteData, "normal");
				notSpawnNotes.push(daNote);

				var susLenght:Float = dalNote[2];

				daNote.susLength = susLenght;

				if (susLenght != 0 && susLenght > 10)
				{
					for (i in 0...Math.floor(susLenght))
					{
						var susNote:Note = new Note(playerStrums.members[noteData].x, strumTime, noteData, "normal", false, true, false, false);

						// i want to kill myself
						susNote.strumTime += ((daNote.y + ((susNote.height / 2.4) / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed))) * i);
						susNote.x += 40;
						susNote.parent = daNote;
						notSpawnNotes.push(susNote);

						if (susNote.strumTime > daNote.strumTime + susLenght)
						{
							susNote.isTail = true;
							break;
						}
					}
				}
			}
		}
		else if (type == 2)
		{
			var SONG:SwagSong = ChartReader.readSM(songName);

			trace(SONG);

			speed = SONG.speed;

			for (section in SONG.notes)
			{
				trace(section.bpm);
				Conductor.changeBPM(0);

				for (dataNotes in section.sectionNotes)
				{
					#if debug
					trace(dataNotes);
					#end

					if (dataNotes[1] == -1)
						continue;

					if (dataNotes[1] > 7)
						trace("found mine ?" + dataNotes[1]);

					var gottaHit:Bool = false;

					var strumTime:Float = dataNotes[0];
					var noteData:Int = Std.int(dataNotes[1] % 4);
					var susLenght = dataNotes[2];

					if (Option.opponent)
					{
						// da code
						if (section.mustHitSection)
							if (dataNotes[1] > 3)
								gottaHit = true;
						if (!section.mustHitSection)
							if (dataNotes[1] < 4)
								gottaHit = true;
					}
					else
					{
						if (section.mustHitSection)
							if (dataNotes[1] < 4)
								gottaHit = true;
						if (!section.mustHitSection)
							if (dataNotes[1] > 3)
								gottaHit = true;
					}

					if (gottaHit)
					{
						var daNote:Note = new Note(playerStrums.members[Std.int(noteData)].x, strumTime, noteData, "normal");

						daNote.scrollFactor.set();

						daNote.mustPress = true;

						if (susLenght != 0 && susLenght > 10)
						{
							for (i in 0...Math.floor(susLenght))
							{
								var susNote:Note = new Note(playerStrums.members[noteData].x, strumTime, noteData, "normal", false, true, false, false);

								var stepHeight = ((0.45 * Conductor.stepCrochet) * FlxMath.roundDecimal(Option.scrollSpeed == 1 ? PlayState.speed : Option.scrollSpeed,
									2));

								susNote.scrollFactor.set();

								susNote.mustPress = true;

								susNote.scale.y = 5 / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed);
								// susNote.scale.y = 5 / ();
								susNote.updateHitbox();

								// i want to kill myself
								susNote.strumTime += ((susNote.height * i) / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed));

								// susNote.strumTime += ((daNote.y + (susNote.height * i)));
								susNote.x += 64;
								susNote.parent = daNote;
								// notSpawnNotes.push(susNote);

								if (susNote.strumTime >= Math.floor(daNote.strumTime + susLenght))
								{
									susNote.isTail = true;
									break;
								}
							}
						}
						notSpawnNotes.push(daNote);
					}
					else if (!Option.middleScroll)
					{
						var daNote:Note = new Note(cpuStrums.members[Std.int(noteData)].x, strumTime, noteData, "normal");

						daNote.scrollFactor.set();

						daNote.mustPress = false;

						if (susLenght != 0 && susLenght > 10)
						{
							for (i in 0...Math.floor(susLenght))
							{
								var susNote:Note = new Note(cpuStrums.members[noteData].x, strumTime, noteData, "normal", false, true, false, false);

								susNote.mustPress = false;

								susNote.scrollFactor.set();

								susNote.height = Conductor.steps;
								susNote.updateHitbox();

								// i want to kill myself
								susNote.strumTime += ((daNote.y + (susNote.height / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed))) * i);
								susNote.x += 64;
								susNote.parent = daNote;
								// notSpawnNotes.push(susNote);

								if (susNote.strumTime >= Math.floor(daNote.strumTime + susLenght))
								{
									susNote.isTail = true;
									break;
								}
							}
						}
						notSpawnNotes.push(daNote);
					}
				}
			}

			Conductor.songPosition = -1000;
			// Conductor.songPosition -= Conductor.crochet * 30;
		}

		//  CHART LOL
		/*	generateArrow(0, 1000);
			generateArrow(1, 1050);
			generateArrow(2, 1100);
			generateArrow(3, 1150);
			generateArrow(2, 1200);
			generateArrow(3, 1250);
			generateArrow(0, 1800);
			generateArrow(2, 2000, 20); // nobody's dick length lol
			generateArrow(1, 2200, 0, true);
			generateArrow(2, 2400);
			generateArrow(3, 2600, 5);
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
			/////////////////////// */
	}

	function resyncSong()
	{
		FlxG.sound.music.time = Conductor.songPosition;
		// Conductor.songPosition = FlxG.sound.music.time;
	}

	var hitNote = [];

	// public static var daKeybinds = sys.io.File.getContent(Paths.getText('keybinds'));
	// public static var keyString:Array<String> = daKeybinds.split(" ");
	var canGainHealth:Bool = true;

	// YOU KNOW WHERE THIS IS FROM
	public function handInput(event:KeyboardEvent)
	{
		var key:Int = -1;

		var closestNotes:Array<Note> = [];

		if (FlxG.keys.pressed.ENTER) {}

		var syncKey:String = "A";

		try
		{
			var huh = FlxKey.toStringMap.get(event.keyCode);

			// P O G

			var keyTemp:Array<String> = ["D", "F", "J", "K"];

			for (i in 0...keyTemp.length)
			{
				if (Option.controls[i].toLowerCase() == huh.toLowerCase())
					key = i;
			}

			if (key != -1)
			{
				holdBool[key] = true;

				if (noteBool[key])
				{
					return;
				}
				else
				{
					noteBool[key] = true;
				}
			}
			else
				return;

			// FINALLY FIXED INPUT FOR NOW
			// still has weird input

			for (i in 0...noteBool.length)
			{
				var key:Int = 0;

				if (noteBool[i])
					key = i;
			}

			/*notes.forEachAlive(function(note:Note)
							{
								if (note.canBeHit && !note.isSus && !note.wasHit && noteBool[note.noteData] && note.mustPress)
								{
									closestNotes.push(note);
								}
							});

							closestNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

							/*if (closestNotes.length != 0)
							{
								var daNote = closestNotes[0];

								if (closestNotes.length > 2)
								{
									// for removing dupliacate notes
									/*for (duplicateNote in closestNotes)
										{
											if (duplicateNote != daNote)
											{
												if (duplicateNote.noteData == daNote.noteData)
												{
													if (duplicateNote.strumTime - daNote.strumTime < 10)
													{
														duplicateNote.kill();
														notes.remove(duplicateNote, true);
														duplicateNote.destroy();
													}
												}
											}
						}
					}
				}
			 */
		}
		catch (e)
		{
			#if debug
			trace(e);
			#end
		}
	}

	public function realeasedInput(event:KeyboardEvent)
	{
		var key:Int = -1;

		try
		{
			var wow = FlxKey.toStringMap.get(event.keyCode);

			var keyTemp:Array<String> = ["D", "F", "J", "K"];
			for (i in 0...keyTemp.length)
			{
				if (Option.controls[i].toLowerCase() == wow.toLowerCase())
					key = i;
			}

			if (key != -1)
			{
				keysR[key] = true;
				noteBool[key] = false;
				holdBool[key] = false;
			}
		}
		catch (e)
		{
			#if debug
			trace(e);
			#end
		}
	}

	public function addAccuracyText(text:String, diff:Float, rating:String)
	{
		var daDiff:Float = FlxMath.roundDecimal(diff, 2);

		remove(accuracyText);
		accuracyText = new FlxText(text + " " + Std.string(daDiff) + "ms", 50);
		accuracyText.screenCenter(XY);
		accuracyText.scrollFactor.set();

		switch (rating)
		{
			case "sick":
				accuracyText.color = FlxColor.YELLOW;
			case "good":
				accuracyText.color = FlxColor.GREEN;
			case "bad":
				accuracyText.color = FlxColor.RED;
			case null:
				accuracyText.color = FlxColor.GRAY;
		}

		add(accuracyText);
	}

	public var totalHitSec:Float = 0;
	public var hitSecArray = [];

	var keysP = [false, false, false, false];
	var keys = [false, false, false, false];
	var keysR = [false, false, false, false];

	function keyCheck()
	{
		var keysTime = [0, 0, 0, 0];
	}

	public function goodNoteHit(note:Note)
	{
		totalHitSec++;
		totalPlayed++;

		// FlxG.sound.play("assets/sounds/CLAP.ogg");

		rating = "";
		var diff = Math.abs(Conductor.songPosition - note.strumTime);

		var moyenneList = [];

		var sickFloat = 52;
		var goodFloat = 104;
		var badFloat = 104;

		moyenneList.push(diff);

		// judge
		if (diff >= 0 && diff <= sickFloat)
			rating = "sick";
		if (diff >= sickFloat && diff <= goodFloat)
			rating = "good";
		if (diff >= goodFloat && diff <= badFloat)
			rating = "bad";

		if (!note.isSus)
		{
			note.wasHit = true;
			note.kill();
			notes.remove(note, true);
			note.destroy();
		}

		var daAnim = ['left', 'down', 'up', 'right'];

		receptors.members[note.noteData].animation.play('confirm');
		// bf.animation.play(daAnim[note.noteData]);

		switch (rating)
		{
			case "sick":
				{
					addAccuracyText("NICKEL", diff, rating);
					if (canGainHealth)
						health += 3.5;
					totalHit += 1;
				}
			case "good":
				{
					addAccuracyText("WESH ????", diff, rating);
					if (canGainHealth)
						health += 2.5;
					totalHit += 0.75;
				}
			case "bad":
				{
					addAccuracyText("DRERE", diff, rating);
					health -= 5;
					totalHit += 0.50;
				}
		}

		updateAcc();
	}

	function getMoyenne(array:Array<Float>):Float
	{
		var moyenne:Float = 0;

		for (i in 0...array.length)
		{
			moyenne += array[i];
		}

		return moyenne;
	}

	public function noteMiss(daNote:Note)
	{
		// totalPlayed++;
		// daNote.tooLate = true;

		if (Option.missSound)
			FlxG.sound.play("assets/sounds/missnote1.ogg", 0.5);

		if (daNote != null)
		{
			health -= 5;
			daNote.kill();
			notes.remove(daNote, true);
			daNote.destroy();
		}
		else
			health -= 1;

		if (songName == "gunpowder")
			damage += 2 * FlxG.elapsed;

		misses++;
		updateAcc();
	}

	public function updateAcc()
	{
		remove(infoText);

		if (accuracy > 100)
			accuracy = 100;

		if (accuracy < 0)
			accuracy = 0;

		totalPlayed += 1;

		// incroyable produit en croix
		accuracy = Math.max(0, totalHit / totalPlayed * 100);

		infoText = new FlxText(0, 0, 0, "Combo Cassé: " + misses + " | Accuracy(beugé): " + Std.string(FlxMath.roundDecimal(accuracy, 2)) + "%", 26);

		infoText.y = FlxG.height - 50;
		infoText.x = (FlxG.width / 2) - 250;
		infoText.font = Paths.getFonts("funkin");
		infoText.scrollFactor.set();
		add(infoText);
	}

	var holding:Bool = false;
	var garbage = [];

	public function keyShit()
	{
		var controlsP = [
			controls.LEFT_P.check(),
			controls.DOWN_P.check(),
			controls.UP_P.check(),
			controls.RIGHT_P.check()
		];

		var controlsH = [
			controls.LEFT.check(),
			controls.DOWN.check(),
			controls.UP.check(),
			controls.RIGHT.check()
		];

		// simple hold note shit
		for (note in notes)
		{
			var receptor = receptors.members[note.noteData];

			// M A T H
			if (controlsH[note.noteData]
				&& note.isSus
				&& note.strumTime <= Conductor.songPosition + (receptor.height / 2) +
					(receptor.height / 4) / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed)
					&& !note.wasHit
					&& note.mustPress)
			{
				health += 0.15;
				totalHit += 0.25;
				totalPlayed += 0.25;

				if (receptor.animation.curAnim.finished)
					receptor.animation.play("confirm", true);

				var data = ['left', 'down', 'up', 'right'];

				// if (bf.animation.curAnim.curFrame > (24 / 2))
				// bf.animation.play(data[note.noteData], true);

				note.kill();
				notes.remove(note, true);
				note.destroy();
			}
		}
		// well at least i tried

		// KADE ENGINE INPUT (for now)
		if (controlsP.contains(true))
		{
			/*possibleNotes = [];
				directionAccounted = [false, false, false, false];
				directionList = [];
				dumbNotes = []; */

			var possibleNotes:Array<Note> = [];
			var directionAccounted:Array<Bool> = [false, false, false, false];
			var directionList:Array<Int> = [];
			var dumbNotes:Array<Note> = [];

			notes.forEachAlive(function(daNote:Note)
			{
				// check if note can be possible to hit
				if (daNote.canBeHit && !daNote.isSus && daNote.mustPress && !daNote.wasHit && !directionAccounted[daNote.noteData])
				{
					// check if we already got this noteData before
					if (directionList.contains(daNote.noteData))
					{
						directionAccounted[daNote.noteData] = true;

						for (coolNote in possibleNotes)
						{
							// check if daNote is duplicate (doesnt work somehow ?)
							if (coolNote.noteData == daNote.noteData && Math.abs(daNote.strumTime - coolNote.strumTime) < 10)
							{
								dumbNotes.push(daNote);
								break;
							} // else check if daNote is closer than coolNote to be hit
							else if (coolNote.noteData == daNote.noteData && daNote.strumTime < coolNote.strumTime)
							{
								possibleNotes.remove(coolNote);
								possibleNotes.push(daNote);
								break;
							}
						}
					}
					else // else we consider this note to be possible to hit
					{
						directionAccounted[daNote.noteData] = true;
						possibleNotes.push(daNote);
						directionList.push(daNote.noteData);
					}
				}
			});
			// i think i kinda understand how it work ? (hopefully?)

			#if debug
			FlxG.watch.addQuick("possibleNotes", possibleNotes.length);
			FlxG.watch.addQuick("directionList", directionList);
			FlxG.watch.addQuick("directionAccounted", directionAccounted);
			#end

			for (note in dumbNotes)
			{
				note.kill();
				notes.remove(note, true);
				note.destroy();
			}

			if (!Option.ghostTapping || songName == "disruption")
			{
				for (i in 0...4)
				{
					if (controlsP[i] && !directionAccounted[i])
					{
						noteMiss(null);
					}
				}
			}

			possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

			var hits:Array<Bool> = [false, false, false, false];

			if (possibleNotes.length > 0)
			{
				for (daNote in possibleNotes)
				{
					if (controlsP[daNote.noteData] && !hits[daNote.noteData])
					{
						goodNoteHit(daNote);
					}
				}
			}
		}
	}

	var syncTimer:Float = 0;
	var songTime:Float = 0;
	var isDead:Bool = false;

	// public static var effectNote:Note = null;
	// public static var shitTrails:FlxTrail = new FlxTrail(effectNote, null, 2, 2, 0.2, 0.069);
	var daGarbage:Array<Note> = [];
	var debug:Bool = false;

	// var beatHit:Bool = false;
	var damage:Float = 0;

	override public function beatHit(curBeat:Int)
	{
		// trace("zebi");
		// events shit
		if (songName == "thorns b-sides")
		{
			if (curBeat > 256 && curBeat < 292)
			{
				if (curBeat % 2 == 0 && FlxG.camera.zoom < FlxG.camera.initialZoom + 0.2)
				{
					FlxG.camera.zoom += 0.5;
				}
			}
			else
			{
				if (curBeat % 4 == 0 && FlxG.camera.zoom < FlxG.camera.initialZoom + 0.2)
				{
					FlxG.camera.zoom += 0.5;
				}
			}
		}

		if (FlxG.camera.zoom < FlxG.camera.initialZoom + 0.2)
		{
			FlxG.camera.zoom += 0.5;
		}
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.pressed.NUMPADFIVE)
			camFollow.x += 10;

		if (!isDead)
			Conductor.songPosition += FlxG.elapsed * 1000;

		songTime = FlxG.sound.music.time;

		if (Conductor.songPosition >= 0)
		{
			FlxG.sound.music.volume = 1;
			songStarted = true;
		}

		#if debug
		debug = true;
		#end

		if (!debug)
			if (health == 0)
			{
				FlxG.camera.flash(FlxColor.RED, 3);
				FlxG.camera.fade(FlxColor.BLACK, 2, false, endSong);
				isDead = true;
				FlxG.sound.music.stop();
			}

		for (i in daGarbage)
			notes.remove(i);

		// curStep = Conductor.songPosition / Conductor.steps;
		// curBeat = Conductor.songPosition / Conductor.crochet;

		#if debug
		FlxG.watch.addQuick("curNotes", notes.members.length);
		FlxG.watch.addQuick("songPosition", Conductor.songPosition);
		FlxG.watch.addQuick("songTime", FlxG.sound.music.time);
		FlxG.watch.addQuick("curBeat", curBeat);
		FlxG.watch.addQuick("steps", Conductor.songPosition / Conductor.steps);
		FlxG.watch.addQuick("crochetDecimal", Math.floor(curBeat));
		FlxG.watch.addQuick("C_crochet", Conductor.crochet);
		FlxG.watch.addQuick("C_step", Conductor.steps);
		#end

		keyShit();

		FlxG.camera.zoom = FlxMath.lerp(1, FlxG.camera.zoom, 0.75);

		FlxG.watch.addQuick("curZoom", FlxG.camera.zoom);

		// event shit
		if (songName == "expurgation" && curBeat > 0 && curBeat < 720)
		{
			health -= 0.45 / (FlxG.elapsed * 1000);

			if (curBeat > 664)
				canGainHealth = false;
		}
		else
			canGainHealth = true;

		if (FlxG.keys.justPressed.ONE)
		{
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handInput);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, realeasedInput);
			FlxG.resetState();
		}

		if (songName == "gunpowder")
		{
			health -= damage;
		}

		// spawn notes to their strumTime instead of loading all of them at the start of the song and getting laggy gameplay
		// sorry for the english im french
		var toRemove = [];

		if (notSpawnNotes.length != 0)
		{
			if (notSpawnNotes[0].strumTime - Conductor.songPosition < 14000)
			{
				var dunceNote:Note = notSpawnNotes[0];
				notes.add(dunceNote);

				notSpawnNotes.remove(dunceNote);
			}
		}
		// should not be laggy now (technically)

		// ninjamuffin99 is da best programmer
		// also kade is pogk
		notes.forEachAlive(function(note:Note)
		{
			var receptor = receptors.members[note.noteData];

			// moving da note
			note.y = (receptor.y
				- (Conductor.songPosition - note.strumTime) * (0.45 * FlxMath.roundDecimal(Option.scrollSpeed == 1 ? PlayState.speed : Option.scrollSpeed, 2)))
				+ Conductor.offsets
				+ Option.offset;

			if (note.strumTime < Conductor.songPosition
				&& !note.isSus
				&& !note.wasHit
				&& !note.canBeHit
				&& !note.danger
				&& note.mustPress)
			{
				// trace("calling that shit")
				noteMiss(note);
				// updateAcc();
			}

			if (note.isSus)
			{
				if (note.strumTime < Conductor.songPosition
					+ (note.height / 2)
					+ (receptor.height / 4) / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed) && !note.mustPress)
				{
					cpuReceptors.members[note.noteData].animation.play("confirm");
					cpuReceptors.members[note.noteData].offset.set(25, 25);

					note.kill();
					notes.remove(note, true);
					note.destroy();
				}
			}
			else
			{
				if (note.strumTime < Conductor.songPosition && !note.mustPress)
				{
					if (songName == "sporting voiid" && health > 5)
					{
						health -= 2;
					}

					if (songName == "disruption")
					{
						FlxG.camera.shake(0.03, 0.1);

						if (health > 50)
							health -= 1;
						else if (health > 25)
							health -= 0.8;
						else
							health -= 0.1;
					}

					// if (cpuReceptors.members[note.noteData] != null)

					cpuReceptors.members[note.noteData].animation.play("confirm");
					cpuReceptors.members[note.noteData].offset.set(25, 25);

					note.kill();
					notes.remove(note, true);
					note.destroy();

					// updateAcc();
				}
			}

			if (note.y < FlxG.height)
			{
				note.active = true;
				note.visible = true;
			}
			else
			{
				note.active = false;
				note.visible = false;
			}
		});

		#if debug
		FlxG.watch.addQuick("time", FlxG.sound.music.length);
		#end

		if (Conductor.songPosition > FlxG.sound.music.length)
		{
			if (Conductor.songPosition > FlxG.sound.music.length + 5000) // 5000 = 5s
			{
				trace("ending da song");
				endSong();
			}
		}

		if (FlxG.keys.justPressed.NUMPADTWO)
			Conductor.songPosition += 5000;

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handInput);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, realeasedInput);
			if (FlxG.sound.music != null)
				FlxG.sound.music.stop();
			FlxG.switchState(new Menu());
		}

		if (FlxG.sound.music.time > Conductor.songPosition + 200 || FlxG.sound.music.time < Conductor.songPosition - 200)
		{
			#if debug
			trace("syncing...");
			#end

			if (Option.canSync)
				resyncSong();
		}

		lifeBar.percent = health;

		if (health > 100)
			health = 100;
		if (health < 0)
			health = 0;

		// offsets for receptors animation
		for (i in 0...4)
		{
			var controlsH = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
			var controlsP = [controls.LEFT_P, controls.DOWN_P, controls.UP_P, controls.RIGHT_P];
			var controlsR = [controls.LEFT_R, controls.DOWN_R, controls.UP_R, controls.RIGHT_R];

			if (controlsP[i].check() && receptors.members[i].animation.curAnim.name != "confirm")
			{
				receptors.members[i].animation.play("pressed");
			}

			if (controlsR[i].check())
			{
				receptors.members[i].animation.play("static");
			}

			if (receptors.members[i].animation.curAnim.name == 'confirm')
				receptors.members[i].offset.set(25, 25);
			else if (receptors.members[i].animation.curAnim.name == 'pressed')
				receptors.members[i].offset.set(-2, -2);
			else
				receptors.members[i].offset.set();
		}

		if (FlxG.keys.justPressed.SEVEN)
		{
			if (FlxG.sound.music != null)
				FlxG.sound.music.stop();

			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handInput);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, realeasedInput);
			FlxG.switchState(new ChartEditor());
		}

		for (receptor in cpuReceptors)
		{
			if (receptor.animation.curAnim.name == "confirm" && receptor.animation.finished)
			{
				receptor.animation.play("static");
				receptor.offset.set();
			}
		}

		// camFollow.setPosition(bf.getMidpoint().x - 150, bf.getMidpoint().y - 150);

		// if (songStarted)
		// modChartUpdate(elapsed);

		super.update(elapsed);
	}

	function modChartUpdate(elapsed:Float)
	{
		if (isSM && !Option.middleScroll)
			for (i in 0...receptors.length)
			{
				// FlxTween.tween(receptors.members[i], {x}, 0.5 * i, {ease: FlxEase.quadInOut});
			}
	}

	function endSong()
	{
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handInput);
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, realeasedInput);
		FlxG.switchState(new Menu());
	}
}
