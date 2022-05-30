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
import openfl.utils.Assets;
import smShit.TimingStruct;

using StringTools;

#if cpp
import lime.media.AudioContext;
import lime.media.AudioManager;
#end
#if sys
import sys.FileSystem;
#end

class PlayState extends MusicBeatState
{
	static public var fromChart:Bool = false;

	static public var instance:PlayState = null;
	// scroll speeed
	static public var speed:Float = 2.5;

	var edition:String = "DEV-BUILD";

	static public var songName:String;

	var botText:FlxText;

	public static var lifeBar:FlxBar;
	public static var health:Float = 100;

	var songPositionBar:FlxBar;

	static public var rating:String;

	public var noteBool = [false, false, false, false];
	public var holdBool = [false, false, false, false];

	var holdTimer:Float = 0.0;

	var accuracyText:FlxText;
	var accuracyText2:FlxText;

	var staticArrow:FlxSprite;
	var strumLine:FlxSprite;
	var playerStrums:FlxTypedGroup<FlxSprite>;
	var cpuStrums:FlxTypedGroup<FlxSprite>;

	public static var notes:FlxTypedGroup<Note>;

	public static var receptors:FlxTypedGroup<FlxSprite>;
	public static var cpuReceptors:FlxTypedGroup<FlxSprite>;

	public var daSong:FlxSound;

	public static var infoText:FlxText;

	var watermark:FlxText;
	var debugInfos:FlxText;
	var challangeDetails:FlxText;

	var accuracy:Float = 100.000;
	var totalHit:Float;
	var totalPlayed:Float;

	public var sick:Int;
	public var good:Int;
	public var bad:Int;

	var misses:Int;

	public static var score:Float = 0;

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

	public static var bf:Character;
	public static var dad:Character;

	var isSM:Bool = false;

	var currentSection:SwagSection;

	function generateStaticArrow(player:Int = 0, noteSkin:String = "og")
	{
		if (player == 0)
		{
			var dataPos = ["LEFT", "DOWN", "UP", "RIGHT"];
			var dataPos2 = ["left", "down", "up", "right"];

			for (i in 0...4)
			{
				strumLine = new FlxSprite();
				staticArrow = new FlxSprite();

				staticArrow.scrollFactor.set();

				staticArrow.frames = Paths.getSparrowAtlas("NoteType/og/Arrows");

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

				staticArrow.frames = Paths.getSparrowAtlas("NoteType/og/Arrows");

				staticArrow.animation.addByPrefix('static', "arrow" + dataPos[i], 24, false);
				staticArrow.animation.addByPrefix('pressed', dataPos2[i] + " press", 24, false);
				staticArrow.animation.addByPrefix('confirm', dataPos2[i] + " confirm", 24, false);
				staticArrow.animation.play('static');

				staticArrow.setGraphicSize(Std.int(staticArrow.width * 0.7));
				staticArrow.antialiasing = true;
				// staticArrow.y = (FlxG.height / 2) - (staticArrow.height / 2);
				staticArrow.y = 30;
				staticArrow.x = (FlxG.width / 2); // 270 midllescroll
				staticArrow.x += ((staticArrow.width - 40) * i);
				staticArrow.centerOffsets();

				strumLine.x = (staticArrow.x + staticArrow.width / 2);
				strumLine.y = (staticArrow.y + staticArrow.height / 2);
				strumLine.alpha = 1;
				strumLine.scrollFactor.set();
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

				staticArrow.frames = Paths.getSparrowAtlas("NoteType/og/Arrows");

				staticArrow.animation.addByPrefix('static', "arrow" + dataPos[i], 24, false);
				staticArrow.animation.addByPrefix('pressed', dataPos2[i] + " press", 24, false);
				staticArrow.animation.addByPrefix('confirm', dataPos2[i] + " confirm", 24, false);
				staticArrow.animation.play('static');

				staticArrow.setGraphicSize(Std.int(staticArrow.width * 0.7));
				staticArrow.antialiasing = true;
				staticArrow.y = 30;
				staticArrow.x = (FlxG.width / 2) - 650; // 270 midllescroll
				staticArrow.x += ((staticArrow.width - 40) * i);
				staticArrow.centerOffsets();

				strumLine.x = (staticArrow.x + staticArrow.width / 2);
				strumLine.y = (staticArrow.y + staticArrow.height / 2);
				strumLine.alpha = 0;
				strumLine.scrollFactor.set();
				cpuReceptors.add(staticArrow);
				cpuStrums.add(strumLine);
			}
		}
	}

	var startTime:Float = Conductor.crochet * 5;

	var controls2:Control;

	override public function create()
	{
		misses = 0;

		actionManager = new FlxActionManager();
		controls = new Control();
		actionManager.addActions([controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT]);

		if (Option.twoPlayer)
		{
			controls2 = new Control(2);
			actionManager.addActions([controls2.LEFT, controls2.DOWN, controls.UP, controls2.RIGHT]);
		}

		FlxG.inputs.add(actionManager);

		songName = Option.songName;

		// camGame = new FlxCamera()

		// FlxG.cameras.reset()

		camFollow = new FlxObject();
		camFollow.visible = false;
		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.02 / (openfl.Lib.current.stage.frameRate / 60));

		if (!Option.optimisation)
		{
			shitBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
			add(shitBG);

			bf = new Character();
			bf.x = (FlxG.width / 2) + 100 - (bf.width / 2);
			add(bf);

			dad = new Character();
			dad.x = bf.x - 650;
			dad.flipX = true;
			add(dad);
		}

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
		lifeBar.percent = 50;
		lifeBar.numDivisions = 1000;
		lifeBar.scrollFactor.set();
		add(lifeBar);

		if (Option.botPlay)
		{
			botText = new FlxText("BOTPLAY", 26);
			botText.x = lifeBar.x + ((lifeBar.width / 2) - (botText.width / 2));
			botText.y = lifeBar.y - 25;
			botText.scrollFactor.set();
			add(botText);
		}

