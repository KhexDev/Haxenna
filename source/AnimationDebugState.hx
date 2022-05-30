package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class AnimationDebugState extends FlxState
{
	var centerPoint:FlxSprite;
	var daCharacter:Character;
	var selection:Int = 0;

	var animationList:Array<String> = [];
	var animationOffsets:Array<Array<Float>> = [];

	var offsetsText:FlxText;

	var defaultX:Float = 0;
	var defaultY:Float = 0;

	override public function create()
	{
		daCharacter = new Character();
		daCharacter.screenCenter(XY);
		add(daCharacter);

		defaultX = daCharacter.x;
		defaultY = daCharacter.y;

		animationList = daCharacter.animation.getNameList();

		trace(animationList);

		for (i in 0...animationList.length)
		{
			animationOffsets.push([0, 0]);
		}

		trace(animationOffsets);

		centerPoint = new FlxSprite();
		centerPoint.makeGraphic(10, 10, FlxColor.BLUE);
		centerPoint.screenCenter();
		add(centerPoint);

		super.create();
	}

	inline function updateOffsets()
	{
		animationOffsets[selection][0] = defaultX - daCharacter.x;
		animationOffsets[selection][1] = defaultY - daCharacter.y;
	}

	override public function update(elapsed:Float)
	{
		FlxG.watch.addQuick("curAnimation", animationList[selection]);
		FlxG.watch.addQuick("curAnimation offsets", animationOffsets[selection]);
		FlxG.watch.addQuick("animations offsets", animationOffsets);

		updateOffsets();

		if (FlxG.keys.pressed.SHIFT)
		{
			if (FlxG.keys.justPressed.RIGHT)
			{
				daCharacter.x += 10;
			}
			else if (FlxG.keys.justPressed.LEFT)
			{
				daCharacter.x -= 10;
			}

			if (FlxG.keys.justPressed.UP)
			{
				daCharacter.y -= 10;
			}
			else if (FlxG.keys.justPressed.DOWN)
			{
				daCharacter.y += 10;
			}
		}
		else
		{
			if (FlxG.keys.justPressed.RIGHT)
			{
				daCharacter.x += 1;
			}
			else if (FlxG.keys.justPressed.LEFT)
			{
				daCharacter.x -= 1;
			}

			if (FlxG.keys.justPressed.UP)
			{
				daCharacter.y -= 1;
			}
			else if (FlxG.keys.justPressed.DOWN)
			{
				daCharacter.y += 1;
			}
		}

		if (FlxG.keys.justPressed.A && selection - 1 >= 0)
		{
			selection--;
		}
		if (FlxG.keys.justPressed.E && selection + 1 <= animationList.length - 1)
		{
			selection++;
		}

		if (FlxG.keys.justPressed.SPACE)
		{
			trace(animationOffsets);

			if (!daCharacter.animation.curAnim.finished)
			{
				daCharacter.animation.curAnim.finish();
			}

			// daCharacter.playAnim(animationList[selection], animationOffsets[selection]);
			daCharacter.animation.play(animationList[selection]);
			daCharacter.offset.set(animationOffsets[selection][0], animationOffsets[selection][1]);
		}

		super.update(elapsed);
	}
}
