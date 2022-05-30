package;

import Options.Option;
import _cool_Util.Paths;
import _cool_Util.SearchBar;
import _cool_Util.SongBox;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.Assets;

using StringTools;

#if html5
import js.html.FileReader;
import js.html.FileSystem;
import js.html.FileSystemDirectoryEntry;
#end
#if sys
import sys.FileSystem;
import sys.io.File;
#end

class SongSelection extends MusicBeatState
{
	var songName:FlxText;

	var selection:Int = 0;

	var songFiles:Array<String> = [];

	var tempSongList:Array<String> = [];
	var songList:FlxTypedGroup<SongBox>;

	var bg:FlxSprite;

	var camFollow:FlxObject;

	var songsSwagHeigth:Float = 0;

	var defaultTextX:Float = 0;

	var searchBar:SearchBar;

	var canPress:Bool = false;

	#if html5
	static private var daFileSystem:FileSystemDirectoryEntry;
	#end

	override public function create()
	{
		camFollow = new FlxObject(FlxG.width / 2, FlxG.height / 2, 1, 1);
		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.05 / (openfl.Lib.current.stage.frameRate / 60));

		bg = new FlxSprite().loadGraphic("assets/images/songSelection_bg.png");
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.updateHitbox();
		bg.scrollFactor.set();
		add(bg);

		#if sys
		for (i in FileSystem.readDirectory("assets/music/"))
		{
			var daSong:String = i;

			if (daSong == "freakyMenu.ogg")
				continue;

			#if debug
			trace(daSong);
			#end

			// trace(daSong.endsWith(".ogg"));

			if (daSong.endsWith(".ogg"))
				songFiles.push(daSong.replace(".ogg", ""));
		}
		#end

		songList = new FlxTypedGroup<SongBox>();
		add(songList);

		for (i in 0...songFiles.length)
		{
			var songBox:SongBox = new SongBox(FlxG.width / 2, 0, songFiles[i], 50);
			songBox.y = (songBox.height + 100) * i;
			songBox.x -= (songBox.width / 2) + 300;
			songList.add(songBox);

			/*var daSong:FlxText = new FlxText(FlxG.width / 2, 0, 0, songFiles[i], 50);
				// daSong.alpha = 0;
				// daSong.font = Paths.getFonts("funkin");
				daSong.y = (daSong.height + 100) * i;
				daSong.x -= (daSong.width / 2) + 300;
				songList.add(daSong); */
		}

		for (i in 0...songList.members.length)
		{
			var daSong = songList.members[i];
		}

		#if debug
		trace(songFiles);
		#end

		searchBar = new SearchBar(FlxG.width / 2, 25);
		searchBar.x -= (searchBar.width / 2);
		add(searchBar);

		for (i in songList.members)
		{
			searchBar.data.push(i.text);
		}

		// trace(searchBar.data);

		super.create();
	}

	function updateCamPos()
	{
		if (songList.members.length > 0)
		{
			var daSong = songList.members[selection];

			if (daSong != null)
			{
				if (selection > -1 && selection < songList.members.length)
				{
					camFollow.setPosition(daSong.x + (daSong.width / 2) + 300, daSong.y + (daSong.height / 2));
				}
			}
		}
		else
		{
			trace("NO");
		}
	}

	function updateSongList()
	{
		trace("updating song list...");
		#if PRECISE_DEBUG
		trace("PRECISING SHIT");
		#end

		selection = 0;

		var daSongList = searchBar.getResult();

		songFiles = daSongList;

		trace(daSongList);

		remove(songList);

		trace(songList.members.length);

		/*songList.forEachAlive(function(daSong:FlxText)
			{
				trace("removing " + daSong.text);
				daSong.kill();
				songList.remove(daSong, true);
				daSong.destroy();
		});*/

		for (song in songList.members)
		{
			if (daSongList.contains(song.text))
			{
				continue;
			}
			else
			{
				song.kill();
				songList.remove(song, true);
				song.destroy();
			}
		}

		trace(songList.members.length);

		/*for (i in 0...daSongList.length)
			{
				trace("adding " + daSongList[i]);
				var daSong:FlxText = new FlxText(FlxG.width / 2, 0, 0, daSongList[i], 50);
				daSong.y = (daSong.height + 100) * i;
				daSong.x -= (daSong.width / 2) + 300;
				songList.add(daSong);
		}*/

		add(songList);

		trace(songList.members.length);
	}

	override public function update(elapsed:Float)
	{
		#if debug
		FlxG.watch.addQuick("selection", songFiles[selection] + Std.string(selection));
		FlxG.watch.addQuick("curSelction", Option.songName);
		#end

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

		Option.songName = songFiles[selection];

		for (text in songList)
		{
			var defaultX = text.x;
			text.x = FlxMath.lerp(defaultX, text.x, 0.25);
		}

		// songList.members[selection].setPosition(songList.members[selection].x + 200, songList.members[selection].y);

		if (FlxG.keys.justPressed.ENTER)
		{
			if (!searchBar.typing)
			{
				for (song in songList)
				{
					if (song.text == songList.members[selection].text)
					{
						for (sprite in song.members)
						{
							FlxFlicker.flicker(sprite, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								FlxG.switchState(new PlayState());
							});
						}
					}
					else
					{
						// FlxTween.tween(song, {x: -100}, 0.8, {ease: FlxEase.quadInOut});
						// FlxTween.tween(song, {alpha: 0}, 0.8, {ease: FlxEase.quadInOut});
					}
				}
			}
		}

		// add
		if (FlxG.mouse.wheel < 0)
		{
			selection++;
		}
		// sub
		if (FlxG.mouse.wheel > 0)
		{
			selection--;
		}

		// updateSongName();

		if (selection < 0)
			selection = songFiles.length - 1;
		if (selection > songFiles.length - 1)
			selection = 0;

		if (FlxG.keys.justPressed.DOWN)
			selection++;
		if (FlxG.keys.justPressed.UP)
			selection--;

		if (FlxG.keys.justPressed.ESCAPE)
			FlxG.switchState(new Menu());

		updateCamPos();

		if (FlxG.keys.justPressed.A && !searchBar.typing)
		{
			updateSongList();
		}

		super.update(elapsed);
	}
}
