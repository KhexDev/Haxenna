import Options.Option;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.addons.ui.FlxUIState;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.util.FlxTimer;
import openfl.Lib;

class MusicBeatState extends FlxUIState
{
	var lastStep:Int = 0;

	public var curStep:Int = 0;

	public var curBeat:Int = 0;

	public var chromeFps:FpsText; // for chrome laptop that dont show fps

	public var canClick:Bool = false;

	override public function create()
	{
		new FlxTimer().start(2, function(timer:FlxTimer)
		{
			// chromeFps = new FpsText(10, 10);
			// chromeFps.scrollFactor.set();
			// add(chromeFps);
		});

		super.create();
	}

	override public function update(elapsed:Float)
	{
		openfl.Lib.current.stage.frameRate = Option.fps;

		var daBeat:Float = Conductor.songPosition / Conductor.crochet;
		var nextBeat = Math.round(daBeat);
		var daElapsedShit:Float = 0;
		var shitInt:Int = 0;

		if (daBeat > nextBeat && daBeat < nextBeat + elapsed)
		{
			curBeat = Math.round(daBeat);
			// beatHit(curBeat);
		}

		super.update(elapsed);
	}

	public function stepHit() {}

	public function beatHit(curBeat:Int) {}

	override public function onFocusLost()
	{
		canClick = false;

		trace("ciao");
	}

	override public function onFocus()
	{
		openfl.Lib.current.stage.frameRate = Option.fps;

		new FlxTimer().start(FlxG.elapsed, function(tmr:FlxTimer)
		{
			canClick = true;
		});

		trace("im back");
	}
}
