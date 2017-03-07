//
//  RSRequestedViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/23/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSRequestedViewController.h"
#import "RSApprovalTableViewCell.h"
#import "RSAllAssignTruckViewController.h"
#import "RSRequestedTruckViewController.h"
#import "RSLoadDetailsViewController.h"
#import "RSUpdateLoadViewController.h"

@interface RSRequestedViewController ()

{
    NSMutableDictionary *requstDataDict;
    int pageIndx ;
    int pageSiz ;
    RSApprovalTableViewCell *cell;
}

@end

@implementation RSRequestedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    pageIndx= 1;
    pageSiz = 5;
    self.dataArray =[[NSMutableArray alloc] init];
    [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [SVProgressHUD show];
    [self performSelector:@selector(getAllRequested) withObject:nil afterDelay:0];
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(getAllRequested) userInfo:nil repeats:YES];
}
-(void)getAllRequested
{

    self.noMoreResultsAvail =NO;
    if (self.dataArray.count == 0)
    {
        [SVProgressHUD show];
        
        NSLog(@"%@",[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]]);
        NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
        
        NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"CreatedBy\":\"%@\",\"Status\":\"%@\",\"pageIndex\":%d,\"PageSize\":%d,\"TruckRequestStatus\":%@,\"IsAll\":%d}",[logDict objectForKey:@"subscriptionId"],[logDict objectForKey:@"emailId"],@"0",pageIndx,pageSiz,@"1" ,false];
        NSLog(@"%@",userUpdate);
        
        //{"SubscriptionId":30073,"Status":5,"TruckRequestStatus":0,"CreatedBy":"ranjit.singh@quikhop.com","IsAll":false,"PageIndex":1,"PageSize":5}
        
        NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,NEW_LOAD];
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
                 id rsJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 
                 self.dataArray = [[NSMutableArray alloc]initWithArray:[rsJson valueForKey:@"load"]];
                 
                 if (self.dataArray != nil)
                 {
                     [_rTableView reloadData];
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
-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.selectedTab = 0;
}
#pragma mark table view data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if([ self.dataArray count] ==0){
        return 0;
    }
    else {
        return [self.dataArray count]+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier =@"RSApprovalTableViewCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    }
    
    if (self.dataArray.count != 0) {
        if(indexPath.row <[self.dataArray count]){
            
            [cell.clabelCommodityInfo setHidden:NO];
            [cell.labelLocation setHidden:NO];
            [cell.labelDate setHidden:NO];
            [cell.labelOfferPrice setHidden:NO];
            
            [cell.labelLoadId     setHidden:NO];
            [cell.labelToLocation setHidden:NO];
            [cell.labelToDate     setHidden:NO];
            [cell.labelTruckType  setHidden:NO];
            [cell.bidNowBtn       setHidden:NO];
            [cell.bgView          setHidden:NO];
            
            [cell.labelPickUp     setHidden:NO];
            [cell.labelDropOff    setHidden:NO];
            [cell.fLabelOfferPrice setHidden:NO];
            [cell.redArrowImageView setHidden:NO];
            [cell.truckIconImageView setHidden:NO];
            [cell.rView           setHidden:NO];
            [cell.leftArrowImageView setHidden:NO];
            
            [cell.clabelCommodityInfo setText:
             [Utils returnString:[NSString stringWithFormat:@"%@/%@",
                                  [Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"commodity"]],[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"totalQuantityValue"]]]]];
            [cell.labelLoadId setText:
             [NSString stringWithFormat:@"Load Id # %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"id"]]]];
            
            if ([[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"fromPickUpLocation"] count] == 0)
            {
                [cell.labelLocation setText:
                 [NSString stringWithFormat:@"N/A"]];
                
            }
            else
            {
                [cell.labelLocation setText:
                 [NSString stringWithFormat:@"%@ %@",
                  [Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"fromPickUpLocation"]objectAtIndex:0] objectForKey:@"fromLocation"]],
                  [Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"fromPickUpLocation"]objectAtIndex:0] objectForKey:@"pickUpState"]]
                  ]];
                
                [cell.labelToLocation setText:
                 [NSString stringWithFormat:@" %@ %@",
                  [Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"toPickUpLocation"]objectAtIndex:0] objectForKey:@"toLocation"]],
                  [Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"toPickUpLocation"]objectAtIndex:0] objectForKey:@"dispatchState"]]
                  ]];
            }
            
            [cell.labelDate setText:
             [Utils convertDateFormate:[Utils returnString:[NSString stringWithFormat:@"%@",
                                                            [[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"pickUpStartDate"] componentsSeparatedByString:@"T"] objectAtIndex:0]]]]];
            [cell.labelStatus setText:[NSString stringWithFormat:@"%@",[Utils returnString:[Utils returnStateOfLoad:[[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"status"] intValue]]]]];
            CGSize size = [cell.labelStatus.text sizeWithAttributes:
                           @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
            cell.labelStatus.frame = CGRectMake(cell.labelStatus.frame.origin.x, cell.labelStatus.frame.origin.y, size.width+5,cell.labelStatus.frame.size.height);
            
            cell.labelStatus.layer.cornerRadius = 5.0;
            cell.labelStatus.layer.masksToBounds = YES;

            [cell.labelToDate setText:
             [Utils convertDateFormate:[Utils returnString:[NSString stringWithFormat:@"%@",
                                                            [[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"pickUpEndDate"] componentsSeparatedByString:@"T"] objectAtIndex:0]]]]];
            
            [cell.labelTruckType setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"powerUnitType"]]];
            
            cell.rView.layer.cornerRadius = 10.0;
            
            [cell.btnCancelLoad addTarget:self action:@selector(cancelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
             cell.btnCancelLoad.layer.cornerRadius = 10.0;
            
            [cell.btnEditLoad addTarget:self action:@selector(editBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
             cell.btnEditLoad.layer.cornerRadius = 10.0;
            
            [cell.btnDeleteLoad addTarget:self action:@selector(deleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
             cell.btnDeleteLoad.layer.cornerRadius = 10.0;
            
            [cell.btnFindTruck addTarget:self action:@selector(findTruckBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
             cell.btnFindTruck.layer.cornerRadius = 10.0;

            
        }
        else{
            if (!self.noMoreResultsAvail) {
                spinner.hidden =YES;
                
                [cell.clabelCommodityInfo setHidden:YES];
                [cell.labelLocation setHidden:YES];
                [cell.labelDate setHidden:YES];
                [cell.labelOfferPrice setHidden:YES];
                
                [cell.labelLoadId setHidden:YES];
                [cell.labelToLocation setHidden:YES];
                [cell.labelToDate setHidden:YES];
                [cell.labelTruckType setHidden:YES];
                [cell.bidNowBtn setHidden:YES];
                [cell.bgView     setHidden:YES];
                [cell.labelPickUp     setHidden:YES];
                [cell.labelDropOff    setHidden:YES];
                [cell.fLabelOfferPrice setHidden:YES];
                [cell.redArrowImageView setHidden:YES];
                [cell.truckIconImageView setHidden:YES];
                [cell.rView              setHidden:YES];
                [cell.leftArrowImageView setHidden:YES];
                
                
                spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                spinner.frame = CGRectMake(150, 10, 24, 50);
                spinner.color = [UIColor colorWithRed:153.0/255 green:0.0/255 blue:0.0/255 alpha:1];
                [cell addSubview:spinner];
                if ([self.dataArray count] >= 5)
                {
                    spinner.hidden=NO;
                    [spinner startAnimating];
                    
                }
            }
            else{
                [spinner stopAnimating];
                spinner.hidden=YES;
                
                [cell.clabelCommodityInfo setHidden:YES];
                [cell.labelLocation setHidden:YES];
                [cell.labelDate setHidden:YES];
                [cell.labelOfferPrice setHidden:YES];
                
                [cell.labelLoadId setHidden:YES];
                [cell.labelToLocation setHidden:YES];
                [cell.labelToDate setHidden:YES];
                [cell.labelTruckType setHidden:YES];
                [cell.bidNowBtn setHidden:YES];
                [cell.bgView     setHidden:YES];
                [cell.labelPickUp     setHidden:YES];
                [cell.labelDropOff    setHidden:YES];
                [cell.fLabelOfferPrice setHidden:YES];
                [cell.redArrowImageView setHidden:YES];
                [cell.truckIconImageView setHidden:YES];
                [cell.rView              setHidden:YES];
                [cell.leftArrowImageView setHidden:YES];
            }
            
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSLoadDetailsViewController *bidDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"RSLoadDetailsViewController"];
    bidDetails.receiveDataDict = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:bidDetails animated:YES];
    
}
-(void)cancelBtnPressed:(UIButton *)sender
{
//    RSUpdateLoadViewController *updateVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSUpdateLoadViewController"];
//    [self.navigationController pushViewController:updateVc animated:YES];
}
-(void)editBtnPressed:(UIButton *)sender
{
    RSUpdateLoadViewController *updateVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSUpdateLoadViewController"];
    [self.navigationController pushViewController:updateVc animated:YES];
}
-(void)deleteBtnPressed:(UIButton *)sender
{
    //    RSUpdateLoadViewController *updateVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSUpdateLoadViewController"];
    //    [self.navigationController pushViewController:updateVc animated:YES];
}
-(void)findTruckBtnPressed:(UIButton *)sender
{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    
    RSAllAssignTruckViewController *updateVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAllAssignTruckViewController"];
    updateVc.receiveDataDict = [self.dataArray objectAtIndex:aIndexPath.row];
    [self.navigationController pushViewController:updateVc animated:YES];
    
}


-(void)btnRequestSentPressed:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    
    RSRequestedTruckViewController *updateVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSRequestedTruckViewController"];
    updateVc.receiveDataDict = [self.dataArray objectAtIndex:aIndexPath.row];
    [self.navigationController pushViewController:updateVc animated:YES];
}
//-(void)goToAssignTruck:(UIButton *)sender
//{
//    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
//    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
//    cell = (RSRequestTableViewCell *)[_rTableView cellForRowAtIndexPath:aIndexPath];
//    
//    RSAssignTruckToLoadViewController *assignVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAssignTruckToLoadViewController"];
//    assignVc.receiveDataDict = [self.dataArray objectAtIndex:aIndexPath.row];
//    [self.navigationController pushViewController:assignVc animated:YES];
//}
//-(void)goToBidNow:(UIButton *)sender
//{
//    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
//    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
//    cell = (RSRequestTableViewCell *)[_rTableView cellForRowAtIndexPath:aIndexPath];
//    
//    RSBiddingDetailsViewController *bidDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"RSBiddingDetailsViewController"];
//    bidDetails.recieVeDataDict = [self.dataArray objectAtIndex:aIndexPath.row];
//    [self.navigationController pushViewController:bidDetails animated:YES];
//}
#pragma UIScrollView Method:
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!self.loading) {
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self performSelector:@selector(loadDataDelayed) withObject:nil afterDelay:1];
        }
    }
}

