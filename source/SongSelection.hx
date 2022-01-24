import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class SongSelection extends FlxState
{
	var songName:FlxText;
	var shitButton:Button;

	override public function create()
	{
		songName = new FlxText("SHIT SONG", 50);
		songName.color = FlxColor.WHITE;
		songName.screenCenter(X);
		songName.y = 50;
		add(songName);

		shitButton = new Button('shitButton');
		shitButton.screenCenter(XY);
		add(shitButton);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (shitButton.isPressed)
			FlxG.switchState(new PlayState());

		if (FlxG.keys.justPressed.ENTER)
			FlxG.switchState(new PlayState());

		super.update(elapsed);
	}
}
