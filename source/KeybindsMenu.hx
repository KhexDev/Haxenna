import Options.Option;
import Options;
import flash.events.KeyboardEvent;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.util.FlxColor;
#if sys
import sys.io.File;
#end

class KeybindsMenu extends FlxState
{
	var keys:FlxTypedGroup<FlxText>;
	var binds:FlxTypedGroup<FlxText>;

	public static var control:Control = new Control();

	// var controls = [control._LEFT, control._UP, control._DOWN, control._RIGHT];
	var labelKeys = ["LEFT", "DOWN", "UP", "RIGHT"];

	var selector:FlxSprite;

	var selection:Int = 0;

	var binding:Bool = false;

	override public function create()
	{
		keys = new FlxTypedGroup<FlxText>();
		add(keys);

		binds = new FlxTypedGroup<FlxText>();
		add(binds);

		selector = new FlxSprite().makeGraphic(15, 30, FlxColor.WHITE);
		add(selector);

		for (i in 0...labelKeys.length)
		{
			keys.add(new FlxText(FlxG.width / 2 - 200, FlxG.height / 2 + (50 * i), 0, labelKeys[i], 32));
		}

		// var keybinds = sys.io.File.getContent("assets/data/keybinds.txt").split(" ");

		for (i in 0...keys.length)
			binds.add(new FlxText((keys.members[i].x + keys.members[i].width) + 30, keys.members[i].y, 0, Option.controls[i], 32));

		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, getInput);

		super.create();
	}

	function getInput(event:KeyboardEvent)
	{
		try
		{
			var bind:FlxKey = FlxKey.toStringMap.get(event.keyCode);

			trace("got keybind " + bind + " for " + event.keyCode);

			if (event.keyCode == 13)
				return;

			if (selected)
			{
				var oldBind:FlxText = binds.members[selection];

				Option.controls[selection] = bind;

				binds.members[selection].text = bind;
				remove(binds);
				add(binds);

				selected = false;
			}
		}
		catch (e)
		{
			#if debug
			trace(e);
			#end
		}
	}

	function ui_shit()
	{
		if (FlxG.keys.justPressed.ENTER)
			selected = !selected;

		if (FlxG.keys.justPressed.DOWN && !selected)
			selection++;
		if (FlxG.keys.justPressed.UP && !selected)
			selection--;

		if (selection < 0)
			selection = keys.length - 1;
		if (selection > keys.length - 1)
			selection = 0;
	}

	var selected:Bool = false;
	var daBinds:String;

	override public function update(elapsed:Float)
	{
		FlxG.watch.addQuick("curSelection", keys.members[selection].text + selection);
		FlxG.watch.addQuick("bind", Option.controls[selection]);

		// daBinds = controls[selection];

		if (selected)
			selector.x = binds.members[selection].x - 20;
		else
			selector.x = keys.members[selection].x - 20;

		selector.y = keys.members[selection].y;

		ui_shit();

		if (FlxG.keys.justPressed.BACKSPACE)
		{
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, getInput);
			FlxG.switchState(new OptionState());
		}

		super.update(elapsed);
	}
}
