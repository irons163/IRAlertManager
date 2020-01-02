//
//  XFDialogMaskView.m
//  XFDialogBuilder
//
//  Created by yizzuide on 15/9/30.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFMaskView.h"
#import "UIView+DialogMeasure.h"
#import "XFDialogFrame.h"
#import "XFDialogMacro.h"
#import "UIImageEffects.h"

@interface XFMaskView ()<CAAnimationDelegate>

@property (nonatomic, weak) UIWindow *frontWindow;
@property (nonatomic, assign) CGSize orginSize;
@property (nonatomic, assign) BOOL willDisapper;
@end

@implementation XFMaskView{
    CGFloat _blurRadius;
    UIColor *_tintColor;
    CGFloat _saturationDeltaFactor;
}

- (UIWindow *)frontWindow
{
    if (_frontWindow == nil) {
        self.frontWindow = [UIApplication sharedApplication].keyWindow;
    }
    return _frontWindow;
}

+ (instancetype)dialogMaskViewWithBackColor:(UIColor *)backColor alpha:(CGFloat)alpha
{
    CGRect rect=[[UIScreen mainScreen] bounds];
    XFMaskView *dialogMaskView = [[XFMaskView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
//    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    dialogMaskView.effect = blurEffect;
    dialogMaskView.backgroundColor = backColor;
    dialogMaskView.alpha = alpha;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:dialogMaskView action:@selector(hideAction:)];
    [dialogMaskView addGestureRecognizer:tapGesture];
    
    return dialogMaskView;
}

- (void)setDialogView:(UIView *)dialogView
{
    
    [self.frontWindow addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *hConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[maskView]-0-|" options:0 metrics:nil views:@{@"maskView":self}];
    [self.frontWindow addConstraints:hConstraint];
    NSArray *vConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[maskView]-0-|" options:0 metrics:nil views:@{@"maskView":self}];
    [self.frontWindow addConstraints:vConstraint];
    
    dialogView.hidden = YES;
    
    [dialogView.layer removeAllAnimations];
    
    [self.frontWindow addSubview:dialogView];
    
    _dialogView = dialogView;
    
    self.orginSize = dialogView.size;
}

-(void)setBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor{
    _blurRadius = blurRadius;
    _tintColor = tintColor;
    _saturationDeltaFactor = saturationDeltaFactor;
    
    [self setNeedsDisplay];
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
}

- (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedScreen;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIImage *bgImage = [UIImageEffects
                        imageByApplyingBlurToImage:[self captureScreen]
                        withRadius:_blurRadius
                        tintColor:_tintColor
                        saturationDeltaFactor:_saturationDeltaFactor
                        maskImage:nil];
    [bgImage drawInRect:rect];
}

- (void)showWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock
{
    self.willDisapper = NO;
    if (animationEngineBlock) {
        self.dialogView.hidden = NO;
        animationEngineBlock(self.dialogView);
    }else{
        [NSLayoutConstraint constraintWithItem:self.dialogView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.dialogView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0].active = YES;
        self.dialogView.translatesAutoresizingMaskIntoConstraints = NO;
        
//        [self.dialogView setNeedsUpdateConstraints];
//        [self.dialogView setNeedsLayout];
//        [self.dialogView layoutIfNeeded];
        
        CABasicAnimation *scaleAnima= [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnima.delegate = self;
        [scaleAnima setDuration:0.29f];
        scaleAnima.fromValue =[NSNumber numberWithFloat:0.5];
        scaleAnima.toValue =[NSNumber numberWithFloat:1];
        scaleAnima.removedOnCompletion = NO;
        scaleAnima.fillMode = kCAFillModeForwards;
        //    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.584 : 0.070 : 0.201 : 0.965];
        CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.000 : 0.292 : 0.132 : 0.896];
        [scaleAnima setTimingFunction:timingFunction];
        
        [self.dialogView.layer addAnimation:scaleAnima forKey:@"scale"];
        
    }
}

- (void)animationDidStart:(CAAnimation *)anim
{
    self.dialogView.hidden = NO;
    
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.willDisapper) {
        [self.dialogView.layer removeAllAnimations];
        [self.dialogView removeFromSuperview];
        [self removeFromSuperview];
    }else{
        self.dialogView.centerX = self.centerX;
        self.dialogView.centerY = self.centerY;
        [self.dialogView layoutIfNeeded];
    }
}

- (void)hideWithAnimationBlock:(addAnimationEngineBlock)animationEngineBlock
{
    // 检测是否有用户自定义取消代码
    if (self.cancelCallBack) {
        self.cancelCallBack();
    }
    
    self.willDisapper = YES;
    if (animationEngineBlock) {
        float duration = animationEngineBlock(self.dialogView);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dialogView.layer removeAllAnimations];
            [self.dialogView removeFromSuperview];
            [self removeFromSuperview];
        });
    }else{
        CABasicAnimation *scaleAnima= [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnima.delegate = self;
        [scaleAnima setDuration:0.2f];
        scaleAnima.fromValue =[NSNumber numberWithFloat:1.0];
        scaleAnima.toValue =[NSNumber numberWithFloat:0.0];
        scaleAnima.removedOnCompletion = NO;
        scaleAnima.fillMode = kCAFillModeForwards;
        CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.389 : 0.000 : 0.222 : 1.000];
        [scaleAnima setTimingFunction:timingFunction];
        
        [self.dialogView.layer addAnimation:scaleAnima forKey:@"scale"];
        
        CABasicAnimation *alphaAnima= [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnima.delegate = self;
        [alphaAnima setDuration:0.2f];
        alphaAnima.fromValue =[NSNumber numberWithFloat:1.0];
        alphaAnima.toValue =[NSNumber numberWithFloat:0.0];
        alphaAnima.removedOnCompletion = NO;
        alphaAnima.fillMode = kCAFillModeForwards;
        
        [self.dialogView.layer addAnimation:alphaAnima forKey:@"opacity"];
    }
    
}

- (void)hideAction:(id)sender {
    XFDialogFrame *df = (XFDialogFrame *)self.dialogView;
    [df endEditing:YES];
    [self hideWithAnimationBlock:df.cancelAnimationEngineBlock];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 重新布局对话框视图
    self.dialogView.centerX = self.centerX;
    self.dialogView.centerY = self.centerY;
    [self.dialogView layoutIfNeeded];
}

@end
