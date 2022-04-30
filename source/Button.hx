import _cool_Util.Paths;
import flixel.FlxG;
import flixel.FlxSprite;

class Button extends FlxSprite
{
	public var isPressed:Bool;

	public function new(sprite:String)
	{
		super();
		loadGraphic(Paths.getImage(sprite));
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.mouse.overlaps(this) && FlxG.mouse.justPressed)
			isPressed = true;
		else
			isPressed = false;

		super.update(elapsed);
	}
}
