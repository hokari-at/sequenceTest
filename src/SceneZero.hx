package  ;

import flash.Lib;

import flash.display.Sprite;
import flash.display.Shape;
import flash.display.DisplayObjectContainer;
import flash.display.SimpleButton;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.events.Event;
import flash.events.MouseEvent;

import base.SceneBase;
import base.ButtonBase;
import base.TextBase;

/**
 * ...
 * @author A.H
 */
class SceneZero extends SceneBase
{

	public function new() 
	{
		super();
		
		nextScene = new SceneFirst();
	}
	
	override function init():Void {
		
		var buttonA:ButtonBase = new ButtonBase();
		var buttonNext:SimpleButton = buttonA.createButtonL();
		
		buttonNext.x = (tableWidth / 2) - (buttonNext.width / 2);
		buttonNext.y = (tableHeight / 2) + 180;
		
		buttonNext.addEventListener(MouseEvent.CLICK, closeReady);
		container.addChild(buttonNext);
		


	}
}