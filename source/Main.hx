package;

import flixel.FlxGame;
import flixel.util.FlxColor;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	var fps = 60;

	public function new()
	{
		super();
		addChild(new FlxGame(1280, 720, SongSelection, 1, fps, fps));
		addChild(new FPS(10, 10, FlxColor.WHITE));
	}
}
