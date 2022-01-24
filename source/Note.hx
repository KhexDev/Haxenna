import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import haxe.io.Float32Array;

class Note extends FlxSprite
{
	var inCharter:Bool;

	public var wasHit:Bool;
	public var canBeHit:Bool;
	public var goodHit:Bool;
	public var rating:String;
	public var songPosition:Float;

	var isSus:Bool;
	var danger:Bool;

	static public var hitZone:Array<Float> = [600, 100];

	public var noteData:Int;
	public var noteType:String;
	public var lastPosition:Float;
	public var prevNote:Float;

	var data = ["LEFT", "LEFT", "UP", "RIGHT"];
	var dataColor = ['purple', 'blue', 'green', 'red'];

	public function new(x:Float, y:Float, noteData:Int, noteType:String, inCharter:Bool)
	{
		super(x, y);
		this.noteData = noteData;
		this.noteType = noteType;
		this.inCharter = inCharter;
		songPosition = y;

		switch (noteType)
		{
			case 'normal':
				frames = Paths.getSparrowAtlas('Arrows');
			case 'strangerDanger':
		}
		if (inCharter)
			setGraphicSize(Std.int(width * 0.5));
		else
			setGraphicSize(Std.int(width * 0.7));

		for (i in 0...4)
		{
			animation.addByPrefix(dataColor[i], dataColor[i] + " alone", 1, false);
		}

		switch (noteData)
		{
			case 0:
				animation.play('purple');
			case 1:
				animation.play('blue');
			case 2:
				animation.play('green');
			case 3:
				animation.play('red');
		}
		// trace(noteData);
	}

	override public function update(elapsed:Float)
	{
		if (!inCharter)
		{
			if (y >= PlayState.receptors.members[noteData].y + hitZone[0] && y <= PlayState.receptors.members[noteData].y - hitZone[1])
				canBeHit = true;
			else
				canBeHit = false;
		}

		if (goodHit)
		{
			lastPosition = y;
			alpha = 0.5;
		}

		super.update(elapsed);
	}
}
