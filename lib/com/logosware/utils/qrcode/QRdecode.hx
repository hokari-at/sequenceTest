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

	import flash.Lib;

	import com.logosware.event.QRdecoderEvent;
	
	import flash.events.EventDispatcher;
	import flash.system.System;
	import flash.text.TextField;
	import flash.utils.*;
	//import flash.utils.unescapeMultiByte;

	/**
	 * QRコードをデコードして文字列を抽出するクラスです
	 * @author Kenichi UENO
	 **/
	extern class QRdecode extends EventDispatcher {
		private var _xorPattern:Array<Dynamic>;
		private var _fixed:Array<Dynamic>;
		private var _qr:Array<Dynamic>;
//		private var _textObj:TextField = new TextField();
		private var _qrVersion:UInt;
		public function QRdecode() :Void;
		/**
		 * 解析したいQRコードを格納する関数
		 * @param qr QRコードのビットパターン二次元配列
		 */
		public function setQR( qr:Array<Dynamic> ):Void ;
		/**
		 * setQRで格納したQRコードのデコードを行う関数
		 * @param retObj 結果イベントに含ませたいオブジェクト
		 * @eventType QRdecoderEvent.QR_DECODE_COMPLETE
		 */
		public function startDecode(retObj:Object = null):Void ;
		/**
		 * リードソロモンで8bitずつ読み取る関数
		 */
		private function _RS8bit( __dataArray:Array<Dynamic>, __codeNum:UInt, __errorNum:UInt, __snum:UInt ):Void ;
		/**
		 * 行列式を計算する
		 * @param 行列
		 * @param 行列サイズ
		 **/
		private function _calcDet( __Dat:Array<Dynamic>, __size:UInt ):Int ;
		/**
		 * 下三角行列を作る
		 */
		private function _reduceToLU(__a:Array<Dynamic>, __num:UInt ):Void ;
		/**
		 * バイナリを文字列に変換する
		 * @param バイナリデータ
		 */
		private function _readData ( __dataCode:Array<Dynamic> ):Array<Dynamic> ;
		/**
		 * 32ビットのデータを文字に直す
		 * @param バイナリデータ
		 */
		private function _Hex2String( __hex:UInt ):String ;
		/**
		 * N文字分の文字列を読み込む
		 * @param バイナリデータ
		 * @param データ長
		 */
		private function _readNstr( __bin:Array<Dynamic>, __length:UInt ):String ;
		/**
		 * N文字分の数字を読み込む
		 * @param バイナリデータ
		 * @param データ長
		 */
		private function _readNnumber( __bin:Array<Dynamic>, __length:UInt ):UInt ;
		/**
		 * 16進数の配列を2進数の配列に直す
		 * @param 16進数パターン
		 */
		private function _Hex2Bin( __hex:Array<Dynamic> ):Array<Dynamic> ;
		/**
		 * リードソロモン解析
		 * @param 解析データ
		 * @param 形式情報
		 */
		private function _ReedSolomon( __data:Array<Dynamic>, __type:Array<Dynamic> ):Array<Dynamic> ;
		/**
		 * 1バイト分の情報を読み込む
		 * @param 情報ビット列
		 */
		private function _readByteData( __byte:Array<Dynamic> ):UInt ;
		/**
		 * 情報のバイト列を読み取る
		 * @param QRコードビットパターン
		 */
		private function _getWords( __qr:Array<Dynamic> ):Array<Dynamic> ;
		/**
		 * QRコードのマスクを解除する関数
		 * @param 形式情報
		 */
		private function _unmask( __typeData:Array<Dynamic> ):Array<Dynamic> ;
		/**
		 * 機能パターンの範囲をバージョン別に指定する関数
		 */
		private function _makeFixed():Void ;
		/**
		 * 座標(x,y)のビットパターンを返す関数
		 */
		private function _getQR(x:UInt, y:UInt):UInt ;
		/**
		 * 機能パターン情報を返す関数
		 */
		private function _isFixed(x:UInt, y:UInt):UInt ;
		/**
		 * 形式情報をデコードする関数
		 */
		private function _decode15_5():Array<Dynamic> ;
		
	}
