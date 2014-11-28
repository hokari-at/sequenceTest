package base;

import flash.desktop.InteractiveIcon;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.SimpleButton;

import base.SceneBase;
import base.ButtonBase;
import base.TextBase;

/**
 * ...
 * @author A.H
 */
class ButtonBase extends Sprite
{
	private var buttonWidthL:Int = 120;
	private var buttonHeightL:Int = 40;
	private var buttonWidthM:Int = 80;
	private var buttonHeightM:Int = 30;
	
	public function new() 
	{
		super();
		
	}
	
	public function createButtonL():SimpleButton {
		var button:SimpleButton = new SimpleButton();
		
		var shapeUp:Shape = createRoundRect(buttonWidthL, buttonHeightL, 0x99CCCC);
		var shapeOver:Shape = createRoundRect(buttonWidthL, buttonHeightL, 0x77CCCC);
		var shapeDown:Shape = createRoundRect(buttonWidthL, buttonHeightL, 0x55CCCC);

		button.upState = shapeUp;
		button.overState = shapeOver;
		button.hitTestState = shapeDown;
		button.downState =  shapeDown;
		
		return button;
	}
	
	public function createButtonM():SimpleButton {
		var button:SimpleButton = new SimpleButton();
		
		var shapeUp:Shape = createRoundRect(buttonWidthM, buttonHeightM, 0x99CCCC);
		var shapeOver:Shape = createRoundRect(buttonWidthM, buttonHeightM, 0x77CCCC);
		var shapeDown:Shape = createRoundRect(buttonWidthM, buttonHeightM, 0x55CCCC);

		button.upState = shapeUp;
		button.overState = shapeOver;
		button.hitTestState = shapeDown;
		button.downState =  shapeDown;
		
		return button;
	}
	
	private function createRoundRect(rectWidth:Int , rectHeight:Int , rectColor:UInt):Shape
	{
		var roundRect:Shape = new Shape();
		
		roundRect.graphics.beginFill(rectColor);
		//rect.graphics.lineStyle(0, 0x999999);
		roundRect.graphics.drawRoundRect(0, 0, rectWidth , rectHeight,rectWidth / 20 , rectHeight / 20);
		roundRect.graphics.endFill();
		
		return roundRect;
	}
}