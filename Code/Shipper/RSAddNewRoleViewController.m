//
//  RSAddNewRoleViewController.m
//  Shipper
//
//  Created by QUIKHOP on 7/20/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSAddNewRoleViewController.h"

@interface RSAddNewRoleViewController ()
{
    NSDictionary *dataDict;
}

@end

@implementation RSAddNewRoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 1000)];
    
    if (_receiveDataDict != nil)
    {
        [self setRoleData];
    }
}

-(void)setRoleData
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
        NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
        
        NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"Name\":\"%@\",\"Description\":\"%@\",\"IPAddress\":\"%@\",\"SourceBrowser\":\"%@\",\"CreatedBY\":\"%@\",\"SourceDecice\":\"%@\"}",[logDict objectForKey:@"subscriptionId"],_textFieldBranch.text,_textFieldDescription.text,@"",@"",[logDict objectForKey:@"emailId"],@""];
        NSLog(@"%@",userUpdate);
        
        // {"SubscriptionId":30073,"Name":"ghty","Description":"rfg","IPAddress":"","SourceBrowser":"","CreatedBY":"ranjit.singh@quikhop.com","SourceDecice":"SoroleceDevice"}
        
        
        NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,SAVE_NEW_ROLE];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:completeLoginUrlWithSpace]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json"       forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSData *fPostData = [userUpdate dataUsingEncoding:NSASCIIStringEncoding];
        [request setHTTPBody:fPostData];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             
             if (data != nil)
             {
                  NSDictionary *isSuccess = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 
             if ([[isSuccess objectForKey:@"isSuccess"] boolValue])
                 {
                     [Utils messageAlert:@"Record has been successfully added" title:INFO delegate:self];
                 }
                 else
                 {
                     [Utils messageAlert:[dataDict objectForKey:@"message"] title:INFO delegate:self];
                 }
                [SVProgressHUD dismiss];
             }
             else
             {
                 [SVProgressHUD dismiss];
             }
         }];
    }
}
- (IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
