//
//  IRAlertLoadingViewController.m
//  IRAlertManager
//
//  Created by Phil on 2019/7/15.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "IRAlertLoadingViewController.h"

@interface IRAlertLoadingViewController ()

@property (weak) IBOutlet UIImageView *backgroundImageView;

@end

@implementation IRAlertLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    self.view.frame = CGRectMake(0, 0, self.backgroundImage.size.width, self.backgroundImage.size.height);
    self.backgroundImageView.image = self.backgroundImage;
}

@end
