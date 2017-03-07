//
//  RSMainDashBoardViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/27/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSMainDashBoardViewController.h"

@interface RSMainDashBoardViewController ()
{
    AppDelegate *app;
}

@end

@implementation RSMainDashBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:153.0/255 green:0 blue:0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self performSelector:@selector(getLoadCount) withObject:nil afterDelay:0.0];
   
}
-(void)getLoadCount
{
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@}",[logDict objectForKey:@"subscriptionId"]];
    NSLog(@"%@",userUpdate);
    
    //  {"SubscriptionId":30073,"pageIndex":1,"PageSize":1000}
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_ALL_LOAD_COUNT];
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
             NSDictionary *loadDetailDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             
             if (loadDetailDict != nil)
             {
                 [_labelNewLoad setText:[NSString stringWithFormat:@"%@",[loadDetailDict objectForKey:@"newLoad"]]];
                 [_labelRequestedLoad setText:[NSString stringWithFormat:@"%@",[loadDetailDict objectForKey:@"requestedLoad"]]];
                 [_labelBidding setText:[NSString stringWithFormat:@"%@",[loadDetailDict objectForKey:@"biddingLoad"]]];
                 [_labelBooked setText:[NSString stringWithFormat:@"%@",[loadDetailDict objectForKey:@"bookedLoad"]]];
                 [_labelPlanned setText:[NSString stringWithFormat:@"%@",[loadDetailDict objectForKey:@"plannedLoad"]]];
              }
             [SVProgressHUD dismiss];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];
}

- (IBAction)leftBarButtonPressed:(id)sender
{
    [self.revealViewController revealToggle:self];
}

- (IBAction)newLoadBtnPressed:(id)sender
{
    app =(AppDelegate *) [UIApplication sharedApplication].delegate;
    app.selectedTab = 2;
    [app showReveal];
}
- (IBAction)requestedBtnPressed:(id)sender
{
    app =(AppDelegate *) [UIApplication sharedApplication].delegate;
    app.selectedTab = 3;
    [app showReveal];
}
- (IBAction)biddingBtnPressed:(id)sender
{
  
    app =(AppDelegate *) [UIApplication sharedApplication].delegate;
    app.selectedTab = 4;
    [app showReveal];
}

- (IBAction)bookedBtnPessed:(id)sender
{
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.selectedTab = 5;
    [app showReveal];
}

- (IBAction)plabbedBtnPressed:(id)sender
{
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.selectedTab = 6;
    [app showReveal];
}

- (IBAction)allBtnPressed:(id)sender
{
    app =(AppDelegate *) [UIApplication sharedApplication].delegate;
    app.selectedTab = 7;
    [app showReveal];
}
@end
