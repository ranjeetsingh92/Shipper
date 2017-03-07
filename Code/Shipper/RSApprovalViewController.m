//
//  RSApprovalViewController.m
//  Shipper
//
//  Created by QUIKHOP on 1/6/17.
//  Copyright © 2017 QUIKHOP. All rights reserved.
//

#import "RSApprovalViewController.h"
#import "RSBiddingTableViewCell.h"
#import "RSApprovalTableViewCell.h"
#import "RSLoadDetailsViewController.h"

@interface RSApprovalViewController ()
{
    int pageIndx ;
    int pageSiz ;
}


@end

@implementation RSApprovalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    [SVProgressHUD show];
    [self performSelector:@selector(hitBookedLoadTimeAtFirstTime) withObject:self afterDelay:0.1];
    //[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(hitBookedLoadTimeAtFirstTime) userInfo:nil repeats:YES];
    
    
}

#pragma mark view did appear

-(void)viewWillAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self performSelector:@selector(hitBookedLoadTimeAtFirstTime) withObject:self afterDelay:0.1];
        
    });
}
-(void)hitBookedLoadTimeAtFirstTime
{
    pageIndx= 1;
    pageSiz = 100000000;
    self.noMoreResultsAvail =NO;
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //        //code to be executed on the main queue after delay
    //        self.dataArray = [[NSMutableArray alloc]initWithArray:[[Utils getBiddingDataAndPostBid:pageSiz pageIndex:pageIndx] valueForKey:@"loads"]];
    //        [_rTableView reloadData];
    //        [SVProgressHUD dismiss];
    //    });
    
    
    NSLog(@"%@",[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]]);
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"SubscriptionType\":\"%@\",\"Status\":%@,\"TruckRequestStatus\":%@,\"city\":\"%@\",\"PageIndex\":%d,\"PageSize\":%d}",[logDict objectForKey:@"subscriptionId"],[logDict objectForKey:@"subscriptionType"],@"-2",@"0",@"",pageIndx,pageSiz];
    NSLog(@"%@",userUpdate);
    
    
    //Input :{"RateMasterId":33,"pageSize":100,"pageIndex":1}
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
             NSLog(@"the json data is = %@", rsJson);
             
             if (self.dataArray.count != 0)
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

#pragma mark tableview data source method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if([ self.dataArray count] ==0){
        return 0;
    }
    else {
        return [self.dataArray count]+1;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIndentifier =@"RSApprovalTableViewCell";
    
    RSApprovalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
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
            
            [cell.btnCancelLoad   setHidden:NO];
            [cell.btnEditLoad     setHidden:NO];
            [cell.btnDeleteLoad   setHidden:NO];
            [cell.btnFindTruck    setHidden:NO];

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
            [cell.labelToDate setText:
             [Utils convertDateFormate:[Utils returnString:[NSString stringWithFormat:@"%@",
                                                            [[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"pickUpEndDate"] componentsSeparatedByString:@"T"] objectAtIndex:0]]]]];
            [cell.labelStatus setText:[NSString stringWithFormat:@"%@",[Utils returnString:[Utils returnStateOfLoad:[[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"status"] intValue]]]]];
            CGSize size = [cell.labelStatus.text sizeWithAttributes:
                           @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
            cell.labelStatus.frame = CGRectMake(cell.labelStatus.frame.origin.x, cell.labelStatus.frame.origin.y, size.width+5,cell.labelStatus.frame.size.height);
            
            cell.labelStatus.layer.cornerRadius = 5.0;
            cell.labelStatus.layer.masksToBounds = YES;


            [cell.labelTruckType setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"powerUnitType"]]];
            
            cell.rView.layer.cornerRadius = 10.0;
            [cell.bidNowBtn addTarget:self action:@selector(goToBid:) forControlEvents:UIControlEventTouchUpInside];
             cell.bidNowBtn.layer.cornerRadius = 10.0;
            
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
                
                [cell.btnCancelLoad   setHidden:YES];
                [cell.btnEditLoad     setHidden:YES];
                [cell.btnDeleteLoad   setHidden:YES];
                [cell.btnFindTruck    setHidden:YES];

                
                
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
                
                [cell.btnCancelLoad   setHidden:YES];
                [cell.btnEditLoad     setHidden:YES];
                [cell.btnDeleteLoad   setHidden:YES];
                [cell.btnFindTruck    setHidden:YES];

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
-(void)goToBid:(UIButton *)sender
{
//    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
//    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
//    
//    RSLoadDetailsViewController *bidDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"RSLoadDetailsViewController"];
//    bidDetails.receiveDataDict = [self.dataArray objectAtIndex:aIndexPath.row];
//    [self.navigationController pushViewController:bidDetails animated:YES];
    
}
#pragma UIScrollView Method:
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!self.rTableView.tag)
    {
        if (!self.loading) {
            float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
            if (endScrolling >= scrollView.contentSize.height)
            {
                [self performSelector:@selector(loadDataDelayed) withObject:nil afterDelay:1];
            }
        }
        
    }
}

-(void)loadDataDelayed
{
    
    if (self.dataArray.count%10 == 0)
    {
        pageIndx = (int)self.dataArray.count/10;
        pageIndx = ++pageIndx;
    }
    else
    {
        pageIndx = (int)self.dataArray.count/10;
        pageIndx = pageIndx+2;
    }
    NSInteger countBefore = [self.dataArray count];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,NEW_LOAD];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:completeLoginUrlWithSpace]];
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"SubscriptionType\":\"%@\",\"Status\":%@,\"TruckRequestStatus\":%@,\"city\":\"%@\",\"PageIndex\":%d,\"PageSize\":%d}",[logDict objectForKey:@"subscriptionId"],[logDict objectForKey:@"subscriptionType"],@"4",@"4",@"",pageIndx,pageSiz];
    NSLog(@"%@",userUpdate);
    
    NSData *data1 = [userUpdate dataUsingEncoding:NSASCIIStringEncoding];
    [request setHTTPBody:data1];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json"       forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"api_key"] forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (data != nil)
         {
             NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             
             NSData *mData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary* skillDict = [NSJSONSerialization JSONObjectWithData:mData options:0 error:nil];
             NSMutableArray *array = [skillDict objectForKey:@"loads"] ;
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


#pragma mark tableview delegate methods set full width of seperator


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

