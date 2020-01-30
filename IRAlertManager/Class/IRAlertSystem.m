//
//  IRAlertSystem.m
//  IRAlertManager
//
//  Created by Phil on 2019/11/26.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRAlertSystem.h"
#import <UIKit/UIKit.h>
#import "UIImageEffects.h"
#import "Utilities.h"

@implementation IRAlertSystem {
    CGFloat originalPositionY;
    UIImageView *maskView;
}

@synthesize dialog;

- (instancetype)init {
    if(self = [super init]){
        dialog = [[UIAlertController alloc] init];
    }
    return self;
}

- (instancetype)initWithStyle:(IRAlertControllerStyle)style {
    if(self = [super init]){
        dialog = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:style];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    dialog.title = _title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    dialog.message = message;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor {
    UIImage *bgImage = [UIImageEffects
                        imageByApplyingBlurToImage:[Utilities captureScreen]
                        withRadius:blurRadius
                        tintColor:tintColor
                        saturationDeltaFactor:saturationDeltaFactor
                        maskImage:nil];
    
    if(!maskView) {
        maskView = [UIImageView new];
        [dialog.view insertSubview:maskView atIndex:0];

        maskView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint *topConstraint =[NSLayoutConstraint
                                            constraintWithItem:maskView
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:dialog.view
                                            attribute:NSLayoutAttributeTop
                                            multiplier:1.0f
                                            constant:0.f];
        
        NSLayoutConstraint *bottomConstraint =[NSLayoutConstraint
                                               constraintWithItem:maskView
                                               attribute:NSLayoutAttributeBottom
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:dialog.view
                                               attribute:NSLayoutAttributeBottom
                                               multiplier:1.0f
                                               constant:0.f];
        NSLayoutConstraint *leadingConstraint =[NSLayoutConstraint
                                                constraintWithItem:maskView
                                                attribute:NSLayoutAttributeLeading
                                                relatedBy:NSLayoutRelationEqual
                                                toItem:dialog.view
                                                attribute:NSLayoutAttributeLeading
                                                multiplier:1.0f
                                                constant:0.f];
        NSLayoutConstraint *trailingConstraint =[NSLayoutConstraint
                                                 constraintWithItem:maskView
                                                 attribute:NSLayoutAttributeTrailing
                                                 relatedBy:NSLayoutRelationEqual
                                                 toItem:dialog.view
                                                 attribute:NSLayoutAttributeTrailing
                                                 multiplier:1.0f
                                                 constant:0.f];
        
        topConstraint.active = YES;
        bottomConstraint.active = YES;
        leadingConstraint.active = YES;
        trailingConstraint.active = YES;
    }
    
    maskView.image = bgImage;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [dialog.view.layer setCornerRadius:cornerRadius];
}

- (void)show {
    for (IRAlertAction *iraction in self.actions) {
        [dialog addAction:[UIAlertAction actionWithTitle:iraction.title style:iraction.style handler:^(UIAlertAction * _Nonnull action) {
            iraction.handler(iraction);
        }]];
    }
    [self.topMostController presentViewController:dialog animated:YES completion:nil];
}

- (UIViewController*)topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    return topController;
}

- (void)hide {
    [self.actions removeAllObjects];
    [dialog dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - KeyboardNotifications
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    CGFloat bottomY = dialog.view.frame.origin.y + dialog.view.frame.size.height;
    CGFloat bottomDistanceToScreen = [UIScreen mainScreen].bounds.size.height - bottomY;
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat h = kbSize.height;
    if (bottomDistanceToScreen < h) {
        CGRect newFrame = dialog.view.frame;
        originalPositionY = newFrame.origin.y;
        newFrame.origin.y = newFrame.origin.y - (h - bottomDistanceToScreen);
        dialog.view.frame = newFrame;
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    CGRect newFrame = dialog.view.frame;
    newFrame.origin.y = originalPositionY;
    dialog.view.frame = newFrame;
}

@end
