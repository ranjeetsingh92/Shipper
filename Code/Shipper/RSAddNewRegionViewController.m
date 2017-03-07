//
//  RSAddNewRegionViewController.m
//  Shipper
//
//  Created by QUIKHOP on 7/8/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSAddNewRegionViewController.h"

@interface RSAddNewRegionViewController ()

@end

@implementation RSAddNewRegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 600)];
    
    if (_receiveDataDict != nil)
    {
        [self setRegionData];
    }
    
}

-(void)setRegionData
{
    [_textFieldRegion setText:[_receiveDataDict objectForKey:@"name"]];
    [_textFielddescription setText:@"description"];
}
- (IBAction)submitBtnAction:(id)sender
{
   [SVProgressHUD show];
    
    if ([_textFieldRegion.text isEqualToString:@""]||[_textFielddescription.text isEqualToString:@""])
    {
        [Utils messageAlert:FILL_ALL_DATA title:INFO delegate:self];
        [SVProgressHUD dismiss];
    }
    else
    {
        if (![Utils checkUniquenessOfRegion:_textFieldRegion.text])
        {
            [Utils messageAlert:EXIST_REGION title:INFO delegate:self];
            [SVProgressHUD dismiss];
        }
        else
        {
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
//            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                //code to be executed on the main queue after delay
//                NSDictionary *dict = [Utils saveNewRegion:_textFieldRegion.text description:_textFielddescription.text] ;
//                
//                if ([[dict objectForKey:@"isSuccess"] boolValue] == TRUE)
//                {
//                    [Utils messageAlert:@"The region has been added successfully" title:INFO delegate:self];
//                }
//                else
//                {
//                    [Utils messageAlert:[dict objectForKey:@"message"] title:INFO delegate:self];
//                }
//                [SVProgressHUD dismiss];
//            });
            
            
            NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
            
            NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"Name\":\"%@\",\"Description\":\"%@\",\"IPAddress\":\"%@\",\"SourceBrowser\":\"%@\",\"CreatedBY\":\"%@\",\"SourceDecice\":\"%@\"}",[logDict objectForKey:@"subscriptionId"],_textFieldRegion.text,_textFielddescription.text,@"",@"",[logDict objectForKey:@"emailId"],@""];
            NSLog(@"%@",userUpdate);
            
            // {"Name":"fgrt","Description":"sder","SubscriptionId":30073,"IPAddress":"","SourceBrowser":"","CreatedBY":"ranjit.singh@quikhop.com","SourceDecice":"SourceDevice"}
            
            
            NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,SAVE_NEW_REGION];
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
                     
                     if ([[isSuccess objectForKey:@"isSuccess"] boolValue] == TRUE)
                     {
                         [Utils messageAlert:@"The region has been added successfully" title:INFO delegate:self];
                         [self resetMethod];
                     }
                     else
                     {
                         [Utils messageAlert:[isSuccess objectForKey:@"message"] title:INFO delegate:self];
                     }   [SVProgressHUD dismiss];
                 }
                 else
                 {
                     [SVProgressHUD dismiss];
                 }
             }];
        }
    }
}
#pragma mark reset method
-(void)resetMethod
{
    [_textFieldRegion setText:@""];
    [_textFielddescription setText:@""];
}
- (IBAction)cancelBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma textfield delgate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
