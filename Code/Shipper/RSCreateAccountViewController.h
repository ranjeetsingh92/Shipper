//
//  RSCreateAccountViewController.h
//  Shipper
//
//  Created by QUIKHOP on 6/24/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSCreateAccountViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
@property (strong, nonatomic) IBOutlet UITextField *textFieldFname;
@property (strong, nonatomic) IBOutlet UITextField *textFieldLName;
@property (strong, nonatomic) IBOutlet UITextField *textFieldCity;
@property (strong, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (strong, nonatomic) IBOutlet UITextField *textFieldMobileNo;
- (IBAction)createAccountBtnPressed:(id)sender;
- (IBAction)cancelBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldMiddleName;

@end
