//
//  RSCreateAccountViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/24/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSCreateAccountViewController.h"
#import "RSEnterOtpViewController.h"

@interface RSCreateAccountViewController ()

@end

@implementation RSCreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:NO];
    [self.rScrollView setContentSize:CGSizeMake(320, 650)];
}



- (IBAction)createAccountBtnPressed:(id)sender
{
    if (([_textFieldFname.text isEqualToString:@""]||[_textFieldLName.text isEqualToString:@""]||[_textFieldEmail.text isEqualToString:@""]||[_textFieldMobileNo.text isEqualToString:@""])&&![Utils validateEmail:_textFieldEmail.text])
    {
        [Utils messageAlert:VALID_DATA title:INFO delegate:self];
    }
    else
    {
        if (!([[_textFieldMobileNo.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"7"]||[[_textFieldMobileNo.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"8"]||[[_textFieldMobileNo.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"9"]||[[_textFieldMobileNo.text substringWithRange:NSMakeRange(1,1 )] isEqualToString:@"7"]||[[_textFieldMobileNo.text substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"8"]||[[_textFieldMobileNo.text substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"9"]||[[_textFieldMobileNo.text substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"7"]||[[_textFieldMobileNo.text substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"8"]||[[_textFieldMobileNo.text substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"9"]))
        {
            [Utils messageAlert:VALID_MOBILE title:INFO delegate:self];
        }
        else
        {
            [SVProgressHUD show];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //code to be executed on the main queue after delay
                NSDictionary *registerDict = [[NSDictionary alloc]initWithDictionary:[Utils registerUser:_textFieldEmail.text  firstName:_textFieldFname.text middleName:_textFieldMiddleName.text lastName:_textFieldLName.text mobileNumber:_textFieldMobileNo.text]];
                if (registerDict != nil)
                {
                    RSEnterOtpViewController *otpVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSEnterOtpViewController"];
                    [self.navigationController pushViewController:otpVc animated:YES];
                }
                [SVProgressHUD dismiss];
            });
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
