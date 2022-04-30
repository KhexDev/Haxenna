package;

import flixel.graphics.FlxGraphic;
import flixel.util.FlxGradient;
import openfl.display.BitmapData;

class Cache
{
	public static var cache:Map<String, FlxGraphic> = new Map<String, FlxGraphic>();

	static public function add(path:String)
	{
		var data:FlxGraphic = FlxGraphic.fromBitmapData(BitmapData.fromFile(path));
		data.persist = true;

		cache.set(path, data);
	}
}
