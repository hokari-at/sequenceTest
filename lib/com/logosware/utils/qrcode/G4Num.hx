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
	import com.logosware.utils.QRcode.GFstatic;
	/**
	 * GF(2^4)を扱うためのクラス
	 **/
	extern class G4Num {
		private var _vector:uint;
		private var _power:int;
		/**
		 * コンストラクタ
		 * @param power 指数
		 **/
		public function G4Num(power:int):Void;
		/**
		 * 指数を指定する
		 * @param power 指数
		 **/
		public function setPower( power:int ):Void ;
		/**
		 * 整数値を指定する
		 * @param vector 整数値
		 **/
		public function setVector( vector:uint ):Void ;
		/**
		 * 整数値を取得する
		 * @param 整数値
		 **/
		public function getVector():UInt ;
		/**
		 * 指数を取得する
		 * @param 指数
		 **/
		public function getPower():Int ;
		/**
		 * 足し算を行う。整数値同士のxorを取る。
		 * @param other 足す対象となるG4Numインスタンス
		 * @param 計算結果
		 **/
		public function plus( other:G4Num ):G4Num ;
		/**
		 * 乗算を行う。指数同士の足し算を行う。
		 * @param other かける対象となるG4Numインスタンス
		 * @param 計算結果
		 **/
		public function multiply( other:G4Num ):G4Num ;
	}
