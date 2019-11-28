//
//  Utilities.m
//  IRAlertManager
//
//  Created by Phil on 2019/11/28.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedScreen;
}

+ (NSBundle *)getCurrentBundle {
    return [NSBundle bundleForClass:self];
}

@end
