//
//  IRAlertManager.h
//  IRAlertManager
//
//  Created by Phil on 2019/7/15.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IRAlert.h"
#import "IRAlertAction.h"

//! Project version number for IRAlertManager.
FOUNDATION_EXPORT double IRAlertManagerVersionNumber;

//! Project version string for IRAlertManager.
FOUNDATION_EXPORT const unsigned char IRAlertManagerVersionString[];

NS_ASSUME_NONNULL_BEGIN

typedef float(^addAnimationEngineBlock)(UIView *view);

@interface IRAlertManager : NSObject

- (id) init UNAVAILABLE_ATTRIBUTE;
+ (id) new UNAVAILABLE_ATTRIBUTE;

+ (id)sharedInstance;

- (void)showAlert:(IRAlert*)alert;
- (void)hideAlert:(IRAlert*)alert;

- (void)showLoadingViewWithTarget:(UIViewController *)target;
- (void)showLoadingViewWithTarget:(UIViewController *)target backgroundImage:(UIImage *)backgroundImage;
- (void)hideLoadingViewWithTarget:(UIViewController *)target;
- (BOOL)isLoadingViewShowingWithTarget:(UIViewController *)target;

@end

NS_ASSUME_NONNULL_END

#import <IRAlertManager/IRAlert.h>
#import <IRAlertManager/IRAlertSystem.h>
