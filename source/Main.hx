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
	static public var fps = 120;

	public static var fpsText:FPS = new FPS(10, 10, FlxColor.WHITE);

	// var fpsInfo:FpsText = new FpsText(10, 10);

	public static function flixelInit()
	{
		Data.initSave();
		FlxG.fixedTimestep = false;
		trace(FlxG.renderBlit);
		trace(FlxG.renderMethod);
	}

	public function new()
	{
		super();
		addChild(new FlxGame(1290, 720, Menu, 1, fps, fps));
		addChild(fpsText);
	}
}
