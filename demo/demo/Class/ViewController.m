//
//  ViewController.m
//  demo
//
//  Created by Phil on 2019/7/16.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "ViewController.h"
#import "IRAlertXF.h"
#import "IRAlertLG.h"
#import "CustomAlertView.h"

#define GetUserProfileSuccessNotification @"GetUserProfileSuccessNotification"
#define GetFriendsSuccessNotification @"GetFriendsSuccessNotification"
#define GetMessagesSuccessNotification @"GetMessagesSuccessNotification"

@interface ViewController ()
@end

@implementation ViewController {
    IRAlert* alert;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)showAlert:(id)sender {
    alert = [[IRAlertXF alloc] init];
    
    [self setBlurWithRadius:[ViewController blurRadius]
                  tintColor:[ViewController blurTintColor]
      saturationDeltaFactor:[ViewController blurSaturationDeltaFactor] toAlert:alert];
    [alert setCornerRadius:20];
    
    __weak IRAlert *wAlert = alert;
    IRAlertAction *commitAction = [[IRAlertAction alloc] init];
    commitAction.title = @"OK";
    commitAction.style = IRAlertActionStyleDefault;
    commitAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideAlert:wAlert];
    };
    [alert addAction:commitAction];

    __weak ViewController *wSelf = self;
    IRAlertAction *cancelAction = [[IRAlertAction alloc] init];
    cancelAction.title = @"Cancel";
    cancelAction.style = IRAlertActionStyleCancel;
    cancelAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideLoadingViewWithTarget:wSelf];
    };
    [alert addAction:cancelAction];
    
    [[IRAlertManager sharedInstance] showAlert:alert];
}

- (IBAction)showCustomAlert:(id)sender {
    CustomAlertView* customView = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 100, 180)];
    alert = [[IRAlertXF alloc] initWithCustomView:customView];
    customView.titleLabel.text = @"Test";
    customView.messageLabel.text = @"Message";
    [customView.commitButton setTitle:@"OK" forState:UIControlStateNormal];
    [customView.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    customView.alert = alert;
    
    customView.commitButtonClick = ^{
        
    };
    
    customView.cancelButtonClick = ^{
        
    };
    
    [self setBlurWithRadius:[ViewController blurRadius]
                  tintColor:[ViewController blurTintColor]
      saturationDeltaFactor:[ViewController blurSaturationDeltaFactor] toAlert:alert];
    [alert setCornerRadius:20];
    
    __weak IRAlert *wAlert = alert;
    IRAlertAction *commitAction = [[IRAlertAction alloc] init];
    commitAction.title = @"OK";
    commitAction.style = IRAlertActionStyleDefault;
    commitAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideAlert:wAlert];
    };
    [alert addAction:commitAction];

    __weak ViewController *wSelf = self;
    IRAlertAction *cancelAction = [[IRAlertAction alloc] init];
    cancelAction.title = @"Cancel";
    cancelAction.style = IRAlertActionStyleCancel;
    cancelAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideLoadingViewWithTarget:wSelf];
    };
    [alert addAction:cancelAction];
    
    [[IRAlertManager sharedInstance] showAlert:alert];
}

- (IBAction)showLGAlert:(id)sender {
    IRAlertAction *commitAction = [[IRAlertAction alloc] init];
    commitAction.title = @"OK";
    commitAction.style = IRAlertActionStyleDefault;

    IRAlertAction *cancelAction = [[IRAlertAction alloc] init];
    cancelAction.title = @"Cancel";
    cancelAction.style = IRAlertActionStyleCancel;
    
    alert = [[IRAlertLG alloc] initWithTitle:nil message:nil style:IRAlertLGStyleAlert buttonActions:@[commitAction] cancelButtonAction:cancelAction destructiveButtonAction:nil];
    
    __weak IRAlert *wAlert = alert;
    commitAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideAlert:wAlert];
    };
    __weak ViewController *wSelf = self;
    cancelAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideLoadingViewWithTarget:wSelf];
    };
    
    [(IRAlertLG *)alert setBlurWithBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular]];
    [(IRAlertLG *)alert setBlurWithColor:[ViewController blurTintColor]];
    [(IRAlertLG *)alert setBlurWithAlpha:0.4f];
    [alert setCornerRadius:20];
    [[IRAlertManager sharedInstance] showAlert:alert];
}

