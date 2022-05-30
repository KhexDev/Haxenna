import from_another_world.Song.SwagSection;

typedef SwagSong =
{
	var notes:Array<SwagSection>;
	var speed:Float;
	var song:String;
	var eventObjects:Array<Events>;
}

typedef Events =
{
	var name:String;
	var position:Float;
	var value:Float;
	var type:String;
}
