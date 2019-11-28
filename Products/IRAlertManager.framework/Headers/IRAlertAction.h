//
//  IRAlertAction.h
//  IRAlertManager
//
//  Created by Phil on 2019/7/15.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRAlertAction;

typedef NS_ENUM(NSInteger, IRAlertActionStyle) {
    IRAlertActionStyleDefault = 0,
    IRAlertActionStyleCancel,
    IRAlertActionStyleDestructive
};

typedef void(^IRAlertActionHandler)(IRAlertAction * _Nonnull action);

NS_ASSUME_NONNULL_BEGIN

@interface IRAlertAction : NSObject

@property IRAlertActionStyle style;
@property NSString *title;
@property (nonatomic, copy) IRAlertActionHandler handler;

@end

NS_ASSUME_NONNULL_END
