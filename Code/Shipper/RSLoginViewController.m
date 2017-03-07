//
//  RSLoginViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/23/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSLoginViewController.h"



@interface RSLoginViewController ()
{
    BOOL rememberMe;
    BOOL isChecked;
}

@end

@implementation RSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rememberMe = false;
    isChecked  = false;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 650)];
    [_textFieldPassword setSecureTextEntry:YES];
}

#pragma mark view will appear
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark textfield resign keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)submitBtnPressed:(id) sender
{
    [SVProgressHUD show];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        NSLog(@"There is no internet connection");
        [Utils messageAlert:CHECK_NET_CONNECTIVITY title:INFO delegate:self];
    }
    else
    {
        if ([_textFieldEmail.text isEqualToString:@""]||[_textFieldPassword.text isEqualToString:@""])
        {
            [Utils messageAlert:CHECK_EMPTYNESS title:INFO delegate:self];
            [SVProgressHUD dismiss];
        }
        else
        {
            if (![Utils validateEmail:_textFieldEmail.text])
            {
                [Utils messageAlert:CHECK_EMAIL_VALIDITY title:INFO delegate:self];
                [SVProgressHUD dismiss];

            }
            else
            {
                
                
                NSString *userUpdate = [NSString stringWithFormat:@"{\"emailId\":\"%@\",\"userPassword\":\"%@\"}",_textFieldEmail.text,_textFieldPassword.text];
                NSLog(@"%@",userUpdate);
                
                //  {"emailId":"ranjit.singh@quikhop.com","userPassword":"ranjitsingh"}
                
                NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,LOGIN];
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
                         NSDictionary  *loginDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                         
                         if ([[loginDict objectForKey:@"message"] isEqualToString:@"Successfully Login"])
                         {
                             if (rememberMe)
                             {
                                 NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                                 NSData *keyedArch = [NSKeyedArchiver archivedDataWithRootObject:[loginDict objectForKey:@"aUser"]];
                                 [def setObject:keyedArch forKey:@"loginData"];
                                 [def synchronize];
 
                                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                 NSData *encodedObject = [defaults objectForKey:@"loginData"];
                                 NSDictionary *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
                                 NSLog(@"the data is = %@",object);
                             }
                             AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
                             [app showMainDashboard];
                             [SVProgressHUD dismiss];
                         }
                         else
                         {
                             [Utils messageAlert:@"Please enter a valid user name and password!" title:INFO delegate:self];
                             [SVProgressHUD dismiss];
                         }
                     }
                     else
                     {
                         [SVProgressHUD dismiss];
                     }
                 }];

                
//                [SVProgressHUD show];
//                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
//                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                    //code to be executed on the main queue after delay
//                    NSDictionary *loginArray = [[NSDictionary alloc]initWithDictionary:[Utils hitLogin:_textFieldEmail.text password:_textFieldPassword.text]];
//                    if (loginArray != nil)
//                    {
//                        if ([[loginArray objectForKey:@"message"] isEqualToString:@"Successfully Login"])
//                        {
//                            if (rememberMe)
//                            {
//                                NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//                                NSData *keyedArch = [NSKeyedArchiver archivedDataWithRootObject:[loginArray objectForKey:@"aUser"]];
//                                [def setObject:keyedArch forKey:@"loginData"];
//                                [def synchronize];
//                                
//                                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                                NSData *encodedObject = [defaults objectForKey:@"loginData"];
//                                NSDictionary *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
//                                NSLog(@"the data is = %@",object);
//                            }
//                            AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//                            [app showMainDashboard];
//                            [SVProgressHUD dismiss];
//                        }
//                        else
//                        {
//                            [Utils messageAlert:@"Please enter a valid user name and password!" title:INFO delegate:self];
//                            [SVProgressHUD dismiss];
//                        }
//                    }
//                    else
//                    {
//                        [SVProgressHUD dismiss];
//                    }
//                });
            }
        }
        
    }
}
- (IBAction)checkBtnPressed:(id)sender
{
    if (!isChecked)
    {
        [_checkBtn setImage:[UIImage imageNamed:@"lo_rem.png"] forState:UIControlStateNormal];
        rememberMe = true;
        isChecked = true;
    }
    else
    {
        [_checkBtn setImage:[UIImage imageNamed:@"lo_rem_un.png"] forState:UIControlStateNormal];
        rememberMe = false;
        isChecked  = false;
    }
}
- (IBAction)forgotPas:(id)sender
{
    
}

- (IBAction)createAccount:(id)sender
{
    
}
@end
