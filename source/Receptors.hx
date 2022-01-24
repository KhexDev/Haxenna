import flixel.FlxG;
import flixel.FlxSprite;

class Receptors extends FlxSprite
{
	public var pressed:Bool;

	public function new()
	{
		super();
	}

	override public function update(elapsed:Float)
	{
		if (animation.curAnim.name == 'pressed')
			pressed = true;
		else
			pressed = false;

		super.update(elapsed);
	}
}
