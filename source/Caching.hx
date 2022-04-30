import Sys;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

using StringTools;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

class Caching extends FlxState
{
	var loadBar:FlxBar;

	var loaded:Int = 0;

	var finished:Bool = false;

	var cachedSong = [];
	var cachedChart = [];

	var toLoad:Int = 0;

	var loadText:FlxText;

	override public function create()
	{
		// cachedSong = sys.io.File.getContent("assets/data/songList.txt").split('\n');

		loadBar = new FlxBar(100, FlxG.height / 2, LEFT_TO_RIGHT, Std.int(FlxG.width / 2), 20, null, "loaded");
		loadBar.createColoredFilledBar(FlxColor.BLUE);
		loadBar.createImageEmptyBar(FlxColor.GRAY);
		add(loadBar);

		FlxG.switchState(new Menu());

		super.create();
	}

	var testTimer:Float = 0;

	function checkDirLenght()
	{
		#if sys
		for (i in FileSystem.readDirectory("assets/music/"))
		{
			if (i.endsWith(".ogg"))
				toLoad++;
		}
		#end
	}

	function cacheSong()
	{
		#if sys
		for (i in FileSystem.readDirectory("assets/music/"))
		{
			// Sys.sleep(1000);
			if (i.endsWith(".ogg"))
			{
				trace(i);
				cachedSong.push(i);
			}
		}
		#end
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
