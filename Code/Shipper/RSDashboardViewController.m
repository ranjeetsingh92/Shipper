//
//  RSDashboardViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/23/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSDashboardViewController.h"
#import "SWRevealViewController.h"


#import "RSNewViewController.h"
#import "RSRequestedViewController.h"
#import "RSBiddingViewController.h"
#import "RSBookedViewController.h"
#import "RSPlannedViewController.h"
#import "RSAllViewController.h"
#import "RSUpdateLoadViewController.h"
#import "RSApprovalViewController.h"

@interface RSDashboardViewController ()
{
    YSLContainerViewController *containerVC;
}

@end

@implementation RSDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    // SetUp ViewControllers
    
    RSApprovalViewController *approval = [self.storyboard instantiateViewControllerWithIdentifier:@"RSApprovalViewController"];
    approval.title = @"For Approval";

    
    RSNewViewController *newVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSNewViewController"];
    newVc.title = @"Recent";
    
    RSRequestedViewController *requested = [self.storyboard instantiateViewControllerWithIdentifier:@"RSRequestedViewController"];
    requested.title = @"Requested";
    
    RSBiddingViewController *bidding = [self.storyboard instantiateViewControllerWithIdentifier:@"RSBiddingViewController"];
    bidding.title = @"Bidding";
    
    RSBookedViewController *booked = [self.storyboard instantiateViewControllerWithIdentifier:@"RSBookedViewController"];
    booked.title = @"Booked";
    
    RSPlannedViewController *planned = [self.storyboard instantiateViewControllerWithIdentifier:@"RSPlannedViewController"];
    planned.title = @"Planned";
    
    RSAllViewController *allVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAllViewController"];
    allVc.title = @"All";
    
    
    
    
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    containerVC = [[YSLContainerViewController alloc]initWithControllers:@[approval,newVc,
                                                                                                       requested,
                                                                                                       bidding,
                                                                                                       booked,
                                                                                                       planned,
                                                                                                       allVc]
                                                                                                       topBarHeight:statusHeight +navigationHeight
                                                                                                       parentViewController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    
    [self.view addSubview:containerVC.view];
}
#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //    NSLog(@"current Index : %ld",(long)index);
    //    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}
- (IBAction)leftBarButtonPressed:(id)sender
{
    [self.revealViewController revealToggle:self];
}

- (IBAction)AddNewLoadBtnPressed:(id)sender
{
    [self checkMou];
}
# pragma mark check mou
-(void)checkMou
{
    [SVProgressHUD show];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        NSDictionary *mouArr = [[NSDictionary alloc]initWithDictionary:[Utils checkMOUExistence]];
        NSLog(@"the mou data is = %@", mouArr);
        if ([[mouArr objectForKey:@"isExist"] boolValue] == false)
        {
           // [Utils messageAlert:MOU_NOT_UPLOADED title:INFO delegate:self];
            
            NSDate *mouEndDate = [Utils convertStringIntoDate:[[mouArr objectForKey:@"shipperMOULog"] objectForKey:@"mouValidityTo"]];
            if (![Utils isEndDateIsSmallerThanCurrent:mouEndDate])
            {
                [Utils messageAlert:MOU_EXPIRED title:INFO delegate:self];
            }
            else
            {
                if (![[[[mouArr objectForKey:@"shipperMOULog"] objectForKey:@"isApproved"] stringValue] isEqualToString:@"1"])
                {
                    [Utils messageAlert:MOU_NOT_APPROVED title:INFO delegate:self];
                }
                else
                {
                    RSUpdateLoadViewController *updateVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSUpdateLoadViewController"];
                    [self.navigationController pushViewController:updateVc animated:YES];
                }
            }
            
        }
        else
        {
            RSUpdateLoadViewController *updateVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSUpdateLoadViewController"];
            [self.navigationController pushViewController:updateVc animated:YES];
        }
        
        [SVProgressHUD dismiss];
    });
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
}
@end
