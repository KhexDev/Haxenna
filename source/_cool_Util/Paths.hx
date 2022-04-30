package _cool_Util;

import flixel.graphics.frames.FlxAtlasFrames;
import haxe.Json;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

class Paths
{
	static public function getXML(xml:String)
	{
		return 'assets/images/$xml.xml';
	}

	static public function getImage(image:String)
	{
		return 'assets/images/$image.png';
	}

	static public function getJson(name:String)
	{
		return 'assets/data/charts/$name.json';
	}

	static public function getSparrowAtlas(key:String)
	{
		return FlxAtlasFrames.fromSparrow('assets/images/$key.png', getXML(key));
	}

	static public function getMusic(key:String)
		return 'assets/music/$key';

	static public function getSound(key:String)
		return 'assets/sounds/$key';

	static public function getText(name:String, folder:String = "")
	{
		if (folder != "")
			return 'assets/data/$folder/$name.txt';

		return 'assets/data/$name.txt';
	}

	static public function getFonts(name:String)
		return 'assets/fonts/$name.otf';
}
