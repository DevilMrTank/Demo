//
//  XJTextFieldConst.h
//  Demo
//
//  Created by APPLE on 2021/6/7.
//  Copyright © 2021 XJ. All rights reserved.
//

#ifndef XJTextFieldConst_h
#define XJTextFieldConst_h

#define ASTERISK @"•"
#define WHITESPACE @" "

#define KEYBOARD_TYPE_LETTER @"Abc"
#define KEYBOARD_TYPE_CHARACTER @"#+="
#define KEYBOARD_TYPE_NUMBER @"12."
#define KEYBOARD_TYPE_DIGITAL @"123"

#define NUMBERS @"1234567890"
#define LETTERS @"qwertyuiopasdfghjklzxcvbnm"
#define SPECIAL_CHARACTERS @"!@#$%^&*()'\"=_:;?~|`+-\\/[]{},.<>"
#define POT @"."
#define ALT @"alt"
#define PLACE_PLACER @""
#define SPACE_STRING NSLocalizedStringFromTable(@"空格", @"XJCustomKeyboardString", nil)
#define DELETE_STRING NSLocalizedStringFromTable(@"删除", @"XJCustomKeyboardString", nil)
#define FINISH_STRING NSLocalizedStringFromTable(@"完成", @"XJCustomKeyboardString", nil)
#define TITLE_STRING NSLocalizedStringFromTable(@"安全键盘", @"XJCustomKeyboardString", nil)
#define SEPERATE_SPACE 3.0
#define LETTER_ITEM_WIDTH ((CGRectGetWidth([UIScreen mainScreen].bounds)-SEPERATE_SPACE*11)/10.0)
#define NUMBER_ITEM_WIDTH ((CGRectGetWidth([UIScreen mainScreen].bounds)-SEPERATE_SPACE*4)/3)
#define ITEM_HEIGHT (LETTER_ITEM_WIDTH*4/3)
#define KEYBOARD_BACKGROUND_COLOR [UIColor grayColor]
#define KEYBOARD_ITEM_COLOR [UIColor whiteColor]
#define KEYBOARD_SPECIAL_ITEM_DARK_COLOR [UIColor lightGrayColor]
#define KEYBOARD_KEY_COLOR [UIColor blackColor]

typedef NS_OPTIONS(NSUInteger, XJCustomKeyboardType) {
    XJCustomKeyboardTypeLetter = 1 << 0, //字母
    XJCustomKeyboardTypeCharacters = 1 << 1, //符号
    XJCustomKeyboardTypeNumber = 1 << 2, //数字
    XJCustomKeyboardTypeDigital = 1 << 3, //带小数
    XJCustomKeyboardTypeAll = XJCustomKeyboardTypeLetter | XJCustomKeyboardTypeCharacters | XJCustomKeyboardTypeNumber | XJCustomKeyboardTypeDigital
};

#endif /* XJTextFieldConst_h */
