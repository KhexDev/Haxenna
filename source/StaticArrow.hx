import flixel.FlxSprite;

class StaticArrow extends FlxSprite
{
	var animOffsets:Map<String, Array<Float>> = [];

	public var noteSkin:String;

	public function new(x:Float = 0, y:Float = 0, noteSkin:String = "og")
	{
		this.noteSkin = noteSkin;

		super(x, y);
	}

	public function addOffsets(name:String, x:Float = 0, y:Float = 0) {}

	public function playAnim(AnimName:String)
	{
		this.animation.play(AnimNAme);
	}
}
