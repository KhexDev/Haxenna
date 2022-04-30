import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.effects.FlxFlicker;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class Menu extends MusicBeatState
{
	var songName:FlxText;
	var shitButton:Button;
	var optButton:FlxText;
	var exitButton:FlxText;

	var bg:FlxSprite;

	var dll:Int->Int->Int;

	override public function create()
	{
		// Data.initSave();
		Main.flixelInit();

		// dll = cpp.Lib.load()

		var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
		diamond.persist = true;
		diamond.destroyOnNoUse = false;

		FlxTransitionableState.defaultTransIn = new TransitionData(TILES, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
			new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
		FlxTransitionableState.defaultTransOut = new TransitionData(TILES, FlxColor.BLACK, 0.7, new FlxPoint(0, 1), {asset: diamond, width: 32, height: 32},
			new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		bg = new FlxSprite();
		bg.loadGraphic("assets/images/daMenuBG.png");
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.updateHitbox();
		add(bg);

		songName = new FlxText("HAXENNA", 50);
		songName.color = FlxColor.WHITE;
		songName.screenCenter(X);
		songName.y = -100;
		add(songName);
		FlxTween.tween(songName, {y: 50}, 1, {ease: FlxEase.quadInOut});

		shitButton = new Button('shitButton');
		shitButton.x = FlxG.width / 2;
		shitButton.y = FlxG.height + 100;
		// shitButton.screenCenter(XY);
		add(shitButton);

		FlxTween.tween(shitButton, {y: FlxG.height / 2}, 1, {ease: FlxEase.quadInOut});

		optButton = new FlxText("OPTION", 32);
		optButton.x = (FlxG.width / 2 - 300) + (optButton.width / 2);
		optButton.y = shitButton.y;
		add(optButton);

		FlxTween.tween(optButton, {y: FlxG.height / 2}, 1, {ease: FlxEase.quadInOut});

		exitButton = new FlxText("EXIT", 32);
		exitButton.x = (FlxG.width / 2) - (exitButton.width / 2);
		exitButton.y = FlxG.height + 200;
		add(exitButton);

		FlxTween.tween(exitButton, {y: FlxG.height - 100}, 1, {ease: FlxEase.quadInOut});

		FlxG.camera.zoom = 1.1;

		// if (FlxG.sound.music == null)
		// FlxG.sound.playMusic("assets/music/unused/freakyMenu.ogg");

		super.create();
	}

	function flashObject(object:FlxSprite, visible:Bool = false, curInt = 0)
	{
		if (curInt < 10)
		{
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				object.visible = visible;
				return flashObject(object, (visible ? false : true));
			});
		}
	}

	override public function update(elapsed:Float)
	{
		// FlxG.watch.addQuick("game tick", FlxG.game.ticks);

		if (shitButton.isPressed || FlxG.keys.justPressed.ENTER)
		{
			FlxTween.tween(optButton, {y: FlxG.height + 100}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(optButton, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
			FlxTween.tween(songName, {y: -150}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(songName, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
			FlxTween.tween(exitButton, {x: FlxG.width + 200}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(exitButton, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});

			// flashObject(shitButton);

			FlxFlicker.flicker(shitButton, 1, 0.06, false, false);

			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				FlxG.switchState(new SongSelection());
			});
		}

		if (FlxG.mouse.overlaps(exitButton) && FlxG.mouse.justPressed)
		{
			FlxTween.tween(optButton, {y: FlxG.height + 100}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(optButton, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
			FlxTween.tween(songName, {y: -150}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(songName, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
			FlxTween.tween(shitButton, {y: FlxG.height + 100}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(shitButton, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});

			FlxTween.tween(bg, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});

			FlxFlicker.flicker(exitButton, 1, 0.06, false, false);

			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				#if sys
				Sys.exit(1);
				#end
			});
		}

		if (FlxG.mouse.overlaps(optButton) && FlxG.mouse.justPressed)
		{
			FlxTween.tween(shitButton, {y: FlxG.height + 100}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(shitButton, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
			FlxTween.tween(songName, {y: -150}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(songName, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
			FlxTween.tween(exitButton, {x: FlxG.width + 200}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(exitButton, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});

			// flashObject(shitButton);

			FlxFlicker.flicker(optButton, 1, 0.06, false, false);

			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				FlxG.switchState(new OptionState());
			});
		}

		super.update(elapsed);
	}
}