		songPositionBar = new FlxBar(FlxG.width / 2, 10, LEFT_TO_RIGHT, Std.int(FlxG.width / 2), 20, null, null, 0, 100, true);
		songPositionBar.x -= (songPositionBar.width / 2);
		songPositionBar.createColoredEmptyBar(FlxColor.RED, false);
		songPositionBar.createColoredFilledBar(FlxColor.GREEN, false);
		songPositionBar.scrollFactor.set();
		add(songPositionBar);

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

		// FlxG.sound.playMusic(Paths.getMusic('$songName.ogg'), 1, false);

		generateSong(songName);

		// just in case
		// Conductor.songPosition = 0;

		infoText = new FlxText(0, 0, 0, "Combo Break: 0 / " + " Accuracy: " + Std.string(100), 16);
		infoText.y = FlxG.height - 50;
		infoText.x = (FlxG.width / 2) - 250;
		infoText.scrollFactor.set();
		add(infoText);

		watermark = new FlxText(0, FlxG.height, 0,
			"KHEX ENGINE | "
			+ edition
			+ " | v1.5.6 | "
			+ songName
			+ " | INPUT : "
			+ (Option.input == 0 ? "FUNKIN" : (Option.input == 1 ? "KADE" : "PSYCH")),
			26);
		watermark.font = Paths.getFonts("funkin");
		watermark.y -= 30;
		watermark.scrollFactor.set();
		add(watermark);

		add(accuracyText);
		add(accuracyText2);

		if (songName == "disruption")
		{
			var noGhost:FlxText = new FlxText(0, FlxG.height - 150, 0, "GHOST TAPPING FORCED OFF FUCK YOU", 28);
			noGhost.font = Paths.getFonts("funkin");
			noGhost.scrollFactor.set();
			add(noGhost);

			challangeDetails = new FlxText(FlxG.width, FlxG.height - 100, "", 26);
			challangeDetails.text = "CHALLENGE | GET UNDER 120 misses";
			challangeDetails.x -= challangeDetails.width;
			challangeDetails.scrollFactor.set();
			challangeDetails.color = FlxColor.RED;
			challangeDetails.font = Paths.getFonts("funkin");
			add(challangeDetails);
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

	static public var SONG:SwagSong;

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
		}

		#if !sys
		type = 0;
		#else
		if (Assets.exists('assets/data/charts/$songName.sm'))
		{
			type = 2;
			isSM = true;
		}
		else if (Assets.exists("assets/data/charts/" + songName + ".json"))
		{
			type = 0;
		}
		#end

		if (type == 0)
		{
			if (fromChart)
			{
				fromChart = false;
				SONG = ChartEditor.SONG;
			}
			else
			{
				SONG = ChartReader.readJson(songName);
			}

			speed = SONG.speed / Option.multiplier;

			for (section in SONG.notes)
			{
				Conductor.changeBPM(section.bpm);

				for (dataNotes in section.sectionNotes)
				{
					#if debug
					// trace(dataNotes);
					#end

					if (dataNotes[1] == -1)
						continue;
					if (dataNotes[2] is String)
						continue;

					var danger:Bool = false;

					if (dataNotes[1] > 7)
					{
						trace("found mine ?" + dataNotes[1] % 4);
						danger = true;
					}

					var gottaHit:Bool = false;

					var strumTime:Float = dataNotes[0];
					var noteData:Int = Std.int(dataNotes[1] % 4);
					var susLenght:Float = dataNotes[2];

					if (susLenght > 0)
					{
						trace("susLength normally -> " + susLenght);
						trace("susLength should reformat to -> " + (susLenght / (Conductor.crochet / 2)));
					}

					if (Option.opponent)
					{
						// da code
						if (section.mustHitSection)
						{
							if (dataNotes[1] > 3)
							{
								gottaHit = true;
							}
						}
						if (!section.mustHitSection)
						{
							if (dataNotes[1] < 4)
							{
								gottaHit = true;
							}
						}
					}
					else
					{
						if (section.mustHitSection)
						{
							if (dataNotes[1] < 4)
							{
								gottaHit = true;
							}
						}
						if (!section.mustHitSection)
						{
							if (dataNotes[1] > 3)
							{
								gottaHit = true;
							}
						}
					}

					if (gottaHit)
					{
						var oldNote:Note;

						if (notSpawnNotes.length > 0)
						{
							oldNote = notSpawnNotes[Std.int(notSpawnNotes.length - 1)];
						}
						else
						{
							oldNote = null;
						}

						var daNote:Note = new Note(playerStrums.members[Std.int(noteData)].x, strumTime, noteData, (danger ? "danger" : "normal"));
						// daNote.prevNote = oldNote;
						daNote.setGraphicSize(Std.int(daNote.width * 0.7));
						daNote.scrollFactor.set();
						daNote.mustPress = true;
						notSpawnNotes.push(daNote);
						daNote.prevNote = oldNote;

						// for (i in 0...Std.int(susLenght))*
						for (i in 0...Std.int(Math.floor(susLenght / (Conductor.crochet / 8))))
						{
							trace(susLenght / (Conductor.crochet / 8));

							var stepHeight:Float = ((0.45 * (Conductor.crochet / 4)) * (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed));

							// var stepHeight:Float
							// var susNote:Note = new Note(playerStrums.members[noteData].x, strumTime + ((Conductor.crochet / 4) * i) + (Conductor.crochet / 4),
							var susNote:Note = new Note(playerStrums.members[noteData].x, strumTime + ((Conductor.crochet / 8) * i) + (Conductor.crochet / 4),
								noteData, "normal", false, true, false, false);
							// trace("step height is : " + stepHeight);
							// trace("scale is : " + susNote.height / stepHeight);
							// trace("scale note" + susNote.scale.y);

							trace(stepHeight);

							// susNote.scale.y = ((susLenght / (Conductor.crochet / 4))) * (0.45 * (Option.multiplier == 1 ? speed : Option.multiplier)) / 100;
							susNote.scale.y *= (susLenght / stepHeight);
							// susNote.scale.y = 5 / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed);
							susNote.updateHitbox();

							// trace("sus scale y: " + susNote.scale.y);

							susNote.y += susNote.height + i;

							susNote.scrollFactor.set();
							susNote.mustPress = true;

							susNote.x += 64; // 64
							susNote.parent = daNote;
							notSpawnNotes.push(susNote);

							if (susNote.strumTime >= Math.floor(daNote.strumTime + susLenght))
							{
								susNote.isTail = true;
								// break;
							}
						}
					}
					else if (!Option.middleScroll)
					{
						var daNote:Note = new Note(cpuStrums.members[Std.int(noteData)].x, strumTime, noteData, "normal");
						daNote.scrollFactor.set();
						daNote.mustPress = false;
						daNote.setGraphicSize(Std.int(daNote.width * 0.7));

						for (i in 0...Math.floor(susLenght))
						{
							var susNote:Note = new Note(cpuStrums.members[noteData].x, strumTime, noteData, "normal", false, true, false, false);

							susNote.mustPress = false;

							susNote.scrollFactor.set();
							susNote.scale.y = 5 / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed);
							susNote.updateHitbox();

							susNote.strumTime += susNote.height * i;
							susNote.x += 64;
							susNote.parent = daNote;
							notSpawnNotes.push(susNote);

							if (susNote.strumTime >= Math.floor(daNote.strumTime + susLenght))
							{
								susNote.isTail = true;
								break;
							}
						}

						notSpawnNotes.push(daNote);
						// trace("adding sus");
					}
				}
			}
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
				// trace(section.bpm);
				// Conductor.changeBPM(0);

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
						daNote.setGraphicSize(Std.int(daNote.width * 0.7));

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
								// susNote.strumTime += ((susNote.height * i) / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed));

