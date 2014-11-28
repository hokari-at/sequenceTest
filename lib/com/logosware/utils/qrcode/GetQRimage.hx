/**************************************************************************
* LOGOSWARE Class Library.
*
* Copyright 2009 (c) LOGOSWARE (http://www.logosware.com) All rights reserved.
*
*
* This program is free software; you can redistribute it and/or modify it under
* the terms of the GNU General Public License as published by the Free Software
* Foundation; either version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along with
* this program; if not, write to the Free Software Foundation, Inc., 59 Temple
* Place, Suite 330, Boston, MA 02111-1307 USA
*
**************************************************************************/ 
package com.logosware.utils.qrcode;

	import com.logosware.event.QRreaderEvent;
	import com.logosware.utils.LabelingClass;
	
	import flash.display.*;
	import flash.events.EventDispatcher;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.*;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Object;

	/**
	 * 主にカメラ画像からQRコードを切り出すためのクラスです.
	 * 画像上にあるVersion 1～10のQRコードを0,1からなる2次元配列に整形して返します
	 * @author Kenichi UENO
	 **/
	extern class GetQRimage extends EventDispatcher
	{
		private var _wid:UInt;
		private var _hgt:UInt;
		private var _minVersion:UInt; // サポートする最低バージョン
		private var _maxVersion:UInt ; // サポートする最高バージョン
		
		private var _imageSource:DisplayObject;
		private var _resultImage:BitmapData;
		private var _resultArray:Array<Dynamic>;
		private var _results:Array<Dynamic>;
		private static var _origin:Point;
		private var detecter:QRCodeDetecter;

		/**
		 * コンストラクタ.
		 * @param tempMC QRコード描画元のSpriteインスタンス
		 **/
		public function GetQRimage(source:DisplayObject):Void;
// debug code
//		private var bmp:Bitmap;

		/**
		 * 読み取りを実行します
		 * @eventType QRreaderEvent.QR_IMAGE_READ_COMPLETE
		 */
		public function process():Void ;
		/**
		 * 近辺の平均の明るさを取得する
		 * @param	x
		 * @param	y
		 * @param	size
		 * @return
		 */
		private function _getAverage( bmpData:BitmapData, x:Int, y:Int, size:Int ):UInt ;
		/**
		 * QRコードのビット情報を二次元配列化する
		 * @param bmpData 画像
		 * @param qrInfo QRコード情報オブジェクト
		 * @param ビットパターン配列
		 */
		private function _getGrid( bmpData:BitmapData, qrInfo:Object ):Array<Dynamic> ;
		/**
		 * QRコードのバージョンを判別する
		 * @param bmp 画像
		 * @param QRコード情報オブジェクト
		 */
		private function _getVersion( bmp:BitmapData, tlColor:UInt, trColor:UInt, blColor:UInt ):Object ;
	}	

