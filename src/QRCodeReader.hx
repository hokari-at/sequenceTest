package  ;

import flash.Lib;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.SimpleButton;
import flash.display.SpreadMethod;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.filters.BlurFilter;
import flash.filters.DropShadowFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.media.Camera;
import flash.media.Video;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.Timer;
import flash.Vector;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import com.logosware.event.QRdecoderEvent;
import com.logosware.event.QRreaderEvent;
import com.logosware.utils.qrcode.QRCodeDetecter;
import com.logosware.utils.qrcode.GetQRimage;
import com.logosware.utils.qrcode.QRdecode;

import base.SceneBase;
import base.ButtonBase;

/**
 * ...
 * @author A.H
 */
class QRCodeReader extends Sprite
{

	public static var SRC_SIZE:Int = 320;
	public static var STAGE_SIZE:Int = 350;

	private var getQRimage:GetQRimage;
	private var qrDecode:QRdecode = new QRdecode();

	private var errorView:Sprite;
	private var errorText:TextField = new TextField();
	
	private var startView:Sprite;
	
	private var cameraView:Sprite;
	private var camera:Camera;
	private var video:Video = new Video(SRC_SIZE, SRC_SIZE);
	private var freezeImage:Bitmap;
	private var blue:Sprite = new Sprite();
	private var red:Sprite = new Sprite();
	private var blurFilter:BlurFilter = new BlurFilter();
	
	//private var resultView:Sprite;
	private var textArea:TextField = new TextField();
	private var cameraTimer:Timer = new Timer(2000);

	private var textArray:Array<String> = ["", "", ""];
	
	private var appDir:File = File.applicationDirectory;
	private var strageDir:File = File.applicationStorageDirectory;
	
	private var txtOriginal:String = "0";
	private var txtCheck:String = "1";

	public function new() 
	{
		super();
		
		/**
		 * Entry point.
		 * New to AIR? Please read the readme.txt files *carefully*!
		 */
		Lib.current.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.align = StageAlign.TOP_LEFT;
		
		errorView = buildErrorView();
		errorView.x = (400 / 2) - (errorView.width / 2);
		errorView.y = 30;
		
		cameraTimer.addEventListener(TimerEvent.TIMER, getCamera);
		cameraTimer.start();
		getCamera();
	}
	
		
	static function main() 
	{
		Lib.current.addChild(new QRCodeReader());
	}
	
