import flixel.graphics.frames.FlxAtlasFrames;

class Paths
{
	static public function getFromSparrowAtlas(name:String)
	{
		return FlxAtlasFrames.fromSparrow('assets/images/$name.png', 'assets/images/$name.xml');
	}
}