#pragma UserDefined Method for generating data which are show in Table :::
-(void)loadDataDelayed
{
    if (self.dataArray.count%5 == 0)
    {
        pageIndx = (int)self.dataArray.count/5;
        pageIndx = ++pageIndx;
    }
    else
    {
        pageIndx = (int)self.dataArray.count/5;
        pageIndx = pageIndx+2;
    }
    NSInteger countBefore = [self.dataArray count];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSLog(@"%@",[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]]);
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"CreatedBy\":\"%@\",\"Status\":\"%@\",\"pageIndex\":%d,\"PageSize\":%d,\"TruckRequestStatus\":%@,\"IsAll\":%d}",[logDict objectForKey:@"subscriptionId"],[logDict objectForKey:@"emailId"],@"0",pageIndx,pageSiz,@"1",false];
    NSLog(@"%@",userUpdate);
    
    
    //{"SubscriptionId":30073,"Status":5,"TruckRequestStatus":0,"CreatedBy":"ranjit.singh@quikhop.com","IsAll":false,"PageIndex":1,"PageSize":5}
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,NEW_LOAD];
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
             NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             
             NSData *mData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary* skillDict = [NSJSONSerialization JSONObjectWithData:mData options:0 error:nil];
             NSMutableArray *array = [skillDict objectForKey:@"load"] ;
             NSLog(@"The user update is = %@",array);
             [self.dataArray addObjectsFromArray:array];
             NSInteger countAfter = [self.dataArray count];
             [self.rTableView reloadData];
             
             if (countBefore!= countAfter)
             {
                 //[self.rTableView reloadData];
             }
             else
             {
                 [spinner stopAnimating];
                 [spinner hidesWhenStopped];
                 self.noMoreResultsAvail = YES;
             }
         }
         else
         {
             [self loadDataDelayed];
         }
     }];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)rCell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([rCell respondsToSelector:@selector(setSeparatorInset:)]) {
        [rCell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([rCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [rCell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.rTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.rTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.rTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.rTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}




@end
