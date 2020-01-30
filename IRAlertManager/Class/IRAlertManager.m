//
//  IRAlertManager.m
//  IRAlertManager
//
//  Created by Phil on 2019/7/15.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRAlertManager.h"
#import "IRAlertLoadingViewController.h"
#import "IRAlert+Package.h"
#import "Utilities.h"

@implementation IRAlertManager {
    NSMutableDictionary* loadingViewDictionary;
}


+ (id)sharedInstance {
    static IRAlertManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if ((self = [super init])) {
        loadingViewDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)showAlert:(IRAlert *)alert {
    [alert show];
}

- (void)hideAlert:(IRAlert *)alert {
    [alert hide];
}

- (void)showLoadingViewWithTarget:(UIViewController *)target {
    [self showLoadingViewWithTarget:target backgroundImage:[Utilities captureScreen]];
}

- (void)showLoadingViewWithTarget:(UIViewController *)target backgroundImage:(UIImage *)backgroundImage {
    if (![target isKindOfClass:[UIViewController class]]) {
        return;
    }
    if ([self isLoadingViewShowingWithTarget:target]) {
        return;
    }
    IRAlertLoadingViewController* loadingView = [[IRAlertLoadingViewController alloc] initWithNibName:@"IRAlertLoadingViewController" bundle:[Utilities getCurrentBundle]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        __block BOOL viewHasAppear = NO;
        while (true) {
            dispatch_async(dispatch_get_main_queue(), ^{
                viewHasAppear = (target.isViewLoaded && target.view.window && !target.isMovingFromParentViewController);
            });
            if (target == nil || target.isMovingToParentViewController || viewHasAppear) {
                break;
            }
#ifndef __OPTIMIZE__
            NSLog(@"Wait view show");
#endif
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (loadingView) {
                loadingView.backgroundImage = backgroundImage;
                if (target.navigationController &&
                    !target.navigationController.navigationBarHidden &&
                    !target.tabBarController)
                {
                    [target presentViewController:loadingView animated:NO completion:nil];
                }else{
                    [target.view addSubview:loadingView.view];
                }
                self->loadingViewDictionary[[NSValue valueWithNonretainedObject:target]] = loadingView;
            }
        });
    });
}

- (void)hideLoadingViewWithTarget:(UIViewController *)target {
    IRAlertLoadingViewController* loadingView = loadingViewDictionary[[NSValue valueWithNonretainedObject:target]];
    if (loadingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (loadingView.presentingViewController) {
                [loadingView dismissViewControllerAnimated:NO completion:nil];
            }else{
                [loadingView.view removeFromSuperview];
            }
            [self->loadingViewDictionary removeObjectForKey:[NSValue valueWithNonretainedObject:target]];
        });
    }
}

- (BOOL)isLoadingViewShowingWithTarget:(UIViewController *)target {
    IRAlertLoadingViewController* loadingView = loadingViewDictionary[[NSValue valueWithNonretainedObject:target]];
    if (loadingView) {
        return YES;
    }
    
    return NO;
}

@end

