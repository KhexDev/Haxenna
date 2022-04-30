package;

import Options.Option;
import _cool_Util.Paths;
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

using StringTools;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

class SongSelection extends MusicBeatState
{
	var songName:FlxText;

	var selection:Int = 0;

	var songFiles:Array<String> = [];

	var songList:FlxTypedGroup<FlxText>;

	var bg:FlxSprite;

	var camFollow:FlxObject;

	var songsSwagHeigth:Float = 0;

	var defaultTextX:Float = 0;

	override public function create()
	{
		camFollow = new FlxObject(FlxG.width / 2, FlxG.height / 2, 1, 1);
		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.05);

		bg = new FlxSprite().loadGraphic("assets/images/songSelection_bg.png");
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.updateHitbox();
		bg.scrollFactor.set();
		add(bg);

		songName = new FlxText(FlxG.width / 2, FlxG.height / 4, 0, "null", 50);
		songName.x -= songName.width / 2;
		songName.x -= songName.width;
		// add(songName);

		#if sys
		for (i in FileSystem.readDirectory("assets/music/"))
		{
			var daSong:String = i;

			if (/*daSong == "ballistic.ogg" || */ daSong == "freakyMenu.ogg" /*|| daSong == "danger.ogg"*/ /*|| daSong == "thunderstorm.ogg"*/)
				continue;

			#if debug
			trace(daSong);
			#end

			// trace(daSong.endsWith(".ogg"));

			if (daSong.endsWith(".ogg"))
				songFiles.push(daSong.replace(".ogg", ""));
		}
		#end

		songList = new FlxTypedGroup<FlxText>();
		add(songList);

		for (i in 0...songFiles.length)
		{
			var daSong:FlxText = new FlxText(FlxG.width / 2, 0, 0, songFiles[i], 50);
			// daSong.alpha = 0;
			// daSong.font = Paths.getFonts("funkin");
			daSong.y = (daSong.height + 100) * i;
			daSong.x -= (daSong.width / 2) + 300;
			songList.add(daSong);
			defaultTextX = daSong.x;
		}

		for (i in 0...songList.members.length)
		{
			var daSong = songList.members[i];
		}

		#if debug
		trace(songFiles);
		#end

		super.create();
	}

	function updateSongName()
	{
		remove(songName);
		songName = new FlxText(FlxG.width / 2, FlxG.height / 4, 0, songFiles[selection], 50);
		songName.x -= (songName.width / 2);
		add(songName);
	}

	function updateCamPos()
	{
		var daSong = songList.members[selection];
		if (selection > -1 && selection < songList.members.length)
			camFollow.setPosition(daSong.x + (daSong.width / 2) + 300, daSong.y + (daSong.height / 2));
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

		if (FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed)
		{
			for (song in songList)
			{
				if (song == songList.members[selection])
				{
					FlxFlicker.flicker(song, 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						FlxG.switchState(new PlayState());
					});
				}
				else
				{
					FlxTween.tween(song, {x: -100}, 0.8, {ease: FlxEase.quadInOut});
					FlxTween.tween(song, {alpha: 0}, 0.8, {ease: FlxEase.quadInOut});
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

		if (FlxG.keys.justPressed.BACKSPACE)
			FlxG.switchState(new Menu());

		updateCamPos();

		super.update(elapsed);
	}
}
