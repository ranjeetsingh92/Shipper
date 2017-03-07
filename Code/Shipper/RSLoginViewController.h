//
//  RSLoginViewController.h
//  Shipper
//
//  Created by QUIKHOP on 6/23/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSLoginViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;

@property (strong, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPassword;
- (IBAction)submitBtnPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *checkBtn;
- (IBAction)checkBtnPressed:(id)sender;

- (IBAction)forgotPas:(id)sender;
- (IBAction)createAccount:(id)sender;

@end
