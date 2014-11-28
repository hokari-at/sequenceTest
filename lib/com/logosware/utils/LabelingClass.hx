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
package com.logosware.utils;

	import flash.Lib;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ラベリングを行うクラスです
	 */
	extern class LabelingClass
	{
		private var _bmp:BitmapData;
		private var _minSize:UInt;
		private var _startColor:UInt;
		private var _pickedRects:Array<Dynamic> ;
		private var _pickedColor:Array<Dynamic> ;
		/**
		 * コンストラクタ
		 * @param bmp 入力画像(0x0, 0xFFFFFFFFでニ値化されたもの)
		 * @param minSize 画素として認める最低サイズ(ノイズ対策)
		 * @param startColor 塗り開始色
		 * @param isChangeOriginal 入力画像を実際に塗るかどうか 
		 **/
		public function Labeling(bmp:BitmapData, minSize:UInt = 10, startColor:UInt = 0xFFFFFFFE, isChangeOriginal:Bool = true):Void;
		/**
		 * ラベリングした結果得られた範囲の矩形情報を返します
		 * @return 矩形の配列
		 **/
		public function getRects():Array<Dynamic>;
		/**
		 * ラベリングした結果得られた範囲を塗った色情報を返します
		 * @return 色の配列
		 **/
		public function getColors():Array<Dynamic>;
		/**
		 * コア関数
		 **/
		private function _process():Void ;
		/**
		 * 次のpickcolor色の領域をfillcolor色に塗る。pickcolorが見つからなければfalseを返す
		 * @param bmp 画像
		 * @param pickcolor 次の色
		 * @param fillcolor 塗る色
		 * @return 目的の色があったかどうか
		 **/
		private function _paintNextLabel( bmp:BitmapData, pickcolor:UInt, fillcolor:UInt ):Bool;
	}