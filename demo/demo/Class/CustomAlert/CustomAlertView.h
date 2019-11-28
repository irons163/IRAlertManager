//
//  CustomAlertView.h
//
//  Created by Phil on 2018/1/23.
//

#import <UIKit/UIKit.h>
#import <IRAlertManager/IRAlertManager.h>

typedef void(^ButtonClick)(void);

@interface CustomAlertView : UIView
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;

@property (strong, nonatomic) IRAlert *alert;
@property ButtonClick cancelButtonClick;
@property ButtonClick commitButtonClick;

- (IBAction)cancelButtonClick:(id)sender;
- (IBAction)commitButtonClick:(id)sender;

@end
