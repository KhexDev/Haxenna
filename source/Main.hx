package;

import Options.Option;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.addons.text.FlxTextField;
import flixel.input.actions.FlxActionManager;
import flixel.util.FlxColor;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	static public var fps = 60;

	public static var fpsText:FPS = new FPS(10, 10, FlxColor.WHITE);

	var daDebug:Bool = false; // manually change this variable for PRECISE_DEBUG;

	// var fpsInfo:FpsText = new FpsText(10, 10);

	public static function flixelInit()
	{
		Data.initSave();
		FlxG.fixedTimestep = false;

		#if debug
		Main.initDebugCommand();
		#end

		trace(FlxG.renderBlit);
		trace(FlxG.renderMethod);
	}

	public static function initDebugCommand()
	{
		FlxG.console.registerFunction("reset_G", function()
		{
			FlxG.resetGame();
		});

		FlxG.console.registerFunction("reset_S", function()
		{
			FlxG.resetState();
		});
	}

	public function new()
	{
		super();
		addChild(new FlxGame(1290, 720, Menu, 1, fps, fps));
		addChild(fpsText);
	}
}
