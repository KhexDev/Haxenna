// WIP
package;

import flixel.FlxG;

class Data
{
	public static function initSave()
	{
		if (FlxG.save.data.LEFT == null)
			FlxG.save.data.LEFT = "";

		if (FlxG.save.data.RIGHT == null)
			FlxG.save.data.RIGHT = "";

		if (FlxG.save.data.UP == null)
			FlxG.save.data.UP = "";

		if (FlxG.save.data.DOWN == null)
			FlxG.save.data.DOWN = "";
	}
}
