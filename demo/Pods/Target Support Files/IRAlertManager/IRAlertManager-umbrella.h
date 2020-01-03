#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "IRAlert+Package.h"
#import "IRAlert.h"
#import "IRAlertAction.h"
#import "IRAlertLoadingViewController.h"
#import "IRAlertManager.h"
#import "IRAlertSystem.h"
#import "UIImageEffects.h"
#import "Utilities.h"

FOUNDATION_EXPORT double IRAlertManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char IRAlertManagerVersionString[];

