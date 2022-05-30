package _cool_Util;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class SongBox extends FlxTypedGroup<FlxSprite>
{
	var buttonBG:FlxSprite;
	var songText:FlxText;
	var thumbnail:FlxSprite;

	var isSelected:Bool = false;

	public var height:Float = 0;
	public var width:Float = 0;

	public var x:Float = 0;
	public var y:Float = 0;

	public var text:String;

	public function new(x:Float = 0, y:Float = 0, text:String = "unknown", textSize:Int = 16)
	{
		super();
		this.x = x;
		this.y = y;
		this.text = text;

		buttonBG = new FlxSprite(this.x, this.y);
		buttonBG.makeGraphic(30, 50, FlxColor.GRAY);
		add(buttonBG);

		this.height = buttonBG.height;
		this.width = buttonBG.width;

		songText = new FlxText(buttonBG.x + 5, buttonBG.y + 10, 0, text, textSize, false);
		add(songText);

		buttonBG.width = songText.width;
	}

	public function updateMembers()
	{
		for (sprite in members)
		{
			sprite.x = this.x;
			sprite.y = this.y;
		}
	}

	override public function update(elapsed:Float)
	{
		updateMembers();
		super.update(elapsed);
	}
}
