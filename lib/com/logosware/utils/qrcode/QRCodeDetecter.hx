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

	import com.logosware.utils.LabelingClass;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	//import flash.utils.getTimer;
	import flash.utils.*;
	
	/**
	 * @author UENO Kenichi
	 */
	extern class QRCodeDetecter extends Sprite
	{
		private var image:DisplayObject;
		private var bd:BitmapData;
		private var bd2:BitmapData;
		private var IMAGE_RECT:Rectangle;
		private var ORIGIN_POINT:Point;
		private var threshold:UInt;
		private var grayConst:Array<Dynamic> ;
		/**
		 * 画像からQRコードを見つけ出します
		 * @param	imageSource
		 */
		public function QRCodeDetecter(imageSource:DisplayObject) :Void;
		/**
		 * 見つかったQRコードの位置情報を返します
		 * @return マーカー配列
		 * 	[
		 * 		{
		 * 			image:BitmapData,
		 * 			borderColors:[
		 * 				0: uint color of topleft marker
		 * 				1: uint color of topright marker
		 * 				2: uint color of bottomleft marker
		 * 			],
		 * 			originalLocation:[
		 * 				0: Rectangle of topleft marker
		 * 				1: Rectangle of topright marker
		 * 				2: Rectangle of bottomleft marker
		 * 			]
		 * 		}
		 * 		...
		 * 	]
		 */
		public function detect():Array<Dynamic> ;
		private function _clipCodes( bd:BitmapData, codes:Array<Dynamic>):Array<Dynamic> ;
		/**
		 * マーカーの候補をピックアップする
		 * @param	bmp ラベリング済みの画像
		 * @param	rectArray 矩形情報
		 * @param	colorArray 矩形の色情報
		 * @return 候補の配列
		 */
		private function _searchBorders(bmp:BitmapData, rectArray:Array<Dynamic>, colorArray:Array<Dynamic>):Array<Dynamic> ;
		/**
		 * 直角関係にあるマーカーを探します
		 * @param	borders 候補の配列
		 * @return
		 */
		private function _searchCode( borders:Array<Dynamic> ):Array<Dynamic> ;
	}
