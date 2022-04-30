import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.Timer;
import openfl.display.FPS;
import openfl.display.FPS;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextField;
import openfl.text.TextFormat;

class FpsText extends FlxTypedGroup<FlxText>
{
	var daText:FlxText;
	var times:Array<Float>;
	var memPeak:Float = 0;

	public var x:Float = 0;
	public var y:Float = 0;

	public function new(x:Float = 0, y:Float = 0)
	{
		super();

		this.x = x;
		this.y = y;

		// color = FlxColor.WHITE;

		// text = "FPS: ";

		times = [];

		// addEventListener(Event.ENTER_FRAME, onEnter);

		daText = new FlxText(x, y, 0, "null", 16);

		add(daText);
	}

	function onEnter(_)
	{
		// text = "FPS: " + times.length;
	}

	function updateFPS()
	{
		remove(daText);
		daText = new FlxText(x, y, 0, "FPS : " + times.length, 16);
		add(daText);
	}

	override public function update(elapsed:Float)
	{
		var now = Timer.stamp();
		times.push(now);

		while (times[0] < now - 1)
			times.shift();

		var mem:Float = Math.round(System.totalMemory / 1024 / 1024 * 100) / 100;

		if (mem > memPeak)
			memPeak = mem;

		updateFPS();

		super.update(elapsed);
	}
}
