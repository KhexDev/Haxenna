import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Character extends FlxSprite
{
	public var curCharacter:String;

	public function new(x:Float = 0, y:Float = 0, name:String = "bf")
	{
		this.curCharacter = name;
		super(x, y);

		switch (curCharacter)
		{
			case "bf":
				{
					frames = Paths.getFromSparrowAtlas('BOYFRIEND');
					animation.addByPrefix('idle', 'BF idle dance0', 24, false);
					animation.addByPrefix('left', 'BF NOTE LEFT0', 24, false);
					animation.addByPrefix('down', 'BF NOTE DOWN0', 24, false);
					animation.addByPrefix('up', 'BF NOTE UP0', 24, false);
					animation.addByPrefix('right', 'BF NOTE RIGHT0', 24, false);
					animation.play('idle');
				}
		}
	}

	override public function update(elapsed:Float)
	{
		if (animation.curAnim.finished)
		{
			animation.play('idle');

			// new FlxTimer().start(0.5, function(tmr:FlxTimer) {});
		}

		super.update(elapsed);
	}
}
