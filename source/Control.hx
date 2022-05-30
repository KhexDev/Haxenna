package;

import Options.Option;
import flixel.input.actions.FlxAction.FlxActionDigital;
import flixel.input.actions.FlxAction;
import flixel.input.keyboard.FlxKey;

class Control
{
	public var LEFT = new FlxActionDigital();
	public var DOWN = new FlxActionDigital();
	public var UP = new FlxActionDigital();
	public var RIGHT = new FlxActionDigital();

	public var LEFT_P = new FlxActionDigital();
	public var DOWN_P = new FlxActionDigital();
	public var UP_P = new FlxActionDigital();
	public var RIGHT_P = new FlxActionDigital();

	public var LEFT_R = new FlxActionDigital();
	public var DOWN_R = new FlxActionDigital();
	public var UP_R = new FlxActionDigital();
	public var RIGHT_R = new FlxActionDigital();

	public function new(player:Int = 1)
	{
		var keyHold:Array<FlxActionDigital> = [LEFT, DOWN, UP, RIGHT];
		var keyPresses:Array<FlxActionDigital> = [LEFT_P, DOWN_P, UP_P, RIGHT_P];
		var keyReleased:Array<FlxActionDigital> = [LEFT_R, DOWN_R, UP_R, RIGHT_R];

		for (i in 0...4)
		{
			if (player == 2)
			{
				var converted = FlxKey.fromStringMap.get(Option.controls2[i]);
				keyHold[i].addKey(converted, PRESSED);
				keyPresses[i].addKey(converted, JUST_PRESSED);
				keyReleased[i].addKey(converted, JUST_RELEASED);
			}
			else
			{
				var converted = FlxKey.fromStringMap.get(Option.controls[i]);
				keyHold[i].addKey(converted, PRESSED);
				keyPresses[i].addKey(converted, JUST_PRESSED);
				keyReleased[i].addKey(converted, JUST_RELEASED);
			}
		}

		// LEFT.addKey(FlxKey.D, JUST_PRESSED);
		// DOWN.addKey(FlxKey.F, JUST_PRESSED);
		// UP.addKey(FlxKey.J, JUST_PRESSED);
		// RIGHT.addKey(FlxKey.K, JUST_PRESSED);
	}
}
