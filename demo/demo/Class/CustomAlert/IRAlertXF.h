//
//  IRAlertXF.h
//  demo
//
//  Created by Phil on 2019/11/25.
//  Copyright © 2019 Phil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IRAlertManager/IRAlertManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface IRAlertXF : IRAlert

- (instancetype)initWithCustomView:(UIView *)customView;

@end

NS_ASSUME_NONNULL_END
