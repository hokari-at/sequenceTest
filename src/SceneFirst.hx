package  ;

import flash.Lib;

import flash.display.Sprite;
import flash.display.Shape;
import flash.display.DisplayObjectContainer;
import flash.display.SimpleButton;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.MouseEvent;

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
class SceneFirst extends SceneBase
{
	
	private var fileStream:FileStream = new FileStream();
	
	private var appDir:File = File.applicationDirectory;
	private var strageDir:File = File.applicationStorageDirectory;
	
	private var txtOriginal:String = "0";
	private var txtCheck:String = "1";

	public function new() 
	{
		super();
		
		nextScene = new SceneSecond();
	}
	
	override function init():Void {

		container.x = rectLeftBottom.x;
		container.y = rectLeftBottom.y;
		
			//var buttonA:ButtonBase = new ButtonBase();
			//var buttonNext:SimpleButton = buttonA.createButtonL();
			//
			//buttonNext.x = (tableWidth / 2) - (buttonNext.width / 2);
			//buttonNext.y = (tableHeight / 2) + 150;
			//
			//buttonNext.addEventListener(MouseEvent.CLICK, closeReady);
			//container.addChild(buttonNext);	
		
		var buttonB:ButtonBase = new ButtonBase();
		var buttonCheck:SimpleButton = buttonB.createButtonM();
		
		buttonCheck.x = (tableWidth / 2) - (buttonCheck.width / 2);
		buttonCheck.y = (tableHeight / 2) + 110;
		
		buttonCheck.addEventListener(MouseEvent.CLICK, dummyCheck);
		
		container.addChild(buttonCheck);
		
		//var btnText:TextField = new TextField();
		//btnText.autoSize = TextFieldAutoSize.CENTER;
		//btnText.text = "Dummy";
		//btnText.setTextFormat(new TextFormat(null, 12, null, true));
		//btnText.selectable = false;	
		//
		//btnText.x = (tableWidth / 2) - (btnText.width / 2);
		//btnText.y = (tableHeight / 2) + 110;	
		//
		//container.addChild(btnText);
		
		container.addEventListener(Event.ENTER_FRAME , checkCode);
		
		var qrReader:QRCodeReader = new QRCodeReader();
		
		container.addChild(qrReader);

	}
	
	public function checkCode(event:Event)
	{
		
		var appDir:File = File.applicationDirectory;
		var fileTargetOriginal:File = appDir.resolvePath("qrcode.txt");
		fileStream.open(fileTargetOriginal, FileMode.READ);
		txtOriginal = fileStream.readUTFBytes(fileStream.bytesAvailable);
		fileStream.close();
		
		var strageDir:File = File.applicationStorageDirectory;
		var fileTargetCheck:File = strageDir.resolvePath("qrcodeCheck.txt");
		
		if (fileTargetCheck.exists)
		{
			fileStream.open(fileTargetCheck, FileMode.READ);
			txtCheck = fileStream.readUTFBytes(fileStream.bytesAvailable);
			fileStream.close();
		}
		else
		{
			
		}
		
		if (txtOriginal == txtCheck)
		{
			var buttonA:ButtonBase = new ButtonBase();
			var buttonNext:SimpleButton = buttonA.createButtonL();
			
			buttonNext.x = (tableWidth / 2) - (buttonNext.width / 2);
			buttonNext.y = (tableHeight / 2) + 150;
			
			buttonNext.addEventListener(MouseEvent.CLICK, closeReady);
			container.addChild(buttonNext);
			
			container.removeEventListener(Event.ENTER_FRAME , checkCode);
		}
		else
		{

		}

	}
	
	public function dummyCheck(event:Event)
	{
		var strageDir:File = File.applicationStorageDirectory;
		var fileTargetCheck:File = strageDir.resolvePath("qrcodeCheck.txt");
		
		fileStream.open(fileTargetCheck, FileMode.WRITE);
		fileStream.writeUTFBytes("tonight's gonna be a good night.");
		fileStream.close();
	}
}