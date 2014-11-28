package base;

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
class SceneBase extends Sprite
{
	
	public var tableBase:DisplayObjectContainer = new Sprite();
	public var container:DisplayObjectContainer = new Sprite();
	
	public var tableWidth:Float = 400;
	public var tableHeight:Float = 600;
	
	private var cornerSpan:Int = 20;
	private var cornerColer:UInt = 0x666666;
	
	private var rectLeftTop:Shape = new Shape();
	private var rectLeftBottom:Shape = new Shape();
	private var rectRightTop:Shape = new Shape();
	private var rectRightBottom:Shape = new Shape();
	
	private var openCountX:Float = 4;
	private var openCountY:Float = 5;
	private var closeCountX:Float = 4;
	private var closeCountY:Float = 5;

	private var nextScene:SceneBase;
	private var currentScene:SceneBase = this;
	
	public function new() 
	{
		super();
		
		tableBase.opaqueBackground = 0x999999;
		tableBase.x = tableWidth / 2;
		
		rectLeftTop = createRect(cornerSpan, cornerSpan, cornerColer);
		
		rectLeftTop.x = (tableWidth / 2);
		rectLeftTop.y = (tableHeight / 2) - rectLeftTop.height;
		
		rectLeftBottom = createRect(cornerSpan, cornerSpan, cornerColer);
		
		rectLeftBottom.x = (tableWidth / 2);
		rectLeftBottom.y = (tableHeight / 2);	
		
		rectRightTop = createRect(cornerSpan, cornerSpan, cornerColer);

		rectRightTop.x = (tableWidth / 2) - rectRightTop.width;
		rectRightTop.y = (tableHeight / 2) - rectRightTop.height;
		
		rectRightBottom = createRect(cornerSpan, cornerSpan, cornerColer);
		
		rectRightBottom.x = (tableWidth / 2) - rectRightBottom.width;
		rectRightBottom.y = (tableHeight / 2);
		
		tableBase.addChild(rectLeftTop);		
		tableBase.addChild(rectLeftBottom);
		tableBase.addChild(rectRightTop);		
		tableBase.addChild(rectRightBottom);
		
		tableBase.addChildAt(container, 0);
		
		tableBase.addEventListener(Event.ADDED, openReady);
	}
	
	private function init():Void {
	
	}

	public static function createRect(rectWidth:Int , rectHeight:Int , rectColor:UInt):Shape {
		var rect:Shape = new Shape();

		rect.graphics.beginFill(rectColor);
		//rect.graphics.lineStyle(0, 0x999999);
		rect.graphics.drawRect(0, 0, rectWidth,rectHeight);
		rect.graphics.endFill();
		
		
		return rect;
	}

	public function openReady(event:Event)
	{
		tableBase.addEventListener(Event.ENTER_FRAME, openTable);
	}
	
	
	public function openTable(event:Event)
	{
		
		if(tableBase.width >= tableWidth)
		{
			tableBase.removeEventListener(Event.ADDED, openReady);	
			tableBase.removeEventListener(Event.ENTER_FRAME, openTable);
			
			init();
			
			openCountX = 4;
			openCountY = 5;

		}
		else
		{
			rectLeftTop.x -= openCountX;
			rectLeftTop.y += openCountY;
			
			rectLeftBottom.x -= openCountX;
			rectLeftBottom.y -= openCountY;
		
			rectRightTop.x += openCountX;
			rectRightTop.y += openCountY;
			
			rectRightBottom.x += openCountX;
			rectRightBottom.y -= openCountY;
			
			openCountX += 0.75;
			openCountY += 1.0;

		}
		
	}
	
	public function closeTable(event:Event):Void
	{
		
		
		if(rectLeftTop.y < rectRightBottom.y + rectRightBottom.width)
		{
			tableBase.removeEventListener(Event.ENTER_FRAME, closeTable);
			
			Lib.current.addChildAt(nextScene.tableBase,0);
			
			closeCountX = 4;
			closeCountY = 5;
			
			Lib.current.removeChild(tableBase);
		}
		else
		{
			rectLeftTop.x += closeCountX;
			rectLeftTop.y -= closeCountY;
			
			rectLeftBottom.x += closeCountX;
			rectLeftBottom.y += closeCountY;
		
			rectRightTop.x -= closeCountX;
			rectRightTop.y -= closeCountY;
			
			rectRightBottom.x -= closeCountX;
			rectRightBottom.y += closeCountY;
			
			closeCountX += 0.5;
			closeCountY += 0.75;

		}
	
	}

	public function closeReady(event:MouseEvent)
	{
		tableBase.addEventListener(Event.ENTER_FRAME, closeTable);
		tableBase.removeChild(container);

	}
	
	public function goNextScene(event:Event):Void
	{
		
		tableBase.removeEventListener(Event.COMPLETE , goNextScene);
		

	}
}