- (IBAction)showCustomLGAlert:(id)sender {
    IRAlertAction *commitAction = [[IRAlertAction alloc] init];
    commitAction.title = @"OK";
    commitAction.style = IRAlertActionStyleDefault;

    IRAlertAction *cancelAction = [[IRAlertAction alloc] init];
    cancelAction.title = @"Cancel";
    cancelAction.style = IRAlertActionStyleCancel;
    
    CustomAlertView* customView = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 100, 180)];
    customView.titleLabel.text = @"Test";
    customView.messageLabel.text = @"Message";
    [customView.commitButton setTitle:@"OK" forState:UIControlStateNormal];
    [customView.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    
    alert = [[IRAlertLG alloc] initWithViewAndTitle:nil message:nil style:IRAlertLGStyleAlert view:customView buttonActions:@[commitAction] cancelButtonAction:cancelAction destructiveButtonAction:nil];
    customView.alert = alert;
    
    customView.commitButtonClick = ^{
        
    };
    
    customView.cancelButtonClick = ^{
        
    };
    
    __weak IRAlert *wAlert = alert;
    commitAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideAlert:wAlert];
    };
    __weak ViewController *wSelf = self;
    cancelAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideLoadingViewWithTarget:wSelf];
    };
    
    [(IRAlertLG *)alert setBlurWithBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular]];
    [(IRAlertLG *)alert setBlurWithColor:[ViewController blurTintColor]];
    [(IRAlertLG *)alert setBlurWithAlpha:0.4f];
    [alert setCornerRadius:20];
    [[IRAlertManager sharedInstance] showAlert:alert];
}

- (IBAction)showSystemAlert:(id)sender {
    alert = [[IRAlertSystem alloc] init];
    
    __weak IRAlert *wAlert = alert;
    IRAlertAction *commitAction = [[IRAlertAction alloc] init];
    commitAction.title = @"OK";
    commitAction.style = IRAlertActionStyleDefault;
    commitAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideAlert:wAlert];
    };
    [alert addAction:commitAction];

    __weak ViewController *wSelf = self;
    IRAlertAction *cancelAction = [[IRAlertAction alloc] init];
    cancelAction.title = @"Cancel";
    cancelAction.style = IRAlertActionStyleCancel;
    cancelAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideLoadingViewWithTarget:wSelf];
    };
    [alert addAction:cancelAction];
    
    [[IRAlertManager sharedInstance] showAlert:alert];
}

- (IBAction)showSystemDialog:(id)sender {
    alert = [[IRAlertSystem alloc] initWithStyle:IRAlertControllerStyleAlert];
    ((IRAlertSystem *)alert).title = @"Message";
    
    __weak IRAlert *wAlert = alert;
    IRAlertAction *commitAction = [[IRAlertAction alloc] init];
    commitAction.title = @"OK";
    commitAction.style = IRAlertActionStyleDefault;
    commitAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideAlert:wAlert];
    };
    [alert addAction:commitAction];

    IRAlertAction *cancelAction = [[IRAlertAction alloc] init];
    cancelAction.title = @"Cancel";
    cancelAction.style = IRAlertActionStyleCancel;
    cancelAction.handler = ^(IRAlertAction * _Nonnull action) {
        
    };
    [alert addAction:cancelAction];
    
    [[IRAlertManager sharedInstance] showAlert:alert];
}

- (IBAction)showSystemDialogAndLoadingpage:(id)sender {
    alert = [[IRAlertSystem alloc] initWithStyle:IRAlertControllerStyleAlert];
    ((IRAlertSystem *)alert).title = @"Message";
    
    __weak ViewController *wSelf = self;
    __weak IRAlert *wAlert = alert;
    IRAlertAction *commitAction = [[IRAlertAction alloc] init];
    commitAction.title = @"OK";
    commitAction.style = IRAlertActionStyleDefault;
    commitAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideAlert:wAlert];
        [[IRAlertManager sharedInstance] hideLoadingViewWithTarget:wSelf];
    };
    [alert addAction:commitAction];

    
    IRAlertAction *cancelAction = [[IRAlertAction alloc] init];
    cancelAction.title = @"Cancel";
    cancelAction.style = IRAlertActionStyleCancel;
    cancelAction.handler = ^(IRAlertAction * _Nonnull action) {
        [[IRAlertManager sharedInstance] hideLoadingViewWithTarget:wSelf];
    };
    [alert addAction:cancelAction];
    
    [[IRAlertManager sharedInstance] showLoadingViewWithTarget:self backgroundImage:[ViewController imageWithColor:[UIColor greenColor] Size:[UIScreen mainScreen].bounds.size]];
    [[IRAlertManager sharedInstance] showAlert:alert];
}

- (void)setBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor toAlert:(IRAlert*)alert {
    
    [alert setBlurWithRadius:blurRadius
                   tintColor:tintColor
       saturationDeltaFactor:saturationDeltaFactor];
}

+ (CGFloat)blurRadius {
    return 10.0;
}

+ (UIColor *)blurTintColor {
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
}

+ (CGFloat)blurSaturationDeltaFactor {
    return 1.8;
}

+ (UIImage*)imageWithColor:(UIColor *)color Size:(CGSize)size{
    CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

