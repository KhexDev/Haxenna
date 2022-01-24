class Conductor
{
	var bpm:Int = 0;
	var beat:Float = 0;

	static public var scrollSpeed:Int = 2;
	static public var songPosition:Float = 0.0;
	static public var startTime:Float = 0;

	public function changeBPM(bpm:Int)
	{
		return this.bpm = bpm;
	}
}
