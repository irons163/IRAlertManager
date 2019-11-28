//
//  IRAlertSystem.h
//  IRAlertManager
//
//  Created by Phil on 2019/11/26.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <IRAlertManager/IRAlertManager.h>

typedef NS_ENUM(NSInteger, IRAlertControllerStyle) {
    IRAlertControllerStyleActionSheet = 0,
    IRAlertControllerStyleAlert
};

NS_ASSUME_NONNULL_BEGIN

@interface IRAlertSystem : IRAlert

- (instancetype)initWithStyle:(IRAlertControllerStyle)style;

@property (readonly) UIAlertController *dialog;
@property (nonatomic) IRAlertControllerStyle style;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *message;

@end

NS_ASSUME_NONNULL_END