								susNote.strumTime += ((daNote.y + (susNote.height * i)));
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
						daNote.setGraphicSize(Std.int(daNote.width * 0.7));
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
								susNote.x += 80;
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
		}

		trace("setting start position");
		// Conductor.songPosition = -startTime;
		Conductor.songPosition = 0;
		if (!isSM)
			Conductor.songPosition -= (Conductor.crochet * 5) * Option.multiplier;

		//  CHART LOL
		/*	generateArrow(0, 1000);
			generateArrow(1, 1050);
			generateArrow(2, 1100);
			generateArrow(3, 1150);
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

		@:privateAccess
		{
			try
			{
				trace("we good to update PITCH");
				if (lime.media.openal.AL.PITCH != Option.multiplier)
				{
					trace("matching PITCH" + lime.media.openal.AL.PITCH + " = " + Option.multiplier);
					lime.media.openal.AL.sourcef(FlxG.sound.music._channel.__source.__backend.handle, lime.media.openal.AL.PITCH, Option.multiplier);
				}
			}
			catch (e)
			{
				trace("we not good");
				trace(e);
			}
		}
	}

	public static var canGainHealth:Bool = true;

	// YOU KNOW WHERE THIS IS FROM
	public function handInput(event:KeyboardEvent)
	{
		var key:Int = -1;

		var closestNotes:Array<Note> = [];

		var syncKey:String = "A";

		trace(event.keyCode);

		if (Option.input == 2)
		{
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

				notes.forEachAlive(function(note:Note)
				{
					if (note.canBeHit && !note.isSus && !note.wasHit && noteBool[note.noteData] && note.mustPress)
					{
						closestNotes.push(note);
					}
				});

				closestNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

				if (closestNotes.length > 0)
				{
					var daNote = closestNotes[0];

					if (closestNotes.length > 1)
					{
						// for removing dupliacate notes
						for (duplicateNote in closestNotes)
						{
							if (duplicateNote != daNote)
							{
								if (Math.abs(duplicateNote.strumTime - daNote.strumTime) < 10 && daNote.noteData == duplicateNote.noteData)
								{
									duplicateNote.kill();
									notes.remove(duplicateNote, true);
									duplicateNote.destroy();
								}
							}
						}
					}

					if (noteBool[daNote.noteData])
					{
						goodNoteHit(daNote);
					}
				}
			}
			catch (e)
			{
				#if PRECISE_DEBUG
				trace(e);
				#end
			}
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
			#if PRECISE_DEBUG
			trace(e);
			#end
		}
	}

	public var combo:Int = 0;

	public function addAccuracyText(text:String, diff:Float, rating:String, player:Int = 1)
	{
		var daDiff:Float = FlxMath.roundDecimal(diff, 2);

		combo++;

		if (player == 2)
		{
			remove(accuracyText2);

			accuracyText2 = new FlxText(text + " " + Std.string(daDiff) + "ms" + '\n$combo', 50);
			accuracyText2.screenCenter(XY);
			accuracyText2.scrollFactor.set();

			switch (rating)
			{
				case "sick":
					accuracyText2.color = FlxColor.YELLOW;
				case "good":
					accuracyText2.color = FlxColor.GREEN;
				case "bad":
					accuracyText2.color = FlxColor.RED;
				case null:
					accuracyText2.color = FlxColor.GRAY;
			}

			add(accuracyText2);
		}
		else
		{
			remove(accuracyText);

			accuracyText = new FlxText(text + " " + Std.string(daDiff) + "ms" + '\n$combo', 50);
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

	var daTween:FlxTween;

	public function goodNoteHit(note:Note, player:Int = 1)
	{
		// totalHitSec++;
		totalPlayed++;

		// FlxG.sound.play("assets/sounds/CLAP.ogg");

		if (!note.isSus)
		{
			note.wasHit = true;
			note.kill();
			notes.remove(note, true);
			note.destroy();
		}

		if (note.danger)
		{
			trace("well you ded");
			FlxG.sound.play("assets/sounds/burnSound.ogg");
			health -= 10;
		}
		else
		{
			rating = "";
			var diff = Math.abs(Conductor.songPosition - note.strumTime);

			var moyenneList = [];

			var sickFloat = 52; // 52
			var goodFloat = 80; // 104
			var badFloat = 104; // 104

			moyenneList.push(diff);

			// judge
			if (diff >= 0 && diff <= sickFloat)
				rating = "sick";
			if (diff >= sickFloat && diff <= goodFloat)
				rating = "good";
			if (diff >= goodFloat && diff <= badFloat)
				rating = "bad";

			var daAnim = ['left', 'down', 'up', 'right'];

			if (player == 2)
			{
				cpuReceptors.members[note.noteData].animation.play('confirm');
			}
			else
			{
				receptors.members[note.noteData].animation.play('confirm');
			}

			if (!Option.optimisation)
			{
				if (bf.animation.curAnim.finished)
				{
					bf.animation.curAnim.finish();
				}

				bf.animation.play(daAnim[note.noteData]);
			}

			var maxScore:Float = 100;

			switch (rating)
			{
				case "sick":
					{
						addAccuracyText("NICKEL", diff, rating, player);
						if (player == 1)
						{
							if (canGainHealth)
								health += 3.5;
							totalHit += 1;
							score += maxScore;
						}
					}
				case "good":
					{
						addAccuracyText("WESH ????", diff, rating, player);
						if (player == 1)
						{
							if (canGainHealth)
								health += 2;
							totalHit += 0.75;
							score += (maxScore / 2);
						}
					}
				case "bad":
					{
						addAccuracyText("DRERE", diff, rating, player);
						if (player == 1)
						{
							health -= 5;
							totalHit += 0.50;
							score += (maxScore / 2) / 2;
						}
					}
			}

			if (player != 2)
			{
				FlxTween.tween(lifeBar, {percent: health}, 0.15, {ease: FlxEase.cubeOut});
				updateAcc();
			}
		}
	}

	public function noteMiss(daNote:Note)
	{
		totalPlayed++;
		// daNote.tooLate = true;

		if (Option.missSound)
			FlxG.sound.play("assets/sounds/missnote1.ogg", 0.5);

		if (daNote != null)
		{
			health -= 5;
			daNote.kill();
			notes.remove(daNote, true);
			daNote.destroy();

			if (!Option.optimisation)
			{
				var animArray = ['left', 'down', 'up', 'right'];
				bf.animation.play('miss_' + animArray[daNote.noteData]);
			}
		}
		else
		{
			health -= 5;
		}

		if (songName == "gunpowder")
			damage += 2;

		misses++;
		score -= 50;
		updateAcc();

		FlxTween.tween(lifeBar, {percent: health}, 0.15, {ease: FlxEase.cubeOut});
	}

	public function updateAcc()
	{
		remove(infoText);

		if (accuracy > 100)
			accuracy = 100;
		else if (accuracy < 0)
			accuracy = 0;

		// totalPlayed += 1;

		// incroyable produit en croix
		accuracy = Math.max(0, totalHit / totalPlayed * 100);

		infoText = new FlxText(0, 0, 0,
			"Combo Cassé: "
			+ misses
			+ " | Accuracy(beugé): "
			+ Std.string(FlxMath.roundDecimal(accuracy, 2))
			+ "% | Score: "
			+ Std.string(score), 26);

		infoText.y = FlxG.height - 50;
		infoText.x = (FlxG.width / 2) - 250;
		infoText.font = Paths.getFonts("funkin");
		infoText.scrollFactor.set();
		add(infoText);
	}

	var holding:Bool = false;
	var garbage = [];

	inline function keyShit()
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

		/*var controlsP2 = [
				controls2.LEFT_P.check(),
				controls2.DOWN_P.check(),
				controls2.UP_P.check(),
				controls2.RIGHT_P.check()
			];

			var controlsH2 = [
				controls2.LEFT.check(),
				controls2.DOWN.check(),
				controls2.UP.check(),
				controls2.RIGHT.check()
			]; */

		// simple hold note shit
		for (note in notes)
		{
			var receptor = receptors.members[note.noteData];

			// M A T H
			if (controlsH[note.noteData]
				&& note.isSus
				&& note.strumTime <= Conductor.songPosition + (note.height / 2) + (receptor.height / 4) / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed)
					&& !note.wasHit
					&& note.mustPress)
			{
				health += 0.15;
				totalHit += 0.25;
				totalPlayed += 0.25;

				if (receptor.animation.curAnim.name == "confirm"
					&& receptor.animation.curAnim.curFrame > receptor.animation.curAnim.frames.length / 6)
					receptor.animation.play("confirm", true);

				if (!Option.optimisation)
				{
					var data = ['left', 'down', 'up', 'right'];

					if (!bf.animation.curAnim.finished)
					{
						bf.animation.stop();
					}

					bf.animation.play(data[note.noteData]);
				}

				note.kill();
				notes.remove(note, true);
				note.destroy();
			}
		}

		if (Inputs.dumbNotes.length > 0)
		{
			for (note in Inputs.dumbNotes)
			{
				note.kill();
				notes.remove(note, true);
				note.destroy();
			}
		}

		// well at least i tried

		if (Option.input == 1)
		{
			// KADE ENGINE INPUT (for now)

			if (controlsP.contains(true))
			{
				try
				{
					var possibleNotes:Array<Note> = Inputs.processInput(KADE, notes, controlsP);

					if (possibleNotes.length > 0)
					{
						for (note in possibleNotes)
						{
							if (controlsP[note.noteData] && Inputs.dataAccounted[note.noteData])
							{
								goodNoteHit(note);
							}
						}
					}
				}
				catch (e)
				{
					trace(e);
				}
			}

			/*if (controlsP2.contains(true))
				{
					var possibleNotes:Array<Note> = Inputs.processInput(KADE, notes, controlsP2, 2);

					if (possibleNotes.length > 0)
					{
						for (note in possibleNotes)
						{
							if (controlsP[note.noteData] && Inputs.dataAccounted[note.noteData])
							{
								goodNoteHit(note, 2);
							}
						}
					}
			}*/
		}
		else if (Option.input == 0)
		{
			// the good old input
			// maybe for challenges
			if (controlsP.contains(true))
			{
				try
				{
					var possibleNotes:Array<Note> = Inputs.processInput(FUNKIN, notes, controlsP);

					if (possibleNotes.length > 0)
					{
						for (note in possibleNotes)
						{
							if (controlsP[note.noteData])
							{
								goodNoteHit(note);
							}
						}
					}
				}
				catch (e)
				{
					trace(e);
				}

				/*var possibleNotes:Array<Note> = [];
					var dataAccounted:Array<Int> = [];

					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.canBeHit && !daNote.isSus && !daNote.wasHit && daNote.mustPress && !dataAccounted.contains(daNote.noteData))
						{
							possibleNotes.push(daNote);
							dataAccounted.push(daNote.noteData);
						}
					});

					possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

					if (possibleNotes.length > 0)
					{
						var daNote = possibleNotes[0];

						if (possibleNotes.length > 1)
						{
							for (afterNote in possibleNotes)
							{
								if (afterNote != daNote)
								{
									if (afterNote.noteData == daNote.noteData)
									{
										if (Math.abs(afterNote.strumTime - daNote.strumTime) < 10)
										{
											afterNote.kill();
											notes.remove(afterNote, true);
											afterNote.destroy();
											possibleNotes.remove(afterNote);
										}
									}
									else if (controlsP[afterNote.noteData])
									{
										if (dataAccounted.contains(afterNote.noteData))
										{
											goodNoteHit(afterNote);
										}
										else
										{
											noteMiss(null);
										}
									}
								}
							}
						}

						if (controlsP[daNote.noteData] && dataAccounted.contains(daNote.noteData))
						{
							goodNoteHit(daNote);
						}
						else
						{
							noteMiss(null);
						}
				}*/
			}

			/*if (controlsP2.contains(true))
				{
					try
					{
						var possibleNotes:Array<Note> = Inputs.processInput(FUNKIN, notes, controlsP2, 2);

						if (possibleNotes.length > 0)
						{
							for (note in possibleNotes)
							{
								if (controlsP[note.noteData])
								{
									goodNoteHit(note, 2);
								}
							}
						}
					}
					catch (e)
					{
						trace(e);
					}
			}*/
		}
	}

	var syncTimer:Float = 0;
	var songTime:Float = 0;
	var isDead:Bool = false;

	// public static var effectNote:Note = null;
	// public static var shitTrails:FlxTrail = new FlxTrail(effectNote, null, 2, 2, 0.2, 0.069);
	var debug:Bool = false;

	var _beatHit:Bool = false;
	var damage:Float = 0;

	override public function beatHit(curBeat:Int)
	{
		_beatHit = true;

		// trace("zebi");
		// events shit
		if (songName == "thorns b-sides")
		{
			if (curBeat > 256 && curBeat < 292)
			{
				if (curBeat % 2 == 0 && FlxG.camera.zoom < FlxG.camera.initialZoom + 0.1)
				{
					FlxG.camera.zoom += 0.3;
				}
			}
			else
			{
				if (curBeat % 4 == 0 && FlxG.camera.zoom < FlxG.camera.initialZoom + 0.05)
				{
					FlxG.camera.zoom += 0.1;
				}
			}
		}

		if (curBeat % 4 == 0)
		{
			FlxG.camera.zoom = 1.1;
		}

		if (!Option.optimisation)
		{
			if (curBeat % 2 == 0)
			{
				if (bf.animation.curAnim.finished)
				{
					bf.animation.play('idle');
				}

				if (dad.animation.curAnim.finished)
				{
					dad.animation.play('idle');
				}
			}
		}
	}

	var alreadyTweening:Bool = false;

	var canSync:Bool = false;

	override public function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
		{
			songPositionBar.percent = songPositionBar.max * FlxG.sound.music.time / FlxG.sound.music.endTime;
		}

		FlxG.watch.addQuick("song bar percent", songPositionBar.percent);

		if (_beatHit)
		{
			new FlxTimer().start(elapsed * 10, function(tmr:FlxTimer)
			{
				_beatHit = false;
			});
		}

		FlxG.watch.addQuick("beatHit ? ", _beatHit);

		if (!isDead)
		{
			Conductor.songPosition += (FlxG.elapsed * 1000) * Option.multiplier;

			if (Conductor.songPosition >= 0 && !songStarted)
			{
				trace("starting song from " + Conductor.songPosition);

				if (FlxG.sound.music == null)
				{
					FlxG.sound.playMusic(Paths.getMusic(songName) + ".ogg");
					resyncSong();
				}
				else
				{
					FlxG.sound.music.stop();
					FlxG.sound.playMusic(Paths.getMusic(songName) + ".ogg");
					resyncSong();
				}
				FlxG.sound.music.volume = 1;
				songStarted = true;
				canSync = true;
			}
		}

		if (songStarted)
		{
			if (FlxG.sound.music != null)
			{
				if (FlxG.sound.music.time > Conductor.songPosition + 200 || FlxG.sound.music.time < Conductor.songPosition - 200)
				{
					trace("syncing...");

					try
					{
						if (Option.canSync && songStarted && canSync)
						{
							trace("trying to resync");

							resyncSong();
						}
					}
					catch (e)
					{
						trace(e);
					};
				}
			}

			#if debug
			debug = true;
			#end

			if (!debug)
			{
				if (health == 0)
				{
					FlxG.camera.flash(FlxColor.RED, 3);
					FlxG.camera.fade(FlxColor.BLACK, 2, false, endSong);
					isDead = true;
					FlxG.sound.music.stop();

					if (FlxG.sound == null)
					{
						FlxG.sound.play("assets/sounds/death.ogg");
					}
				}
			}

			#if debug
			FlxG.watch.addQuick("curNotes", notes.members.length);
			FlxG.watch.addQuick("songPosition", Conductor.songPosition);
			if (FlxG.sound.music != null)
				FlxG.watch.addQuick("songTime", FlxG.sound.music.time);
			// FlxG.watch.addQuick("mustHit", SONG.notes[Std.int(curBeat / 2)].mustHitSection);
			FlxG.watch.addQuick("curBeat", curBeat);
			FlxG.watch.addQuick("C_crochet", Conductor.crochet);
			FlxG.watch.addQuick("C_step", Conductor.steps);
			#end
		}

		if (Option.botPlay)
		{
			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress && !daNote.danger)
				{
					if (daNote.strumTime <= Conductor.songPosition)
					{
						if (daNote.isSus)
						{
							daNote.kill();
							notes.remove(daNote, true);
							daNote.destroy();
						}
						else
						{
							goodNoteHit(daNote);
						}

						receptors.members[daNote.noteData].animation.play('confirm');
					}
				}
			});

			receptors.forEachAlive(function(receptor:FlxSprite)
			{
				if (receptor.animation.curAnim.name == "confirm" && receptor.animation.curAnim.finished)
				{
					receptor.animation.play('static');
				}
			});
		}
		else
		{
			keyShit();
		}

		if (FlxG.camera.zoom > 1 && !alreadyTweening)
		{
			alreadyTweening = true;
			FlxTween.tween(FlxG.camera, {zoom: 1}, 0.5, {
				ease: FlxEase.expoOut,
				onComplete: function(_)
				{
					alreadyTweening = false;
				}
			});
		}

		// FlxG.camera.zoom = FlxMath.lerp(1, FlxG.camera.zoom, 0.05 * (openfl.Lib.current.stage.frameRate / 66));

		FlxG.watch.addQuick("curZoom", FlxG.camera.zoom);

		// event shit
		if (songName == "expurgation" && curBeat > 0 && curBeat < 720)
		{
			if (curBeat > 664)
			{
				canGainHealth = false;
				health -= 8 * FlxG.elapsed;
				lifeBar.percent = health;
			}
			else
			{
				health -= 4 * FlxG.elapsed;
				lifeBar.percent = health;
			}
		}
		else
			canGainHealth = true;

		if (FlxG.keys.justPressed.ONE)
		{
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handInput);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, realeasedInput);
			FlxG.sound.music.stop();
			FlxG.resetState();
		}

		if (songName == "gunpowder")
		{
			health -= damage * FlxG.elapsed;
		}

		// spawn notes to their strumTime instead of loading all of them at the start of the song and getting laggy gameplay
		// sorry for the english im french
		if (notSpawnNotes.length != 0)
		{
			notSpawnNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

			if (notSpawnNotes[0].strumTime - Conductor.songPosition < 14000)
			{
				var dunceNote:Note = notSpawnNotes[0];
				notes.add(dunceNote);
				notSpawnNotes.remove(dunceNote);
			}
		}

		// should not be laggy now (technically)

		notes.forEachAlive(function(note:Note)
		{
			var receptor = receptors.members[note.noteData];
			var cpuReceptor = cpuReceptors.members[note.noteData];
			var stepHeight = (0.45 * Conductor.stepCrochet * FlxMath.roundDecimal((Option.scrollSpeed == 1 ? speed : Option.scrollSpeed), 2));

			// moving da note
			if (note.mustPress)
			{
				/*if (note.noteData == 0)
					{
						note.x = (receptors.members[note.noteData].x
							+
							(Conductor.songPosition - note.strumTime) * (0.45 * (FlxMath.roundDecimal(Option.scrollSpeed == 1 ? PlayState.speed : Option.scrollSpeed,
								2)))
							+ (Conductor.offsets + Option.offset));
					}
					else if (note.noteData == 3)
					{
						note.x = (receptors.members[note.noteData].x
							- (Conductor.songPosition - note.strumTime) * (0.45 * (FlxMath.roundDecimal(Option.scrollSpeed == 1 ? PlayState.speed : Option.scrollSpeed,
								2)))
							+ (Conductor.offsets + Option.offset));
					}
					else if (note.noteData == 2)
					{
						note.y = (receptors.members[note.noteData].y
							+
							(Conductor.songPosition - note.strumTime) * (0.45 * (FlxMath.roundDecimal(Option.scrollSpeed == 1 ? PlayState.speed : Option.scrollSpeed,
								2)))
							+ (Conductor.offsets + Option.offset));
					}
					else
					{
						note.y = (receptors.members[note.noteData].y
							- (Conductor.songPosition - note.strumTime) * (0.45 * (FlxMath.roundDecimal(Option.scrollSpeed == 1 ? PlayState.speed : Option.scrollSpeed,
								2)))
							+ (Conductor.offsets + Option.offset));
				}*/

				note.y = (receptors.members[note.noteData].y
					- (Conductor.songPosition - note.strumTime) * (0.45 * (FlxMath.roundDecimal(Option.scrollSpeed == 1 ? PlayState.speed : Option.scrollSpeed,
						2)))
					+ (Conductor.offsets + Option.offset));
			}
			else
			{
				note.y = (cpuReceptors.members[note.noteData].y
					- (Conductor.songPosition - note.strumTime) * (0.45 * FlxMath.roundDecimal(Option.scrollSpeed == 1 ? PlayState.speed : Option.scrollSpeed,
						2))
					+ (Conductor.offsets + Option.offset));
			}

			if (note.strumTime < Conductor.songPosition
				&& !note.isSus
				&& !note.wasHit
				&& !note.canBeHit
				&& !note.danger
				&& note.mustPress)
			{
				noteMiss(note);
			}

			if (note.isSus)
			{
				if (note.strumTime < Conductor.songPosition
					+ (note.height / 2)
					+ (cpuReceptor.height / 4) / (Option.scrollSpeed == 1 ? speed : Option.scrollSpeed) && !note.mustPress)
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
				if (note.strumTime < Conductor.songPosition && !note.mustPress && !Option.twoPlayer)
				{
					if ((songName == "sporting voiid" || songName == "burnout" || songName == "boxing match voiid") && health - 2 > 5)
					{
						health -= 2;
						FlxTween.tween(lifeBar, {percent: health}, 0.15, {ease: FlxEase.cubeOut});
					}

					if (songName == "disruption")
					{
						FlxG.camera.shake(0.01, 0.1);

						if (health > 50)
							health -= 2;
						else if (health > 25)
							health -= 1;
						else
							health -= 0.5;

						FlxTween.tween(lifeBar, {percent: health}, 0.15, {ease: FlxEase.cubeOut});
					}

					cpuReceptors.members[note.noteData].animation.play("confirm");
					cpuReceptors.members[note.noteData].offset.set(25, 25);

					var animList = ["left", "down", "up", "right"];

					if (!Option.optimisation)
					{
						dad.animation.play(animList[note.noteData]);
					}
					// trace(note.noteData);

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
		if (FlxG.sound.music != null)
			FlxG.watch.addQuick("end time", FlxG.sound.music.length);
		#end

		if (songStarted && canSync)
		{
			if (Conductor.songPosition > FlxG.sound.music.length)
			{
				if (Conductor.songPosition > FlxG.sound.music.length + 5000 && notSpawnNotes.length == 0) // 5000 = 5s
				{
					FlxG.sound.music.volume = 0;
					FlxG.sound.music.stop();

					trace("ending da song");
					endSong();
				}
			}
		}

		if (FlxG.keys.justPressed.NUMPADTWO)
			Conductor.songPosition += 5000;

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handInput);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, realeasedInput);

			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.stop();
			}

			FlxG.switchState(new Menu());
		}

		// lifeBar.percent = health;

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

			// var controlsP2 = [controls2.LEFT_P, controls2.DOWN_P, controls2.UP_P, controls2.RIGHT_P];
			// var controlsR2 = [controls2.LEFT_R, controls2.DOWN_R, controls2.UP_R, controls2.RIGHT_R];

			if (!Option.botPlay)
			{
				if (controlsP[i].check() && receptors.members[i].animation.curAnim.name != "confirm")
				{
					receptors.members[i].animation.play("pressed");
				}

				if (controlsR[i].check())
				{
					receptors.members[i].animation.play("static");
				}

				/*if (controlsP2[i].check() && receptors.members[i].animation.curAnim.name != "confirm")
					{
						cpuReceptors.members[i].animation.play("pressed");
					}

					if (controlsR2[i].check())
					{
						cpuReceptors.members[i].animation.play("static");
				}*/
			}

			if (Option.twoPlayer)
			{
				if (cpuReceptors.members[i].animation.curAnim.name == 'confirm')
				{
					cpuReceptors.members[i].offset.set(25, 25);
				}
				else if (cpuReceptors.members[i].animation.curAnim.name == 'pressed')
				{
					cpuReceptors.members[i].offset.set(-2, -2);
				}
				else
				{
					cpuReceptors.members[i].offset.set();
				}
			}

			if (receptors.members[i].animation.curAnim.name == 'confirm')
			{
				receptors.members[i].offset.set(25, 25);
			}
			else if (receptors.members[i].animation.curAnim.name == 'pressed')
			{
				receptors.members[i].offset.set(-2, -2);
			}
			else
			{
				receptors.members[i].offset.set();
			}
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

		if (!Option.optimisation)
			camFollow.setPosition(bf.getMidpoint().x - 150, bf.getMidpoint().y - 150);

		if (songStarted)
		{
			if (songName == "disruption" || songName == "detected" || songName == "og")
			{
				modChartUpdate(elapsed);
			}
		}
		if (FlxG.keys.justPressed.NINE)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.stop();
			}
			FlxG.switchState(new AnimationDebugState());
		}
		super.update(elapsed);
	}

	var smoothness:Float = 0;

	var section1:Bool = false;
	var reversed:Bool = false;
	var tweenFinished:Bool = false;
	var isDefault:Bool = false;
	var defaultX:Float = 0;
	var defaultY:Float = 0;
	var tweening:Bool = false;

	var daBeatHit:Bool = false;

	function tweenNotes()
	{
		if (songName == "og")
		{
			if (!tweening)
			{
				trace("tween that shit");

				var left = receptors.members[0];
				var down = receptors.members[1];
				var up = receptors.members[2];
				var right = receptors.members[3];

				right.x = up.x;
				up.x = down.x;
				down.y += 60;
				up.y -= 60;

				notes.forEachAlive(function(daNote:Note)
				{
					if (daNote.mustPress)
					{
						switch (daNote.noteData)
						{
							case 0:
								daNote.y = receptors.members[0].y;
							case 1:
								daNote.x = receptors.members[1].x;
							case 2:
								daNote.x = receptors.members[2].x;
							case 3:
								daNote.y = receptors.members[3].y;
						}
					}
				});

				for (arrow in [left, down, up, right])
				{
					arrow.y += 150;
					arrow.x -= 100;
				}

				for (i in 0...receptors.members.length)
				{
					var daReceptor = receptors.members[i];

					// daReceptor.angle -= 90;

					// FlxTween.tween(daReceptor, {angle: daReceptor.angle + 180}, 1, {ease: FlxEase.quartInOut, type: PINGPONG});
					FlxTween.tween(daReceptor, {x: daReceptor.x - 300}, 5, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.5 * i});
					FlxTween.tween(daReceptor, {y: daReceptor.y + 500}, 2, {type: PINGPONG, ease: FlxEase.quadInOut, startDelay: 0.5 * i});
					FlxTween.tween(PlayState, {speed: -speed}, 2, {
						type: PINGPONG,
						ease: FlxEase.quadInOut,
						startDelay: 0.5 * i,
						onComplete: function(_)
						{
							trace("stop");
						}
					});
				}
			}

			tweening = true;
		}

		if (songName == "disruption")
		{
			if (!tweening)
			{
				receptors.members[2].x -= 30;
				receptors.members[1].x += 30;

				for (i in 0...receptors.length)
				{
					var daReceptor = receptors.members[i];

					if (i == 0 || i == 2)
					{
						FlxTween.tween(daReceptor, {y: daReceptor.y - 50}, 2, {ease: FlxEase.quadInOut, type: PINGPONG});
						FlxTween.tween(daReceptor, {x: daReceptor.x - 100}, 0.5 * 2, {ease: FlxEase.quadInOut, type: PINGPONG});
					}
					else
					{
						FlxTween.tween(daReceptor, {y: daReceptor.y + 50}, 2, {ease: FlxEase.quadInOut, type: PINGPONG});
						FlxTween.tween(daReceptor, {x: daReceptor.x + 100}, 0.5 * 2, {ease: FlxEase.quadInOut, type: PINGPONG});
					}

					FlxTween.tween(daReceptor, {"scale.y": daReceptor.scale.y + 0.2}, 0.1, {ease: FlxEase.quadInOut, type: PINGPONG});
					FlxTween.tween(daReceptor, {"scale.x": daReceptor.scale.x - 0.2}, 0.1, {ease: FlxEase.quadInOut, type: PINGPONG});
				}

				notes.forEachAlive(function(daNote:Note)
				{
					FlxTween.tween(daNote, {"scale.y": daNote.scale.y + 0.4}, 1, {ease: FlxEase.quadInOut, type: PINGPONG});
					FlxTween.tween(daNote, {"scale.x": daNote.scale.x - 0.4}, 1, {ease: FlxEase.quadInOut, type: PINGPONG});
				});

				for (i in 0...cpuReceptors.length)
				{
					var daReceptor = cpuReceptors.members[i];

					if (i == 0 || i == 2)
					{
						FlxTween.tween(daReceptor, {y: daReceptor.y - 50}, 2, {ease: FlxEase.quadInOut, type: PINGPONG});
						FlxTween.tween(daReceptor, {x: daReceptor.x - 100}, 0.5 * 2, {ease: FlxEase.quadInOut, type: PINGPONG});
					}
					else
					{
						FlxTween.tween(daReceptor, {y: daReceptor.y + 50}, 2, {ease: FlxEase.quadInOut, type: PINGPONG});
						FlxTween.tween(daReceptor, {x: daReceptor.x + 100}, 0.5 * 2, {ease: FlxEase.quadInOut, type: PINGPONG});
					}

					FlxTween.tween(daReceptor, {"scale.y": daReceptor.scale.y + 0.2}, 1, {ease: FlxEase.quadInOut, type: PINGPONG});
					FlxTween.tween(daReceptor, {"scale.x": daReceptor.scale.x - 0.2}, 1, {ease: FlxEase.quadInOut, type: PINGPONG});
				}
			}

			tweening = true;
		}

		if (songName == "detected")
		{
			if (!tweening)
			{
				FlxTween.tween(PlayState, {speed: -speed}, 4, {ease: FlxEase.quadInOut, type: PINGPONG});
				receptors.forEachAlive(function(daReceptor:FlxSprite)
				{
					FlxTween.tween(daReceptor, {y: (FlxG.height / 2) + 100}, 4, {ease: FlxEase.quadInOut, type: PINGPONG});
					FlxTween.tween(daReceptor, {x: daReceptor.x + 50}, 2, {ease: FlxEase.quadInOut, type: PINGPONG});
				});
				cpuReceptors.forEachAlive(function(daReceptor:FlxSprite)
				{
					FlxTween.tween(daReceptor, {y: (FlxG.height / 2) + 100}, 4, {ease: FlxEase.quadInOut, type: PINGPONG});
					FlxTween.tween(daReceptor, {x: daReceptor.x + 50}, 2, {ease: FlxEase.quadInOut, type: PINGPONG});
				});
			}

			tweening = true;
		}
	}

	function modChartUpdate(elapsed:Float)
	{
		try
		{
			if (!isSM && !Option.middleScroll)
			{
				if (songName == "disruption" || songName == "detected")
				{
					if (_beatHit)
					{
						daBeatHit = true;
					}

					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.mustPress)
						{
							if (daNote.isSus)
							{
								daNote.x = receptors.members[daNote.noteData].x + 75;
							}
							else
							{
								daNote.x = receptors.members[daNote.noteData].x;
							}
						}
						else
						{
							if (daNote.isSus)
							{
								daNote.x = cpuReceptors.members[daNote.noteData].x + 75;
							}
							else
							{
								daNote.x = cpuReceptors.members[daNote.noteData].x;
							}
						}
						if (songName == "disruption")
						{
							daNote.updateHitbox();
						}
					});

					if (songName == "disruption")
					{
						receptors.forEachAlive(function(receptor:FlxSprite)
						{
							receptor.updateHitbox();
						});

						cpuReceptors.forEachAlive(function(receptor:FlxSprite)
						{
							receptor.updateHitbox();
						});
					}
				}

				if (tweening && songName != "og")
				{
					return;
				}
				else if (songName != "og")
				{
					tweenNotes();
				}
			}
		}
		catch (e)
		{
			#if PRECISE_DEBUG
			trace(e);
			#end
		}
	}

	function endSong()
	{
		songStarted = false;

		canSync = false;

		if (FlxG.sound.music != null && !songStarted)
		{
			FlxG.sound.music.volume = 0;
			FlxG.sound.music.stop();
		}

		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handInput);
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, realeasedInput);
		FlxG.switchState(new Menu());
	}
}
