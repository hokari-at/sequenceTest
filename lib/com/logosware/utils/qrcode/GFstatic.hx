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

	/**
	 * ガロア体GF(2^w) w=4, 8 の計算に用いる定数
	 */
	extern class GFstatic
	{
		/**
		 * GF(2^4)計算用定数.
		 * _power2vector_4[指数] = 整数値 のように使います
		 */
		public static var _power2vector_4:Array<Dynamic>;
		/**
		 * GF(2^4)計算用定数.
		 * _power2vector_4[整数値] = 指数 のように使います
		 */
		public static var _vector2power_4:Array<Dynamic>;
		/**
		 * GF(2^8)計算用定数.
		 * _power2vector_8[指数] = 整数値 のように使います
		 */
		public static var _power2vector_8:Array<Dynamic>;
		/**
		 * GF(2^8)計算用定数.
		 * _power2vector_8[整数] = 指数 のように使います
		 */
		public static var _vector2power_8:Array<Dynamic>;
	}
