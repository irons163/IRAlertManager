//
//  IRAlertXF.m
//  demo
//
//  Created by Phil on 2019/11/25.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRAlertXF.h"

//#import "Alert+Package.h"
//#import "AlertXF.h"
#import "XFDialogFrame.h"
#import "XFDialogOptionButton.h"
#import "Masonry.h"

#define BottomPaddingWithKeyboard 20

typedef void(^CommitClickBlock)(id inputData);

@interface CustomXFDialogFrame : XFDialogOptionButton

@end

@implementation CustomXFDialogFrame

- (void)setCustomView:(UIView *)customView {
    [super setCustomView:customView];
    
    [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.customView.superview);
        make.width.mas_equalTo(self.customView.bounds.size.width);
    }];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

@end

@implementation IRAlertXF {
    XFDialogFrame *dialog;
    CommitClickBlock commitClickBlock;
    CGFloat originalPositionY;
    XFDialogOptionButton *buttons;
    UIView *_customView;
}

- (instancetype)init {
    if(self = [super init]){
        
    }
    
    return self;
}

-(instancetype)initWithCustomView:(UIView*)customView{
    if(self = [super init]){
        [self registerForKeyboardNotifications];
        
        _customView = customView;
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor {
    [dialog.maskView setBlurWithRadius:blurRadius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor];
    [dialog.maskView setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [dialog.layer setCornerRadius:cornerRadius];
}

- (void)show {
//    [dialog.customView addSubview:buttons.customView];
//    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.left.right.top.equalTo(self->dialog.customView);
//    }];
    [dialog showWithAnimationBlock:nil];
}

- (void)hide {
    [dialog endEditing:YES];
    [dialog hideWithAnimationBlock:nil];
}

- (void)addAction:(IRAlertAction *)action {
    [super addAction:action];
    
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *textColors = [NSMutableArray array];
    for (IRAlertAction *action in self.actions) {
        [titles addObject:action.title];
        switch (action.style) {
            case IRAlertActionStyleDefault:
                [textColors addObject:[UIColor blackColor]];
                break;
            case IRAlertActionStyleCancel:
                [textColors addObject:[UIColor systemRedColor]];
                break;
            case IRAlertActionStyleDestructive:
                [textColors addObject:[UIColor systemBlueColor]];
                break;
        }
    }
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    [attrs setObject:titles forKey:XFDialogOptionTextList];
    [attrs setObject:textColors forKey:XFDialogOptionTextColorList];
    
//    buttons = [XFDialogOptionButton dialogWithTitle:@"a" attrs:attrs commitCallBack:^(id inputData) {
//        for (IRAlertAction *action in self.actions) {
//            if ([action.title isEqualToString:inputData]) {
//                action.handler(action);
//            }
//        }
//    }];
    
    if (dialog) {
        [dialog hideWithAnimationBlock:nil];
        dialog = nil;
    }
    
    __weak IRAlertXF* wself = self;
    commitClickBlock = ^(id inputData) {
        for (IRAlertAction *action in wself.actions) {
            if (action.handler) {
                action.handler(action);
            }
        }
    };
    
    [attrs setObject:@YES forKey:XFDialogOptionCancelDisable];
    [attrs setObject:@YES forKey:XFDialogEnableBlurEffect];
    
    dialog = [CustomXFDialogFrame dialogWithCustomView:_customView maskView:[XFMaskView dialogMaskViewWithBackColor:[UIColor blueColor] alpha:1.0f] attrs:attrs commitCallBack:^(id inputData) {
//                                      self->commitClickBlock(inputData);
        if ([action.title isEqualToString:inputData]) {
            action.handler(action);
        } else {
            self->commitClickBlock(inputData);
        }
    }];
    
    [dialog setCancelCallBack:^{
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
    CGFloat bottomY = dialog.frame.origin.y + dialog.frame.size.height;
    CGFloat bottomDistanceToScreen = [UIScreen mainScreen].bounds.size.height - bottomY - BottomPaddingWithKeyboard;
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat h = kbSize.height;
    if (bottomDistanceToScreen < h) {
        CGRect newFrame = dialog.frame;
        originalPositionY = newFrame.origin.y;
        newFrame.origin.y = newFrame.origin.y - (h - bottomDistanceToScreen);
//        dialog.frame = newFrame;
        [dialog mas_updateConstraints:^(MASConstraintMaker *make) {
            if(self->dialog.superview)
                make.centerY.equalTo(self->dialog.superview).mas_offset((newFrame.origin.y - self->originalPositionY)/2);
        }];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if(originalPositionY == 0)
        return;
//    CGRect newFrame = dialog.frame;
//    newFrame.origin.y = originalPositionY;
//    dialog.frame = newFrame;
    [dialog mas_updateConstraints:^(MASConstraintMaker *make) {
        if(self->dialog.superview)
            make.centerY.equalTo(self->dialog.superview).mas_offset((self->originalPositionY - dialog.frame.origin.y)/2);
    }];
}

@end

