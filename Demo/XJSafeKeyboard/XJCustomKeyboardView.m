//
//  XJCustomKeyboardView.m
//  Demo
//
//  Created by APPLE on 2021/6/7.
//  Copyright © 2021 XJ. All rights reserved.
//

#import "XJCustomKeyboardView.h"
#import"XJKeyboardCollectionViewCell.h"
#import "UITextField+XJSecurity.h"

@interface XJCustomKeyboardView () <UITextFieldDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

//是否大写
@property (nonatomic, assign) BOOL isUppercase;

//数字是否随机
@property (nonatomic, assign) BOOL isRandom;

//数字数据源
@property (nonatomic, copy) NSArray *numbers;

//字母数据源
@property (nonatomic, copy) NSArray *letters;

//特殊字符数据源
@property (nonatomic, copy) NSArray *specialLetters;

//数据源
@property (nonatomic, strong) NSMutableArray *dataSource;

//输入源
@property (nonatomic, weak) UITextField<UIKeyInput>* textField;

//限制长度
@property (nonatomic, assign) NSInteger length;

//当前键盘类型
@property (nonatomic, assign) XJCustomKeyboardType currentKeyboardType;

@end

@implementation XJCustomKeyboardView

#pragma mark - Init

- (void)dealloc {
    [self removeObserverForTextField];
}

- (instancetype)initWithView:(UIView<UIKeyInput> *)view
                keyboardType:(XJCustomKeyboardType)keyboardType
                      random:(BOOL)random
                       title:(NSString *)title {
    
    return [self initWithView:view keyboardType:keyboardType random:random title:title length:-1];
}

- (instancetype)initWithView:(UIView<UIKeyInput> *)view
                keyboardType:(XJCustomKeyboardType)keyboardType
                      random:(BOOL)random
                       title:(NSString *)title
                      length:(NSInteger)length {
    if (self = [super init]) {
        self.length = length;
        [view setValue:self forKey:@"inputView"];
        XJCustomInputAccessoryView *accessoryView =  [[XJCustomInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40) keyboardType:keyboardType];
        accessoryView.backgroundColor = KEYBOARD_BACKGROUND_COLOR;
        accessoryView.textLabel.text = title?title:@"安全键盘";
        __weak __typeof(self) wself = self;
        accessoryView.finishBlock = ^{
            [wself.textField resignFirstResponder];
        };
        accessoryView.changeTypeBlock = ^(XJCustomKeyboardType type) {
            [wself reloadKeyBoardViewWithType:type];
        };
        [view setValue:accessoryView forKey:@"inputAccessoryView"];
        _isRandom = random;
        _textField = (UITextField *)view;
        _textField.delegate = self;
//        _textField.isPlaintext = NO;

        CGFloat delta_x = 0.0;
        if ([self isIPhoneXSeries]) {
            delta_x = 34.0;
        }
        self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), SEPERATE_SPACE*5+ITEM_HEIGHT*4+delta_x);
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
        _collectionView =[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = KEYBOARD_BACKGROUND_COLOR;
        _collectionView.delegate =self;
        _collectionView.dataSource =self;
        [_collectionView registerClass:[XJKeyboardCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([XJKeyboardCollectionViewCell class])];
        _dataSource =[NSMutableArray array];
        self.isUppercase = NO;
        
        if (self.isRandom) {
            _numbers = [self randomArray:[self stringToArrAy:NUMBERS]];
            _letters = [self randomArray:[self stringToArrAy:_isUppercase?[LETTERS uppercaseString]:LETTERS]];
        }else{
            _numbers = [self stringToArrAy:NUMBERS];
            _letters = [self stringToArrAy:_isUppercase?[LETTERS uppercaseString]:LETTERS];
        }
        _specialLetters = [self stringToArrAy:SPECIAL_CHARACTERS];
        ///
        [self reloadKeyBoardViewWithType:keyboardType];
        
        [self addObserverForTextField];
    }
    return self;
}

+ (instancetype)configWithView:(UIView<UIKeyInput> *)view
                  keyboardType:(XJCustomKeyboardType)keyboardType
                        random:(BOOL)random {
    
    return [[XJCustomKeyboardView alloc] initWithView:view
                                         keyboardType:keyboardType
                                               random:random
                                                title:TITLE_STRING
                                               length:-1];
}

+ (instancetype)configWithView:(UIView<UIKeyInput> *)view
                  keyboardType:(XJCustomKeyboardType)keyboardType
                        random:(BOOL)random
                         title:(NSString *)title {
    
    return [[XJCustomKeyboardView alloc] initWithView:view
                                         keyboardType:keyboardType
                                               random:random
                                                title:title
                                               length:-1];
}

+ (instancetype)configWithView:(UIView<UIKeyInput> *)view
                  keyboardType:(XJCustomKeyboardType)keyboardType
                        random:(BOOL)random
                         title:(NSString *)title
                        length:(NSInteger)length {
    
    return [[XJCustomKeyboardView alloc] initWithView:view
                                         keyboardType:keyboardType
                                               random:random
                                                title:title
                                               length:length];
}

