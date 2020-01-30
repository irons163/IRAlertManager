//
//  IRAlert.h
//  IRAlertManager
//
//  Created by Phil on 2019/7/15.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IRAlertAction.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^IRDismissHandler)(void);

@interface IRAlert : NSObject

@property (nonatomic, copy) IRDismissHandler dismissHandler;
@property (readonly) NSMutableArray* actions;

- (void)setBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor;
- (void)setCornerRadius:(CGFloat)cornerRadius;
- (void)addAction:(IRAlertAction *)action;

@end

NS_ASSUME_NONNULL_END
