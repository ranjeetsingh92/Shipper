//
//  RSInTransitViewController.m
//  Carrier
//
//  Created by QUIKHOP on 10/12/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import "RSInTransitViewController.h"
#import "RSWay2PickTableViewCell.h"

@interface RSInTransitViewController ()
{
    int pageIndx ;
    int pageSiz ;
}


@end

@implementation RSInTransitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray =[[NSMutableArray alloc] init];
    [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [SVProgressHUD show];
    [self performSelector:@selector(getAllWayToPickupLocationLoad) withObject:nil afterDelay:0.0];
    
}
-(void)getAllWayToPickupLocationLoad
{
    self.noMoreResultsAvail =NO;
    pageIndx= 1;
    pageSiz = 5;
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"pageIndex\":%d,\"pageSize\":%d,\"Status\":%@,\"SubscriptionType\":\"%@\",\"WorkingSubscriptionType\":\"%@\"}",[[Utils getLogingDict] objectForKey:@"subscriptionId"],pageIndx,pageSiz,@"12",[[Utils getLogingDict] objectForKey:@"subscriptionType"],@""];
    NSLog(@"%@",userUpdate);
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,INTRANSIT];
    
    //{"SubscriptionId":60097,"PageIndex":1,"PageSize":5,"Status":7,"SubscriptionType":"carrier","WorkingSubscriptionType":""}
    
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
             self.dataArray = [[NSMutableArray alloc]initWithArray:[rsJson valueForKey:@"loads"]];
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
- (IBAction)leftBarBtnPressed:(id)sender
{
    [self.revealViewController revealToggle:self];
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
    
    
    static NSString *cellIndentifier =@"RSWay2PickTableViewCell";
    
    RSWay2PickTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (self.dataArray.count != 0) {
        if(indexPath.row <[self.dataArray count]){
            
            [cell.bgImageView setHidden:NO];
            [cell.labelFLoadId setHidden:NO];
            [cell.labelFTruckNo setHidden:NO];
            [cell.labelFComanyName setHidden:NO];
            [cell.labelFComodity setHidden:NO];
            [cell.labelFQuantity setHidden:NO];
            [cell.labelFCurrentStatus setHidden:NO];
            [cell.labelFDistance setHidden:NO];
            
            [cell.labelLoadId setHidden:NO];
            [cell.labelTruckNo setHidden:NO];
            [cell.labelComanyName setHidden:NO];
            [cell.labelComodity setHidden:NO];
            [cell.labelQuantity setHidden:NO];
            [cell.labelCurrentStatus setHidden:NO];
            [cell.labelFCovered setHidden:NO];
            
            [cell.labelFRemaining setHidden:NO];
            [cell.labelFTotal setHidden:NO];
            [cell.labelCovered setHidden:NO];
            [cell.labelRemaining setHidden:NO];
            [cell.labelTotal setHidden:NO];
            [cell.rSlider setHidden:NO];
            [cell.labelRSourceStation setHidden:NO];
            [cell.labelRDestinationStation setHidden:NO];
            [cell.detailBtn setHidden:NO];
            [cell.geenLocationImageView setHidden:NO];
            [cell.redLocationImageView setHidden:NO];
            
            [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            
            [cell.labelLoadId setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"fromPickUpLocation"]objectAtIndex:0]valueForKey:@"loadId"]]]];
            [cell.labelTruckNo setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"truckNumber"]]];
            [cell.labelComanyName setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"companyName"]]];
            [cell.labelComodity setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"commodity"]]];
            [cell.labelQuantity setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"totalQuantityValue"]]];
            [cell.labelCurrentStatus setText:[Utils returnString:[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"currentLocation"]]];
            
            
            [cell.labelCovered setText:[NSString stringWithFormat:@"%@ Km in %@ Hrs.",[Utils returnString:[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"reachedDistance"]],[Utils returnString:[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"reachedHrs"]]]];
            
            [cell.labelRemaining setText:[NSString stringWithFormat:@"%@ Km in %@ Hrs.",[Utils returnString:[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"remainingDistance"]],[Utils returnString:[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"remaingHrs"]]]];
            
            [cell.labelTotal setText:[NSString stringWithFormat:@"%@ Km in %@ Hrs.",[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"totalDistance"],[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"totalHrs"]]];
            
            [cell.rSlider setUserInteractionEnabled:NO];
            [cell.rSlider setMaximumValue:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"totalDistance"] floatValue]];
            [cell.rSlider setMinimumValue:0];
            [cell.rSlider setValue:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"reachedDistance"] floatValue]];
            
            [cell.labelRSourceStation setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"fromPickUpLocation"]objectAtIndex:0]valueForKey:@"pickUpCity"]]]];
            
            [cell.labelRDestinationStation setText:[NSString stringWithFormat:@"%@/%@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"toPickUpLocation"]objectAtIndex:0]valueForKey:@"dispatchCity"]] ,[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"clientName"]]]];
            
            [cell.rSlider addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.rSlider setThumbImage:[UIImage imageNamed:@"track_truck.png"] forState:UIControlStateNormal];
           
            [cell.detailBtn addTarget:self action:@selector(detailBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            if (!self.noMoreResultsAvail) {
                spinner.hidden =YES;
                
                [cell.bgImageView setHidden:YES];
                [cell.labelFLoadId setHidden:YES];
                [cell.labelFTruckNo setHidden:YES];
                [cell.labelFComanyName setHidden:YES];
                [cell.labelFComodity setHidden:YES];
                [cell.labelFQuantity setHidden:YES];
                [cell.labelFCurrentStatus setHidden:YES];
                [cell.labelFDistance setHidden:YES];
                
                [cell.labelLoadId setHidden:YES];
                [cell.labelTruckNo setHidden:YES];
                [cell.labelComanyName setHidden:YES];
                [cell.labelComodity setHidden:YES];
                [cell.labelQuantity setHidden:YES];
                [cell.labelCurrentStatus setHidden:YES];
                [cell.labelFCovered setHidden:YES];
                
                [cell.labelFRemaining setHidden:YES];
                [cell.labelFTotal setHidden:YES];
                [cell.labelCovered setHidden:YES];
                [cell.labelRemaining setHidden:YES];
                [cell.labelTotal setHidden:YES];
                [cell.rSlider setHidden:YES];
                [cell.labelRSourceStation setHidden:YES];
                [cell.labelRDestinationStation setHidden:YES];
                [cell.detailBtn setHidden:YES];
                [cell.geenLocationImageView setHidden:YES];
                [cell.redLocationImageView setHidden:YES];
                
                spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                spinner.frame = CGRectMake(150, 10, 24, 50);
                spinner.color = [UIColor colorWithRed:153.0/255 green:0.0/255 blue:0.0/255 alpha:1];
                [cell addSubview:spinner];
                if ([self.dataArray count] >= 5)
                {
                    
                    [spinner startAnimating];
                    
                }
            }
            else{
                [spinner stopAnimating];
                spinner.hidden=YES;
                
                [cell.bgImageView setHidden:YES];
                [cell.labelFLoadId setHidden:YES];
                [cell.labelFTruckNo setHidden:YES];
                [cell.labelFComanyName setHidden:YES];
                [cell.labelFComodity setHidden:YES];
                [cell.labelFQuantity setHidden:YES];
                [cell.labelFCurrentStatus setHidden:YES];
                [cell.labelFDistance setHidden:YES];
                
                [cell.labelLoadId setHidden:YES];
                [cell.labelTruckNo setHidden:YES];
                [cell.labelComanyName setHidden:YES];
                [cell.labelComodity setHidden:YES];
                [cell.labelQuantity setHidden:YES];
                [cell.labelCurrentStatus setHidden:YES];
                [cell.labelFCovered setHidden:YES];
                
                [cell.labelFRemaining setHidden:YES];
                [cell.labelFTotal setHidden:YES];
                [cell.labelCovered setHidden:YES];
                [cell.labelRemaining setHidden:YES];
                [cell.labelTotal setHidden:YES];
                [cell.rSlider setHidden:YES];
                [cell.labelRSourceStation setHidden:YES];
                [cell.labelRDestinationStation setHidden:YES];
                [cell.detailBtn setHidden:YES];
                [cell.geenLocationImageView setHidden:YES];
                [cell.redLocationImageView setHidden:YES];
            }
        }
    }
    return cell;
}

#pragma mark slider Action

-(void)showDetails:(UIButton *)sender
{
    
}
-(void)detailBtnPressed:(UIButton *)sender
{
    
}
#pragma UIScrollView Method::
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
    // array = (NSMutableArray *)[Utils hitPlanned:pageIndx pageSize:pageSiz];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"pageIndex\":%d,\"pageSize\":%d,\"Status\":%@,\"SubscriptionType\":\"%@\",\"WorkingSubscriptionType\":\"%@\"}",[[Utils getLogingDict] objectForKey:@"subscriptionId"],pageIndx,pageSiz,@"12",[[Utils getLogingDict] objectForKey:@"subscriptionType"],@""];
    NSLog(@"%@",userUpdate);
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,INTRANSIT];
    
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
#pragma mark full width separator

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
