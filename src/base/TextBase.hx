package base;

import flash.display.Sprite;
import flash.display.Shape;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldType;

import base.SceneBase;
import base.ButtonBase;
import base.TextBase;

/**
 * ...
 * @author A.H
 */
class TextBase
{

	public function new() 
	{
		
	}
	
	public function createLabel():TextField
	{
		var txt:TextField = new TextField();
		
		txt.text = "";
		txt.type = TextFieldType.DYNAMIC;
		txt.width = 200;
		txt.height = 25;
		//txt.x = (tableWidth / 2) - (txt.width / 2);
		//txt.y = (tableHeight / 3) + txt.height;
		txt.border = false;
		//txt.borderColor = 0x44CCCC;
		txt.background = false;
		//txt.backgroundColor = 0x88CCCC;
		
		return txt;
	}
	
	public function createText():TextField
	{
		var txt:TextField = new TextField();
		
		txt.text = "";
		txt.type = TextFieldType.INPUT;
		txt.width = 200;
		txt.height = 25;
		//txt.x = (tableWidth / 2) - (txt.width / 2);
		//txt.y = (tableHeight / 3) + txt.height;
		txt.border = true;
		txt.borderColor = 0x44CCCC;
		txt.background = true;
		txt.backgroundColor = 0x88CCCC;
		
		return txt;
	}
	
	public function createTextArea():TextField
	{
		var txt:TextField = new TextField();
		
		txt.text = "";
		txt.type = TextFieldType.INPUT;
		txt.width = 250;
		txt.height = 200;
		//txt.x = (tableWidth / 2) - (txt.width / 2);
		//txt.y = (tableHeight / 3) + txt.height;
		txt.border = true;
		txt.borderColor = 0xDDDDDD;
		txt.background = true;
		txt.backgroundColor = 0xEEEEEE;
		
		txt.multiline = true;
		
		return txt;
	}
	
}