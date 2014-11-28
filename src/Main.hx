package ;


import flash.Lib;

import flash.display.Sprite;
import flash.display.Shape;
import flash.events.Event;

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

class Main extends Sprite
{
	private var fileStream:FileStream = new FileStream();
		
	private var appDir:File = File.applicationDirectory;
	private var strageDir:File = File.applicationStorageDirectory;
	
	private var txtOriginal:String = "";
	private var txtCheck:String = "";
	
	public function new() 
	{
		super();
		
		/**
		 * Entry point.
		 * New to AIR? Please read the readme.txt files *carefully*!
		 */
		
		var txtOriginal:String = "0";
		var txtCheck:String = "1";
		
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
			var tempScene:SceneBase = new SceneThird();
			Lib.current.addChild(tempScene.tableBase);
		}
		else
		{
			var tempScene:SceneBase = new SceneZero();
			Lib.current.addChild(tempScene.tableBase);
		}


	}
	
	static function main() 
	{
		Lib.current.addChild(new Main());
		
	}
	
}