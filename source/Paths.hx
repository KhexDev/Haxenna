import flixel.graphics.frames.FlxAtlasFrames;

class Paths
{
	static public function getFromSparrowAtlas(name:String)
		return FlxAtlasFrames.fromSparrow('assets/images/characters/$name.png', 'assets/images/characters/$name.xml');
}