#pragma mark - Setter & Getter
- (void)setKeyboardBackgroundColor:(UIColor *)cuBackgroundColor {
    _keyboardBackgroundColor = cuBackgroundColor;
    UIView *view = self.textField.inputAccessoryView;
    view.backgroundColor = cuBackgroundColor;
    self.collectionView.backgroundColor = cuBackgroundColor;
}

- (void)setKeyboardItemColor:(UIColor *)cuItemColor {
    _keyboardItemColor = cuItemColor;
    [self.collectionView reloadData];
}
- (void)setCuItemDarkColor:(UIColor *)cuItemDarkColor {
    _cuItemDarkColor = cuItemDarkColor;
    [self.collectionView reloadData];
}

- (void)setCuKeyColor:(UIColor *)cuKeyColor {
    _cuKeyColor = cuKeyColor;
    [self.collectionView reloadData];
}

- (void)setCuKeyFont:(UIFont *)cuKeyFont {
    _cuKeyFont = cuKeyFont;
    [self.collectionView reloadData];
}

- (void)setAccessoryColor:(UIColor *)accessoryColor {
    _accessoryColor = accessoryColor;
    XJCustomInputAccessoryView *view = (XJCustomInputAccessoryView*)self.textField.inputAccessoryView;
    view.textLabel.textColor = accessoryColor;
    [view.finishButton setTitleColor:accessoryColor forState:UIControlStateNormal];
    [view.changeTypeButton setTitleColor:accessoryColor forState:UIControlStateNormal];
}

- (void)setAccessoryFont:(UIFont *)accessoryFont {
    _accessoryFont = accessoryFont;
    XJCustomInputAccessoryView *view = (XJCustomInputAccessoryView*)self.textField.inputAccessoryView;
    view.textLabel.font = accessoryFont;
    view.finishButton.titleLabel.font = accessoryFont;
    view.changeTypeButton.titleLabel.font = accessoryFont;
}

#pragma mark - Custom Method
- (void)reloadKeyBoardViewWithType:(XJCustomKeyboardType)keyboardType{
    if (keyboardType & XJCustomKeyboardTypeNumber) {
        self.currentKeyboardType = XJCustomKeyboardTypeNumber;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_numbers];
        [_dataSource insertObject:POT atIndex:9];
        [_dataSource addObject:DELETE_STRING];
        [_collectionView reloadData];
    } else if (keyboardType & XJCustomKeyboardTypeLetter) {
        self.currentKeyboardType = XJCustomKeyboardTypeLetter;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_numbers];
        [_dataSource addObjectsFromArray:_letters];
        [_dataSource insertObject:ALT atIndex:20];
        [_dataSource insertObject:SPACE_STRING atIndex:30];
        [_dataSource addObject:DELETE_STRING];
        [_collectionView reloadData];
    } else if (keyboardType & XJCustomKeyboardTypeCharacters) {
        self.currentKeyboardType = XJCustomKeyboardTypeCharacters;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_specialLetters];
        [_dataSource addObject:SPACE_STRING];
        [_dataSource addObject:DELETE_STRING];
        [_collectionView reloadData];
    } else if (keyboardType & XJCustomKeyboardTypeDigital) {
        self.currentKeyboardType = XJCustomKeyboardTypeNumber;
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:_numbers];
        [_dataSource insertObject:PLACE_PLACER atIndex:9];
        [_dataSource addObject:DELETE_STRING];
        [_collectionView reloadData];
    }
}

- (NSArray *)stringToArrAy:(NSString *)string {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger idx = 0; idx < string.length; idx++) {
        [array addObject:[string substringWithRange:NSMakeRange(idx, 1)]];
    }
    
    return array;
}

///随机排序
- (NSArray *)randomArray:(NSArray *)array {
    if (!array || ![array isKindOfClass:[NSArray class]]) {
        return array;
    }
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        NSInteger seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    
    return result;
}

- (BOOL)isIPhoneXSeries {
    static BOOL isiPhoneX = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
#if TARGET_IPHONE_SIMULATOR
        // 获取模拟器所对应的 device model
        NSString *model = NSProcessInfo.processInfo.environment[@"SIMULATOR_MODEL_IDENTIFIER"];
#else
        // 获取真机设备的 device model
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *model = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
#endif
        // 判断 device model 是否为 "iPhone10,3" 和 "iPhone10,6" 或者以 "iPhone11," 开头
        // 如果是，就认为是 iPhone X
        isiPhoneX = ([model isEqualToString:@"iPhone10,3"] ||
                    [model isEqualToString:@"iPhone10,6"] ||
                    [model hasPrefix:@"iPhone11,"] ||
                    ([model hasPrefix:@"iPhone12,"] && ![model isEqualToString:@"iPhone12,8"]) ||
                     [model hasPrefix:@"iPhone13,"]);
    });
    return isiPhoneX;
}

#pragma mark - Notifycation
- (void)addObserverForTextField {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(textChange:)
     name:UITextFieldTextDidChangeNotification
     object:nil];
}

- (void)removeObserverForTextField {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
}

