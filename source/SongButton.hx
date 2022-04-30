import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

class SongButton extends FlxTypedGroup<FlxSprite>
{
	var buttonBG:FlxSprite;
	var songText:FlxText;
	var thumbnail:FlxSprite;

	public function new(x:Float = 0, y:Float = 0) {}
}
