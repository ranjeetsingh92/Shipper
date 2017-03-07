//
//  RSAddNewDepartmentViewController.m
//  Shipper
//
//  Created by QUIKHOP on 7/20/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSAddNewDepartmentViewController.h"

@interface RSAddNewDepartmentViewController ()
{
    NSDictionary *dataDict;
}

@end

@implementation RSAddNewDepartmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 1000)];
    
    if (_receiveDataDict != nil)
    {
        [self setDepartmentData];
    }
}

-(void)setDepartmentData
{
    [_textFieldBranch setText:[_receiveDataDict objectForKey:@"name"]];
    [_textFieldDescription setText:[_receiveDataDict objectForKey:@"description"]];
}
#pragma mark textfield delegate method

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)submitBtnPressed:(id)sender
{
    [SVProgressHUD show];
    if ([_textFieldBranch.text isEqualToString:@""]||[_textFieldDescription.text isEqualToString:@""])
    {
        [Utils messageAlert:FILL_ALL_DATA title:INFO delegate:self];
        [SVProgressHUD dismiss];
    }
    else
    {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            dataDict = [Utils saveNewDepartment:_textFieldBranch.text description:_textFieldDescription.text];
            
            if ([[dataDict objectForKey:@"isSuccess"] boolValue])
            {
                [Utils messageAlert:@"Record has been successfully added" title:INFO delegate:self];
            }
            else
            {
                [Utils messageAlert:[dataDict objectForKey:@"message"] title:INFO delegate:self];
            }
            
            [SVProgressHUD dismiss];
        });
        
    }
    
}
- (IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
