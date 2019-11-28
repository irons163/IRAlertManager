//
//  IRAlert.m
//  IRAlertManager
//
//  Created by Phil on 2019/7/15.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRAlert+Package.h"

@implementation IRAlert

- (instancetype)init {
    if (self = [super init]) {
        _actions = [NSMutableArray array];
    }
    return self;
}

- (void)addAction:(IRAlertAction *)action {
    [_actions addObject:action];
}

@end
