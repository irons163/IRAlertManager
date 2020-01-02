//
//  IRAlertLG.m
//  demo
//
//  Created by Phil on 2020/1/2.
//  Copyright © 2020 Phil. All rights reserved.
//

#import "IRAlertLG.h"
#import "Masonry.h"
#import <LGAlertView/LGAlertView.h>

#define BottomPaddingWithKeyboard 20

typedef void(^CommitClickBlock)(id inputData);

@implementation IRAlertLG {
    LGAlertView *alert;
    CommitClickBlock commitClickBlock;
    CGFloat originalPositionY;
    UIView *_customView;
}

- (instancetype)init {
    if(self = [super init]){
        
    }
    
    return self;
}

- (instancetype)initWithTitle:(nullable NSString *)title
               message:(nullable NSString *)message
                 style:(IRAlertLGStyle)style
         buttonActions:(nullable NSArray<IRAlertAction *> *)buttonActions
    cancelButtonAction:(nullable IRAlertAction *)cancelButtonAction
destructiveButtonAction:(nullable IRAlertAction *)destructiveButtonAction {
    if(self = [super init]){
        NSMutableArray<NSString *> * titles = [self titlesWithButtonActions:buttonActions];
        
        alert = [[LGAlertView alloc] initWithTitle:title message:message style:(LGAlertViewStyle)style buttonTitles:titles cancelButtonTitle:cancelButtonAction.title destructiveButtonTitle:destructiveButtonAction.title];
        
        [self setupButtonActions:buttonActions cancelButtonAction:cancelButtonAction destructiveButtonAction:destructiveButtonAction];
        [self registerForKeyboardNotifications];
    }
    
    return self;
}

- (NSMutableArray<NSString *> *)titlesWithButtonActions:(NSArray<IRAlertAction *> * _Nullable)buttonActions {
    NSMutableArray<NSString *> *titles = [NSMutableArray array];
    for (IRAlertAction *action in buttonActions) {
        [titles addObject:action.title];
    }
    return titles;
}

- (instancetype)initWithViewAndTitle:(NSString *)title message:(NSString *)message style:(IRAlertLGStyle)style view:(UIView *)view buttonActions:(NSArray<IRAlertAction *> *)buttonActions cancelButtonAction:(IRAlertAction *)cancelButtonAction destructiveButtonAction:(IRAlertAction *)destructiveButtonAction {
    
    
    if(self = [super init]){
        _customView = view;
        
        NSMutableArray<NSString *> * titles = [self titlesWithButtonActions:buttonActions];
        
        alert = [[LGAlertView alloc] initWithViewAndTitle:title message:message style:(LGAlertViewStyle)style view:view buttonTitles:titles cancelButtonTitle:cancelButtonAction.title destructiveButtonTitle:destructiveButtonAction.title];
        
        [self setupButtonActions:buttonActions cancelButtonAction:cancelButtonAction destructiveButtonAction:destructiveButtonAction];

        [self registerForKeyboardNotifications];
    }
    
    return self;
}

- (void)setupButtonActions:(NSArray<IRAlertAction *> * _Nullable)buttonActions cancelButtonAction:(IRAlertAction * _Nullable)cancelButtonAction destructiveButtonAction:(IRAlertAction * _Nullable)destructiveButtonAction {
    __weak IRAlertLG* wself = self;
    
    alert.actionHandler = ^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
        if(index >= buttonActions.count)
            return;
        
        IRAlertAction *action = [buttonActions objectAtIndex:index];
        action.handler(action);
    };
    
    alert.cancelHandler = ^(LGAlertView * _Nonnull alertView) {
        if (cancelButtonAction) {
            cancelButtonAction.handler(cancelButtonAction);
        }
    };
    
    alert.destructiveHandler = ^(LGAlertView * _Nonnull alertView) {
        if (destructiveButtonAction) {
            destructiveButtonAction.handler(destructiveButtonAction);
        }
    };
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setBlurWithBlurEffect:(UIBlurEffect *)blurEffect {
    [alert setCoverBlurEffect:blurEffect];
}

- (void)setBlurWithColor:(UIColor *)color {
    [alert setCoverColor:color];
}

- (void)setBlurWithAlpha:(CGFloat)alpha {
    [alert setCoverAlpha:alpha];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [alert setLayerCornerRadius:cornerRadius];
}

- (void)show {
    [alert showAnimated];
}

- (void)hide {
    __weak IRAlertLG* wself = self;
    [alert dismissAnimated:YES completionHandler:^{
        if(wself.dismissHandler)
            wself.dismissHandler();
    }];
}

#pragma mark - KeyboardNotifications
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    CGFloat bottomY = alert.innerView.frame.origin.y + alert.innerView.frame.size.height;
    CGFloat bottomDistanceToScreen = [UIScreen mainScreen].bounds.size.height - bottomY;
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat h = kbSize.height;
    if (bottomDistanceToScreen < h) {
        CGRect newFrame = alert.innerView.frame;
        originalPositionY = newFrame.origin.y;
        newFrame.origin.y = newFrame.origin.y - (h - bottomDistanceToScreen);
        alert.innerView.frame = newFrame;
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    CGRect newFrame = alert.innerView.frame;
    newFrame.origin.y = originalPositionY;
    alert.innerView.frame = newFrame;
}

@end
