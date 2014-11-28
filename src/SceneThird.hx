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
import flash.geom.Rectangle;
import flash.media.StageWebView;

import base.SceneBase;
import base.ButtonBase;
import base.TextBase;

/**
 * ...
 * @author A.H
 */
class SceneThird extends SceneBase
{

	public function new() 
	{
		super();
		
		//nextScene = new SceneMap();
	}
	
	override function init():Void {
		
		container.x = rectLeftBottom.x;
		container.y = rectLeftBottom.y;
		
		var web_view:StageWebView;
		
		var target_url:String = "http://showcase.movatoss.jp/~hokari/htmlMap.html";
		
		web_view = new StageWebView();
		web_view.stage = container.stage;
		web_view.viewPort = new Rectangle( tableWidth / 2 , rectLeftBottom.y + 5 , tableWidth , rectLeftTop.y - 22 );
		
		web_view.loadURL(target_url);
		
		//trace(container.x);
		
		//dispatchEvent(new Event("MAP"));

		
	}
	
}