package ;

import flash.Lib;

import flash.display.Sprite;
import flash.display.Shape;
import flash.display.DisplayObjectContainer;
import flash.display.SimpleButton;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.Function;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import base.SceneBase;
import base.ButtonBase;
import base.TextBase;

/**
 * ...
 * @author A.H
 */
class SceneSecond extends SceneBase
{

	private var userName:String = "";
	private var userEtc:String = "";
	
	private var popContainer:DisplayObjectContainer = new Sprite();
	
	public function new() 
	{
		super();
		
		nextScene = new SceneThird();
	}

	override function init():Void {

		container.x = rectLeftBottom.x;
		container.y = rectLeftBottom.y;
		
		var buttonB:ButtonBase = new ButtonBase();
		var buttonOk:SimpleButton = buttonB.createButtonL();
		
		buttonOk.x = (tableWidth / 2) - (buttonOk.width / 2);
		buttonOk.y = (tableHeight / 2) + 50;
		
		buttonOk.addEventListener(MouseEvent.CLICK, onPopup);
		
		container.addChild(buttonOk);
		
		var textName:TextBase = new TextBase();
		var textNameField:TextField = textName.createText();
		textNameField.x = (tableWidth / 2) - (textNameField.width / 2);
		textNameField.y = (tableHeight / 2) - 100;

		textNameField.addEventListener(Event.CHANGE, writeUserName);
		container.addChild(textNameField);
		
		var textEtc:TextBase = new TextBase();
		var textEtcField:TextField = textEtc.createText();
		textEtcField.x = (tableWidth / 2) - (textEtcField.width / 2);
		textEtcField.y = (tableHeight / 2) - 40;
		
		textEtcField.addEventListener(Event.CHANGE, writeUserEtc);
		container.addChild(textEtcField);

	}
	
	public function onPopup(event:MouseEvent):Void
	{
		
		var blind:Shape = new Shape();
		blind.graphics.beginFill(0x000000);
		blind.graphics.drawRect(0, 0, tableWidth + 40, tableHeight + 20);
		blind.graphics.endFill();
		blind.alpha = 0.6;
		
		blind.x = (tableWidth / 2) - 20;
		blind.y = (tableHeight / 2) - (blind.height / 2);
		
		popContainer.addChild(blind);
		
		var textArea:TextBase = new TextBase();
		var textInputCheck:TextField = textArea.createTextArea();
		
		textInputCheck.text = "Please verify below !\n" + "Name : " + userName + "\n" + "Etc : " + userEtc + "\n" + "Are you sure ?";
		
		textInputCheck.x = (tableWidth) - (textInputCheck.width / 2);
		textInputCheck.y = 80;
		
		popContainer.addChild(textInputCheck);
		
		var buttonLeft:ButtonBase = new ButtonBase();
		var buttonOk:SimpleButton = buttonLeft.createButtonM();
		
		buttonOk.x = (tableWidth / 2) + ( buttonOk.width);
		buttonOk.y = (tableHeight / 2);

		buttonOk.addEventListener(MouseEvent.CLICK, ok);
		buttonOk.addEventListener(MouseEvent.CLICK, closeReady);
		popContainer.addChild(buttonOk);
		
		var buttonRight:ButtonBase = new ButtonBase();
		var buttonCancel:SimpleButton = buttonRight.createButtonM();
		
		buttonCancel.x = (tableWidth / 2) + ( buttonCancel.width * 3);
		buttonCancel.y = (tableHeight / 2);

		buttonCancel.addEventListener(MouseEvent.CLICK, cancel);
		popContainer.addChild(buttonCancel);
		
		Lib.current.addChild(popContainer);
	}
	
	
	public function writeUserName(event:Event):Void
	{
		userName = event.target.text;
		
	}
	
	public function writeUserEtc(event:Event):Void
	{
		userEtc = event.target.text;
	}
	
	public function ok(event:MouseEvent):Void {
		
		
		try
		{
			var fileStream:FileStream = new FileStream();
			
			var fileDir:File = File.applicationStorageDirectory;
			var fileTarget:File = fileDir.resolvePath("user.txt");
			
			fileStream.open(fileTarget, FileMode.WRITE);
			fileStream.writeUTFBytes(userName + "," + userEtc);
			fileStream.close();
			
			//記入確認に使用
			//fileStream.open(fileTarget, FileMode.READ);
			//var testTexts:Array<String> = fileStream.readUTFBytes(fileStream.bytesAvailable).split(",");
			//fileStream.close();
			//
			//for (i in 0 ... testTexts.length)
			//{
				//trace(testTexts[i]);
			//}			
		}
		catch(error:Dynamic)
		{
			trace("Expection : " + Std.string(error));
			var e:MouseEvent = new MouseEvent(MouseEvent.CLICK);
			cancel(e);
		}
		
		
		Lib.current.removeChild(popContainer);		
	}
		
	public function cancel(event:MouseEvent):Void {
		Lib.current.removeChild(popContainer);
	}
}