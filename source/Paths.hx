import flixel.graphics.frames.FlxAtlasFrames;
import openfl.Assets;

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

	static public function getSparrowAtlas(key:String)
	{
		return FlxAtlasFrames.fromSparrow('assets/images/$key.png', getXML(key));
	}
}