	private function getCamera(e:TimerEvent = null):Void{
		camera = Camera.getCamera();
		this.graphics.clear();
		if ( camera == null ) {
			this.addChild( errorView );
		} else {
			cameraTimer.stop();
			if ( errorView.parent == this ) {
				this.removeChild(errorView);
			}
			start();
		}
	}
	/**
	 * スタートボタンを表示
	 */
	private function start():Void {
		startView = buildStartView();
		startView.x = (400 / 2) - (startView.width / 2);
		startView.y = 30;
		
		this.addChild( startView );
		
		startView.addEventListener(MouseEvent.CLICK, onStart);
	}
	/**
	 * 画像解析クラスにカメラ画像を渡し、解析完了イベントを監視します
	 */
	private function onStart(e:MouseEvent):Void {
		cameraView = buildCameraView();	
		cameraView.x = (400 / 2) - (cameraView.width / 2);
		cameraView.y = 30;
		
		//resultView = buildResultView();
		//resultView.x = (400 / 2) - (resultView.width / 2);
		//resultView.y = 30;
		
		this.addChild( cameraView );
		//this.addChild( resultView );
		this.removeChild( startView );
		//resultView.visible = false;
		
		getQRimage = new GetQRimage(video);
		getQRimage.addEventListener(QRreaderEvent.QR_IMAGE_READ_COMPLETE, onQrImageReadComplete);
		qrDecode.addEventListener(QRdecoderEvent.QR_DECODE_COMPLETE, onQrDecodeComplete);
		redTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onRedTimer );
		this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	/**
	 * エラー画面を作成
	 */
	private function buildErrorView():Sprite {
		var sprite:Sprite = new Sprite();
		errorText.autoSize = TextFieldAutoSize.LEFT;
		errorText.text = "no camera detected.";
		errorText.x = 0.5 * (STAGE_SIZE - errorText.width);
		errorText.y = 0.5 * (STAGE_SIZE - errorText.height);
		errorText.border = true;
		errorText.background = true;
		sprite.graphics.lineStyle(0);
		
		var pathCommand:Vector<Int> = new Vector<Int>();
		pathCommand[0] = 1;
		pathCommand[1] = 2;
		pathCommand[2] = 2;
		pathCommand[3] = 2;
		pathCommand[4] = 2;
		pathCommand[5] = 2;
		pathCommand[6] = 1;
		pathCommand[7] = 2;
		
		var pathDate:Vector<Float> = new Vector<Float>();
		pathDate[0] = 5;
		pathDate[1] = 5;
		pathDate[2] = STAGE_SIZE-5;
		pathDate[3] = 5;
		pathDate[4] = STAGE_SIZE-5;
		pathDate[5] = STAGE_SIZE-5;
		pathDate[6] = 5;
		pathDate[7] = STAGE_SIZE-5;
		pathDate[8] = 5;
		pathDate[9] = 5;
		pathDate[10] = STAGE_SIZE-5;
		pathDate[11] = STAGE_SIZE-5;
		pathDate[12] = 5;
		pathDate[13] = STAGE_SIZE-5;
		pathDate[14] = STAGE_SIZE-5;
		pathDate[15] = 5;
		
		sprite.graphics.drawPath( pathCommand, pathDate);
		//sprite.graphics.drawRect( 5,5,345,345);
		sprite.addChild(errorText);
		return sprite;
	}
	/**
	 * 開始ボタンを作成
	 */
	private function buildStartView():Sprite {
		var sprite:Sprite = new Sprite();
		sprite.graphics.beginGradientFill(GradientType.LINEAR, [0xCCCCCC, 0xAAAAAA], [1.0, 1.0], [0, 255], new Matrix(0, 0.03, -0.03, 0, 0, 15));
		sprite.graphics.lineStyle(2);
		sprite.graphics.drawRoundRect(0, 0, 200, 30, 5);
		
		var btnText:TextField = new TextField();
		btnText.autoSize = TextFieldAutoSize.LEFT;
		btnText.text = "Click here to start!";
		btnText.setTextFormat(new TextFormat(null, 16, null, true));
		btnText.selectable = false;
		
		btnText.x = 0.5 * (sprite.width - btnText.width);
		btnText.y = 0.5 * (sprite.height - btnText.height);
		
		sprite.addChild(btnText);
		sprite.mouseChildren = false;
		sprite.buttonMode = true;
		
		sprite.x = 0.5 * (STAGE_SIZE - sprite.width);
		sprite.y = 0.5 * (STAGE_SIZE - sprite.height);
		
		return sprite;
	}
	/**
	 * カメラの表示部分を作成
	 */
	private function buildCameraView():Sprite {
		camera.setQuality(0, 100);
		camera.setMode(SRC_SIZE, SRC_SIZE, 24, true );
		video.attachCamera( camera );
			
		var sprite:Sprite = new Sprite();
		sprite.graphics.beginGradientFill(GradientType.LINEAR, [0xCCCCCC, 0x999999], [1.0, 1.0], [0, 255], new Matrix(0, 0.1, -0.1, 0, 0, 150));
		sprite.graphics.drawRoundRect(0, 0, SRC_SIZE+30, SRC_SIZE+30, 20);
		
		var videoHolder:Sprite = new Sprite();
		videoHolder.addChild( video );
		videoHolder.x = videoHolder.y = 15;
		
		freezeImage = new Bitmap(new BitmapData(SRC_SIZE, SRC_SIZE));
		videoHolder.addChild( freezeImage );
		freezeImage.visible = false;
		
		var pathCommand:Vector<Int> = new Vector<Int>();
		pathCommand[0] = 1;
		pathCommand[1] = 2;
		pathCommand[2] = 2;
		pathCommand[3] = 1;
		pathCommand[4] = 2;
		pathCommand[5] = 2;
		pathCommand[6] = 1;
		pathCommand[7] = 2;
		pathCommand[8] = 2;
		pathCommand[9] = 1;
		pathCommand[10] = 2;
		pathCommand[11] = 2;
		
		var pathDate:Vector<Float> = new Vector<Float>();
		pathDate[0] = 30;
		pathDate[1] = 60;
		pathDate[2] = 30;
		pathDate[3] = 30;
		pathDate[4] = 60;
		pathDate[5] = 30;
		pathDate[6] = 290;
		pathDate[7] = 60;
		pathDate[8] = 290;
		pathDate[9] = 30;
		pathDate[10] = 260;
		pathDate[11] = 30;
		pathDate[12] = 30;
		pathDate[13] = 260;
		pathDate[14] = 30;
		pathDate[15] = 290;
		pathDate[16] = 60;
		pathDate[17] = 290;
		pathDate[18] = 290;
		pathDate[19] = 260;
		pathDate[20] = 290;
		pathDate[21] = 290;
		pathDate[22] = 260;
		pathDate[23] = 290;
		
		red.graphics.lineStyle(2, 0xFF0000);
		red.graphics.drawPath(pathCommand, pathDate);
		//red.graphics.drawRect( 30,30,260,260);
		
		blue.graphics.lineStyle(2, 0x0000FF);
		blue.graphics.drawPath(pathCommand, pathDate);
		//blue.graphics.drawRect( 30,30,260,260);

		sprite.addChild( videoHolder );
		sprite.addChild( red );
		sprite.addChild( blue );
		blue.alpha = 0;
		red.x = red.y = 15;
		blue.x = blue.y = 15;
		return sprite;
	}
	/**
	 * 結果表示用Sprite作成
	 */
	//private function buildResultView():Sprite {
		//var sprite:Sprite = new Sprite();
		//sprite.graphics.beginGradientFill(GradientType.LINEAR, [0xDDDDEE, 0xBBBBCC], [0.9, 0.9], [0, 255], new Matrix(0, 0.1, -0.1, 0, 0, 150));
		//sprite.graphics.drawRoundRect(0, 0, 280, 280, 20);
		//
		//sprite.addChild( textArea );
		//textArea.width = 250;
		//textArea.height = 200;
		//textArea.wordWrap = true;
		//textArea.multiline = true;
		//textArea.border = true;
		//textArea.background = true;
		//textArea.backgroundColor = 0xFFFFFF;
		//textArea.x = textArea.y = 15;
		//
		//var btnText:TextField = new TextField();
		//btnText.autoSize = TextFieldAutoSize.LEFT;
		//btnText.text = "CLOSE";
		//btnText.selectable = false;
		//var btnSprite:Sprite = new Sprite();
		//btnSprite.addChild(btnText);
		//btnSprite.graphics.lineStyle(1);
		//btnSprite.graphics.beginGradientFill(GradientType.LINEAR, [0xEEEEEE, 0xCCCCCC], [0.9, 0.9], [0, 255], new Matrix(0, 0.01, -0.01, 0, 0, 10));
		//btnSprite.graphics.drawRoundRect(0, 0, 80, 20, 8);
		//btnText.x = 0.5 * (btnSprite.width - btnText.width);
		//btnText.y = 0.5 * (btnSprite.height - btnText.height);
		//btnSprite.x = 0.5 * ( 280 - 80 );
		//btnSprite.y = 240;
		//btnSprite.buttonMode = true;
		//btnSprite.mouseChildren = false;
		//btnSprite.addEventListener(MouseEvent.CLICK, onClose);
		//
		//sprite.addChild( btnSprite );
		//sprite.addChild( textArea );
		//
		//sprite.x = sprite.y = 35;
		//sprite.filters = [new DropShadowFilter(4.0,45,0,0.875)];
		//
		//return sprite;
	//}
	/**
	 * 解析を毎フレーム行う
	 */
		private function onEnterFrame(e: Event):Void{
		if( camera.currentFPS > 0 ){
			getQRimage.process();
		}
	}
	/**
	 * QRコードを発見したらデコーダーに渡す
	 */
	private function onQrImageReadComplete(e: QRreaderEvent):Void{
		qrDecode.setQR(e.data); // QRreaderEvent.data: QRコード配列
		qrDecode.startDecode(); // デコード開始
	}
	/**
	 * デコードが完了したら結果テキストを表示する
	 */
	private function onQrDecodeComplete(e: QRdecoderEvent):Void {
		blue.alpha = 1.0;
		redTimer.reset();
		redTimer.start();
		textArray.shift();
		textArray.push( e.data );  // QRdecoderEvent.data: 解析文字列
		if ( textArray[0] == textArray[1] && textArray[1] == textArray[2] ) {
			txtCheck = e.data;
			//textArea.htmlText = e.data;
			cameraView.filters = [blurFilter];
			redTimer.stop();
			freezeImage.bitmapData.draw(video);
			freezeImage.visible = true;
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			//resultView.visible = true;
			
			var fileStream:FileStream = new FileStream();
			
			var fileTargetOriginal:File = appDir.resolvePath("qrcode.txt");
			fileStream.open(fileTargetOriginal, FileMode.READ);
			txtOriginal = fileStream.readUTFBytes(fileStream.bytesAvailable);
			fileStream.close();
			
			var strageDir:File = File.applicationStorageDirectory;
			var fileTargetCheck:File = strageDir.resolvePath("qrcodeCheck.txt");
			
			if (txtOriginal == txtCheck)
			{
				fileStream.open(fileTargetCheck, FileMode.WRITE);
				fileStream.writeUTFBytes(txtCheck);
				fileStream.close();
				
				var e:MouseEvent = new MouseEvent(MouseEvent.CLICK);
				onClose(e);
			}
			else
			{
				var e:MouseEvent = new MouseEvent(MouseEvent.CLICK);
				onClose(e);
			}
		}
	}
	/**
	 * 結果を削除
	 */
	private function onClose(e: MouseEvent):Void {
		textArray = ["", "", ""];
		freezeImage.visible = false;
		redTimer.start();
		this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		cameraView.filters = [];
		//resultView.visible = false;
	}
	private var redTimer:Timer = new Timer(400, 1);
	/**
	 * ガイドの色を戻す
	 */
	private function onRedTimer(e:TimerEvent):Void {
		blue.alpha = 0;
	}
	
}