#pragma mark - UITextFieldTextDidChangeNotification
- (void)textChange:(NSNotification *)nofify {
    UITextField *textField = [nofify object];
    if (textField != self.textField) {
        return;
    }
    if (self.textField.text.length == 0) {
        self.textField.securityText = @"";
    }

    NSLog(@"self.textField.securityText = %@", self.textField.securityText);
    [self.textField refreshTextField];
}


#pragma mark - UIInputViewAudioFeedback
- (BOOL)enableInputClicksWhenVisible {
    
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"");
    return YES;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [[UIDevice currentDevice] playInputClick];
    NSString *text = self.dataSource[indexPath.item];
    if ([text isEqualToString:ALT]) {
        self.isUppercase = !self.isUppercase;
        [collectionView reloadData];
    } else if ([text isEqualToString:SPACE_STRING]) {
        NSMutableString *temp = [NSMutableString stringWithString:self.textField.securityText];
        [temp appendString:WHITESPACE];
        self.textField.securityText = [NSString stringWithString:temp];
        if (self.textField.isPlainText) {
            [self.textField insertText:WHITESPACE];
        } else {
            [self.textField insertText:ASTERISK];
        }
    } else if ([text isEqualToString:DELETE_STRING]) {
        if ([self.textField hasText]) {
            NSMutableString *temp = [NSMutableString stringWithString:self.textField.securityText];
            self.textField.securityText = [temp substringToIndex:temp.length - 1];
            [self.textField deleteBackward];
        }
    } else if ([text isEqualToString:PLACE_PLACER]) {
        
    } else {
        if (self.textField.securityText.length == self.length) {
            return;
        }
        NSString *x = self.dataSource[indexPath.item];
        if (self.isUppercase) {
            x = [x uppercaseString];
        }
        NSMutableString *temp = [NSMutableString stringWithString:self.textField.securityText];
        [temp appendString:x];
        self.textField.securityText = [NSString stringWithString:temp];
        if (self.textField.isPlainText) {
            [self.textField insertText:x];
        } else {
            [self.textField insertText:ASTERISK];
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"XJKeyboardCollectionViewCell";
    XJKeyboardCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (self.cuKeyColor) {
        
        cell.textLabel.textColor = self.cuKeyColor;
    }
    if (self.cuKeyFont) {
        
        cell.textLabel.font = self.cuKeyFont;
    }
    NSString *text = cell.textLabel.text = self.dataSource[indexPath.item];
    if ([text isEqualToString:ALT] ||
        [text isEqualToString:SPACE_STRING] ||
        [text isEqualToString:DELETE_STRING] ||
        [text isEqualToString:PLACE_PLACER]) {
        
        cell.backgroundColor = self.cuItemDarkColor ? self.cuItemDarkColor : KEYBOARD_SPECIAL_ITEM_DARK_COLOR;
    } else {
        
        cell.backgroundColor = self.keyboardItemColor ? self.keyboardItemColor : KEYBOARD_ITEM_COLOR;
        if (self.isUppercase &&
            (self.currentKeyboardType & XJCustomKeyboardTypeLetter)) {
            
            cell.textLabel.text = [text uppercaseString];
        }
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.dataSource[indexPath.item];
    if (self.currentKeyboardType & XJCustomKeyboardTypeLetter) {
        if ([text isEqualToString:SPACE_STRING] || [text isEqualToString:DELETE_STRING]) {
            
            return CGSizeMake(LETTER_ITEM_WIDTH +SEPERATE_SPACE + (LETTER_ITEM_WIDTH-SEPERATE_SPACE)/2, ITEM_HEIGHT);
        } else {
            
            return CGSizeMake(LETTER_ITEM_WIDTH, ITEM_HEIGHT);
        }
    } else if (self.currentKeyboardType & XJCustomKeyboardTypeCharacters) {
        if ([text isEqualToString:DELETE_STRING]) {
            
            return CGSizeMake(LETTER_ITEM_WIDTH +SEPERATE_SPACE + (LETTER_ITEM_WIDTH-SEPERATE_SPACE)/2, ITEM_HEIGHT);
        } else if ([text isEqualToString:SPACE_STRING]) {
            
            return CGSizeMake((LETTER_ITEM_WIDTH+SEPERATE_SPACE)*6 +(LETTER_ITEM_WIDTH-SEPERATE_SPACE)/2, ITEM_HEIGHT);
        } else {
            
            return CGSizeMake(LETTER_ITEM_WIDTH, ITEM_HEIGHT);
        }
    } else if ((self.currentKeyboardType & XJCustomKeyboardTypeNumber) ||
               (self.currentKeyboardType & XJCustomKeyboardTypeDigital)) {
        
        return CGSizeMake(NUMBER_ITEM_WIDTH, ITEM_HEIGHT);
    }
    
    return CGSizeMake(LETTER_ITEM_WIDTH, ITEM_HEIGHT);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(SEPERATE_SPACE, SEPERATE_SPACE, SEPERATE_SPACE, SEPERATE_SPACE);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return SEPERATE_SPACE;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return SEPERATE_SPACE - 0.001;
}

@end
