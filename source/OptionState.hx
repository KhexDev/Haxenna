import Options.Option;
import _cool_Util.Paths;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class OptionState extends MusicBeatState
{
	var title:FlxText;
	var selector:FlxSprite;

	var options:FlxTypedGroup<FlxText>;

	var selection:Int = 0;

	var optionList = [
		"offset", "scroll speed", "show fps", "fps cap", "syncing", "keybinds", "opponent mode", "middle scroll", "ghost tapping", "miss sounds",
		"multiplier", "input", "botplay", "optimisation", "two player ?"
	];

	var infoText:FlxText;

	var bg:FlxSprite;

	var camFollow:FlxObject;

	override public function create()
	{
		super.create();

		camFollow = new FlxObject(FlxG.width / 2, FlxG.height / 2, 1, 1);
		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.05 / (openfl.Lib.current.stage.frameRate / 60));

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		bg.scrollFactor.set();
		add(bg);

		selector = new FlxSprite().makeGraphic(15, 30);
		selector.screenCenter();
		add(selector);

		options = new FlxTypedGroup<FlxText>();
		add(options);

		options.add(new FlxText("offset", 50));
		options.add(new FlxText("scroll speed", 50));
		options.add(new FlxText("show fps", 50));
		options.add(new FlxText('fps cap', 50));
		options.add(new FlxText('syncing', 50));
		options.add(new FlxText('keybinds', 50));
		options.add(new FlxText('opponent mode', 50));
		options.add(new FlxText('middle scroll', 50));
		options.add(new FlxText('ghost tapping', 50));
		options.add(new FlxText('miss sounds', 50));
		options.add(new FlxText('multiplier', 50));
		options.add(new FlxText('input', 50));
		options.add(new FlxText('botplay', 50));
		options.add(new FlxText('optimisation', 50));
		options.add(new FlxText('two player ?', 50));

		for (i in options)
		{
			i.x = FlxG.width / 2 - (i.width / 2);
			i.y = FlxG.height / 2;
		}

		for (i in 0...options.length)
		{
			options.members[i].y += (options.members[i].height + 100) * i;
		}

		infoText = new FlxText(10, FlxG.height - 100, 0, "select category");
		add(infoText);
	}

	function UI_update()
	{
		if (selection > -1 && selection < options.members.length)
		{
			selector.x = options.members[selection].x - 20;
			selector.y = options.members[selection].y + 10;
		}

		if (FlxG.keys.justPressed.DOWN)
		{
			if (selection >= options.members.length - 1)
			{
				selection = 0;
			}
			else
			{
				selection++;
			}
		}
		else if (FlxG.keys.justPressed.UP)
		{
			if (selection <= 0)
			{
				selection = options.members.length - 1;
			}
			else
			{
				selection--;
			}
		}
	}

	function save() {}

	var toChange:Array<Dynamic> = [];

	function updateInfo() {}

	function updateSelectText(daString:String)
	{
		var daText:String = "";

		switch (daString)
		{
			case "offset":
				daText = "offsets: " + Std.string(Option.offset);
			case "fps cap":
				daText = Std.string(Option.fps + "FPS");
			case "scroll speed":
				daText = Std.string(Option.scrollSpeed);
			case "show fps":
				daText = Std.string(Main.fpsText.visible);
			case "syncing":
				daText = Std.string(Option.canSync);
			case "keybinds":
				daText = "for changing keybinds i guess";
			case "render distance":
				daText = "render the note if note strumtime inferior to the value you choosed " + Std.string(Option.renderDistance);
			case "opponent mode":
				daText = "play as the enemie " + Std.string(Option.opponent);
			case "middle scroll":
				daText = Std.string(Option.middleScroll);
			case "ghost tapping":
				daText = Std.string(Option.ghostTapping);
			case "miss sounds":
				daText = Std.string(Option.missSound);
			case "multiplier":
				daText = Std.string(Option.multiplier);
			case "input":
				{
					switch (Option.input)
					{
						case 0:
							daText = "funkin input: only register one note at a time | type: GAME LOOP";
						case 1:
							daText = "kade input: register all note possible and not as responsive as psych input | type: GAME LOOP";
						case 2:
							daText = "psych input: fast but will sometimes fail to register input| type: CALLBACK";
					}
				}
			case "botplay":
				daText = "in case you are bad at the game lol : " + (Option.botPlay ? "enabled" : "disabled");
			case "optimisation":
				daText = "for computer inferior than a chrombook : " + Std.string(Option.optimisation);
			case "two player ?":
				daText = "if you have friend you can play together (not like me) : " + Std.string(Option.twoPlayer);
		}

		remove(infoText);
		infoText = new FlxText(10, FlxG.height - 50, 0, daText, 24);
		infoText.font = Paths.getFonts("funkin");
		infoText.scrollFactor.set();
		add(infoText);
	}

	function updateCamPos()
	{
		var daOption = options.members[selection];

		if (selection >= 0 && selection <= options.members.length)
		{
			camFollow.setPosition(daOption.x + daOption.width / 2, daOption.y + daOption.height / 2);
		}
	}

	override public function update(elapsed:Float)
	{
		#if debug
		FlxG.watch.addQuick("curSelection", selection);
		FlxG.watch.addQuick("daOption", optionList[selection]);
		FlxG.watch.addQuick("fps", openfl.Lib.current.stage.frameRate);
		FlxG.watch.addQuick("scrollSpeed", Option.scrollSpeed);
		#end

		if (FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.UP)
			updateSelectText(optionList[selection]);

		UI_update();

		// HARDCODED ASF
		switch (optionList[selection])
		{
			case "offset":
				if (FlxG.keys.pressed.RIGHT)
					Option.offset += 0.1;
				if (FlxG.keys.pressed.LEFT)
					Option.offset -= 0.1;
				if (FlxG.keys.justPressed.SPACE)
					Option.offset = 0;
				updateSelectText(optionList[selection]);

			case "fps cap":
				if (FlxG.keys.justPressed.RIGHT)
					Option.fps += 10;
				else if (FlxG.keys.justPressed.LEFT && Option.fps - 10 != 20)
					Option.fps -= 10;
				updateSelectText(optionList[selection]);

			case "scroll speed":
				if (FlxG.keys.justPressed.RIGHT)
					Option.scrollSpeed += 0.1;
				if (FlxG.keys.justPressed.LEFT && Option.scrollSpeed - 0.1 != 0.9)
					Option.scrollSpeed -= 0.1;
				updateSelectText(optionList[selection]);

			case "show fps":
				if (FlxG.keys.justPressed.ENTER)
					Main.fpsText.visible = !Main.fpsText.visible;
				updateSelectText(optionList[selection]);

			case "syncing":
				if (FlxG.keys.justPressed.ENTER)
					Option.canSync = !Option.canSync;
				updateSelectText(optionList[selection]);

			case "keybinds":
				if (FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed)
					FlxG.switchState(new KeybindsMenu());
				updateSelectText(optionList[selection]);

			case "render distance":
				if (FlxG.keys.justPressed.RIGHT)
					Option.renderDistance += 1;
				if (FlxG.keys.justPressed.LEFT && Option.renderDistance - 1 != 0)
					Option.renderDistance -= 1;
				updateSelectText(optionList[selection]);

			case "opponent mode":
				if (FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed)
					Option.opponent = !Option.opponent;
				updateSelectText(optionList[selection]);

			case "middle scroll":
				if (FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed)
					Option.middleScroll = !Option.middleScroll;
				updateSelectText(optionList[selection]);

			case "ghost tapping":
				if (FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed)
					Option.ghostTapping = !Option.ghostTapping;
				updateSelectText(optionList[selection]);

			case "miss sounds":
				if (FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed)
					Option.missSound = !Option.missSound;
				updateSelectText(optionList[selection]);
			case "multiplier":
				if (FlxG.keys.justPressed.RIGHT)
					Option.multiplier += 0.25;
				if (FlxG.keys.justPressed.LEFT && Option.renderDistance - 0.25 != 0.5)
					Option.multiplier -= 0.25;
				updateSelectText(optionList[selection]);
			case "input":
				if (FlxG.keys.justPressed.RIGHT && Option.input + 1 <= 2)
				{
					Option.input++;
				}
				if (FlxG.keys.justPressed.LEFT && Option.input - 1 >= 0)
				{
					Option.input--;
				}
				updateSelectText(optionList[selection]);

			case "botplay":
				if (FlxG.keys.justPressed.ENTER)
				{
					Option.botPlay = !Option.botPlay;
				}
				updateSelectText(optionList[selection]);
			case "optimisation":
				if (FlxG.keys.justPressed.ENTER)
				{
					Option.optimisation = !Option.optimisation;
				}
				updateSelectText(optionList[selection]);
			case "two player ?":
				if (FlxG.keys.justPressed.ENTER)
				{
					Option.twoPlayer = !Option.twoPlayer;
				}
				updateSelectText(optionList[selection]);
		}

		if (FlxG.keys.justPressed.BACKSPACE)
		{
			FlxG.switchState(new Menu());
			save();
		}

		#if debug
		if (FlxG.keys.pressed.Q)
			camFollow.x -= 10;
		else if (FlxG.keys.pressed.D)
			camFollow.x += 10;
		if (FlxG.keys.pressed.Z)
			camFollow.y -= 10;
		if (FlxG.keys.pressed.S)
			camFollow.y += 10;
		#end
		updateCamPos();

		// add
		if (FlxG.mouse.wheel < 0)
		{
			if (selection + 1 <= options.members.length - 1)
			{
				selection++;
			}
			else
			{
				selection = 0;
			}
		}

		// sub
		if (FlxG.mouse.wheel > 0)
		{
			if (selection - 1 >= 0)
			{
				selection--;
			}
			else
			{
				selection = options.members.length - 1;
			}
		}

		super.update(elapsed);
	}
}
