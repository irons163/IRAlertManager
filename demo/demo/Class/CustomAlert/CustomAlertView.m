//
//  CustomAlertView.m
//
//  Created by Phil on 2018/1/23.
//

#import "CustomAlertView.h"

@interface CustomAlertView()
    
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation CustomAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    NSString *nibName = NSStringFromClass([self class]);
    [[NSBundle mainBundle] loadNibNamed:nibName
                                  owner:self
                                options:nil];
    self.contentView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *topConstraint =[NSLayoutConstraint
                                        constraintWithItem:self.contentView
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                        attribute:NSLayoutAttributeTop
                                        multiplier:1.0f
                                        constant:0.f];
    
    //Add the view loaded from the nib into self.
    [self addSubview:self.contentView];
    
    NSLayoutConstraint *bottomConstraint =[NSLayoutConstraint
                                           constraintWithItem:self.contentView
                                           attribute:NSLayoutAttributeBottom
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self
                                           attribute:NSLayoutAttributeBottom
                                           multiplier:1.0f
                                           constant:0.f];
    NSLayoutConstraint *leadingConstraint =[NSLayoutConstraint
                                            constraintWithItem:self.contentView
                                            attribute:NSLayoutAttributeLeading
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                            attribute:NSLayoutAttributeLeading
                                            multiplier:1.0f
                                            constant:0.f];
    NSLayoutConstraint *trailingConstraint =[NSLayoutConstraint
                                             constraintWithItem:self.contentView
                                             attribute:NSLayoutAttributeTrailing
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self
                                             attribute:NSLayoutAttributeTrailing
                                             multiplier:1.0f
                                             constant:0.f];
    
    topConstraint.active = YES;
    bottomConstraint.active = YES;
    leadingConstraint.active = YES;
    trailingConstraint.active = YES;
    
    self.backgroundColor = [UIColor clearColor];
}

- (IBAction)cancelButtonClick:(id)sender {
    if(self.cancelButtonClick) {
        self.cancelButtonClick();
        [[IRAlertManager sharedInstance] hideAlert:self.alert];
    }
    else
        [[IRAlertManager sharedInstance] hideAlert:self.alert];
}

- (IBAction)commitButtonClick:(id)sender {
    if(self.commitButtonClick) {
        self.commitButtonClick();
    }
    
    [[IRAlertManager sharedInstance] hideAlert:self.alert];
}
@end
