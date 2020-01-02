//
//  IRAlertLG.h
//  demo
//
//  Created by Phil on 2020/1/2.
//  Copyright © 2020 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IRAlertManager/IRAlertManager.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IRAlertLGStyle) {
    IRAlertLGStyleAlert       = 0,
    IRAlertLGStyleActionSheet = 1
};

@interface IRAlertLG : IRAlert

- (id) init UNAVAILABLE_ATTRIBUTE;
+ (id) new UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithTitle:(nullable NSString *)title
               message:(nullable NSString *)message
                 style:(IRAlertLGStyle)style
         buttonActions:(nullable NSArray<IRAlertAction *> *)buttonActions
    cancelButtonAction:(nullable IRAlertAction *)cancelButtonAction
destructiveButtonAction:(nullable IRAlertAction *)destructiveButtonAction;

- (instancetype)initWithViewAndTitle:(nullable NSString *)title
               message:(nullable NSString *)message
                 style:(IRAlertLGStyle)style
                  view:(nullable UIView *)view
          buttonActions:(nullable NSArray<IRAlertAction *> *)buttonActions
     cancelButtonAction:(nullable IRAlertAction *)cancelButtonAction
destructiveButtonAction:(nullable IRAlertAction *)destructiveButtonAction;

- (void)setBlurWithBlurEffect:(UIBlurEffect *)blurEffect;
- (void)setBlurWithColor:(UIColor *)color;
- (void)setBlurWithAlpha:(CGFloat)alpha;

- (void)addAction:(IRAlertAction *)action UNAVAILABLE_ATTRIBUTE;
- (void)setBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
