class Conductor
{
	public static var bpm:Float = 0;
	public static var crochet:Float = ((60 / bpm) * 1000);
	public static var steps:Float = crochet * 0.25;
	public static var stepCrochet:Float = crochet / 4;
	public static var offsets:Float = 0;
	static public var songPosition:Float = 0.0;
	static public var lastSongPos:Float = 0.0;

	public static var safeFrames:Float = 15;

	public function new() {}

	public static function changeBPM(newBPM:Float)
	{
		#if debug
		trace('set bpm to $newBPM');
		#end

		bpm = newBPM;

		crochet = (60 / bpm) * 1000;
		steps = (crochet / 4);
	}
}
