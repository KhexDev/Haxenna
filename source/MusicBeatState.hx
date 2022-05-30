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

		var daStep:Float = Conductor.songPosition / Conductor.steps;
		var nextStep:Float = Math.round(daStep);

		#if PRECISE_DEBUG
		FlxG.watch.addQuick("daStep", daStep);
		FlxG.watch.addQuick("nextStep", nextStep);
		FlxG.watch.addQuick("daBeat", daBeat);
		FlxG.watch.addQuick("nextBeat", nextBeat);
		#end

		if (daBeat > nextBeat && daBeat < nextBeat + (elapsed * 10))
		{
			curBeat = Math.round(daBeat);
			#if PRECISE_DEBUG
			trace("next beat");
			#end
			beatHit(curBeat);
		}

		super.update(elapsed);
	}

	// manually update beat
	public function updateBeat() {}

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
