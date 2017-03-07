//
//  RSPickUpLocationViewController.m
//  Carrier
//
//  Created by QUIKHOP on 10/12/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import"RSPickUpLocationViewController.h"
#import"RSPickUpLocationTableViewCell.h"
#import "RSTrackingDetailsViewController.h"

@interface RSPickUpLocationViewController ()
{
    int pageIndx ;
    int pageSiz ;
    RSPickUpLocationTableViewCell *cell;
}
@end

@implementation RSPickUpLocationViewController

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
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"pageIndex\":%d,\"pageSize\":%d,\"SubscriptionType\":\"%@\",\"WorkingSubscriptionType\":\"%@\"}",[[Utils getLogingDict] objectForKey:@"subscriptionId"],pageIndx,pageSiz,[[Utils getLogingDict] objectForKey:@"subscriptionType"],@""];
    NSLog(@"%@",userUpdate);
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,RSPICKUPLOCATION];
    
    //{"SubscriptionId":60097,"PageIndex":1,"PageSize":5,"SubscriptionType":"carrier","WorkingSubscriptionType":""}
    
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
    
    
    static NSString *cellIndentifier =@"RSPickUpLocationTableViewCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (self.dataArray.count != 0) {
        if(indexPath.row <[self.dataArray count]){
   
            [cell.labelFShipmentId setHidden:NO];
            [cell.labelFTruckNo setHidden:NO];
            [cell.labelFCompanyNmae setHidden:NO];
            [cell.labelFComodityName setHidden:NO];
            [cell.labelFTotalQuantity setHidden:NO];
            [cell.labelFSource setHidden:NO];
            [cell.labelFDestination setHidden:NO];
            [cell.labelShipmentId setHidden:NO];
            [cell.labelTruckNo setHidden:NO];
            [cell.labelCompanyNmae setHidden:NO];
            
            [cell.labelComodityName setHidden:NO];
            [cell.labelTotalQuantity setHidden:NO];
            [cell.labelSource setHidden:NO];
            [cell.labelDestination setHidden:NO];
            [cell.greenImageView setHidden:NO];
            
            [cell.redImageView setHidden:NO];
            [cell.bgImageView setHidden:NO];
            [cell.rView setHidden:NO];
            
            [cell.labelAtPickUpLocation setHidden:NO];
            [cell.atPickUpBtn setHidden:NO];
            
            [cell.labelReadyToLoad setHidden:NO];
            [cell.readyToLoad setHidden:NO];
            
            [cell.labelLoading setHidden:NO];
            [cell.loading setHidden:NO];
            
            [cell.labelLoaded setHidden:NO];
            [cell.loaded setHidden:NO];
            
            [cell.labelReadyToMove setHidden:NO];
            [cell.readyToMove setHidden:NO];
            
            [cell.labelDispatch setHidden:NO];
            [cell.dispatch setHidden:NO];
            
            [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            
            [cell.labelShipmentId setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"id"]]]];
            [cell.labelTruckNo setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"truckNumber"]]];
            
            [cell.labelCompanyNmae setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"companyName"]]];
            [cell.labelComodityName setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"commodity"]]];
            [cell.labelTotalQuantity setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"totalQuantityValue"]]];
            [cell.labelSource setText:[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"fromPickUpLocation"] objectAtIndex:0]objectForKey:@"fromLocation"]]];
            [cell.labelDestination setText:[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"toPickUpLocation"] objectAtIndex:0]objectForKey:@"toLocation"]]];
            
            [cell.atPickUpBtn addTarget:self action:@selector(detailsAtPickUpLocation:) forControlEvents:UIControlEventTouchUpInside];
            [cell.readyToLoad addTarget:self action:@selector(detailsAtreadyToLoadLocation:) forControlEvents:UIControlEventTouchUpInside];
            [cell.loading addTarget:self action:@selector(detailsAtLoadingLocation:) forControlEvents:UIControlEventTouchUpInside];
            [cell.loaded addTarget:self action:@selector(detailsAtLoadedLocation:) forControlEvents:UIControlEventTouchUpInside];
            [cell.readyToMove addTarget:self action:@selector(detailsAtReadyToMoveLocation:) forControlEvents:UIControlEventTouchUpInside];
            [cell.dispatch addTarget:self action:@selector(detailsAtDispatchLocation:) forControlEvents:UIControlEventTouchUpInside];

            
            switch ([[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] valueForKey:@"currentStatusId"]count])
            {
                case 2:
                     [self showTwoPoint];
                    break;
                case 3:
                   [self showThreePoint];
                    break;
                case 4:
                     [self showFourPoint];
                    break;
                case 5:
                   [self showFivePoint];
                    break;
                case 6:
                    [self showSixPoint] ;
                    break;

                    
                default:
                     [self showOnePoint];
                    break;
            }
            
            
//            [cell.labelCovered setText:[NSString stringWithFormat:@"%@ Km in %@ Hrs.",[Utils returnString:[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"reachedDistance"]],[Utils returnString:[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"reachedHrs"]]]];
//            
//            [cell.labelRemaining setText:[NSString stringWithFormat:@"%@ Km in %@ Hrs.",[Utils returnString:[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"remainingDistance"]],[Utils returnString:[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"remaingHrs"]]]];
//            
//            [cell.labelTotal setText:[NSString stringWithFormat:@"%@ Km in %@ Hrs.",[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"totalDistance"],[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"totalHrs"]]];
//            
//            [cell.rSlider setUserInteractionEnabled:NO];
//            [cell.rSlider setMaximumValue:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"totalDistance"] floatValue]];
//            [cell.rSlider setMinimumValue:0];
//            [cell.rSlider setValue:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"shipmentDetailsResponse"] objectForKey:@"reachedDistance"] floatValue]];
//            
//            [cell.labelRSourceStation setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"fromPickUpLocation"]objectAtIndex:0]valueForKey:@"pickUpCity"]]]];
//            
//            [cell.labelRDestinationStation setText:[NSString stringWithFormat:@"%@/%@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"toPickUpLocation"]objectAtIndex:0]valueForKey:@"dispatchCity"]] ,[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"clientName"]]]];
//            [cell.rSlider setThumbImage:[UIImage imageNamed:@"track_truck.png"] forState:UIControlStateNormal];
//            [cell.rSlider addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.detailBtn addTarget:self action:@selector(detailBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            if (!self.noMoreResultsAvail) {
                spinner.hidden =YES;
                
                [cell.labelFShipmentId setHidden:YES];
                [cell.labelFTruckNo setHidden:YES];
                [cell.labelFCompanyNmae setHidden:YES];
                [cell.labelFComodityName setHidden:YES];
                [cell.labelFTotalQuantity setHidden:YES];
                [cell.labelFSource setHidden:YES];
                [cell.labelFDestination setHidden:YES];
                [cell.labelShipmentId setHidden:YES];
                [cell.labelTruckNo setHidden:YES];
                [cell.labelCompanyNmae setHidden:YES];
                
                [cell.labelComodityName setHidden:YES];
                [cell.labelTotalQuantity setHidden:YES];
                [cell.labelSource setHidden:YES];
                [cell.labelDestination setHidden:YES];
                [cell.greenImageView setHidden:YES];
                
                [cell.redImageView setHidden:YES];
                [cell.bgImageView setHidden:YES];
                [cell.rView setHidden:YES];
                
                [cell.labelAtPickUpLocation setHidden:YES];
                [cell.atPickUpBtn setHidden:YES];
                
                [cell.labelReadyToLoad setHidden:YES];
                [cell.readyToLoad setHidden:YES];
                
                [cell.labelLoading setHidden:YES];
                [cell.loading setHidden:YES];
                
                [cell.labelLoaded setHidden:YES];
                [cell.loaded setHidden:YES];
                
                [cell.labelReadyToMove setHidden:YES];
                [cell.readyToMove setHidden:YES];
                
                [cell.labelDispatch setHidden:YES];
                [cell.dispatch setHidden:YES];

                
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
                
                [cell.labelFShipmentId setHidden:YES];
                [cell.labelFTruckNo setHidden:YES];
                [cell.labelFCompanyNmae setHidden:YES];
                [cell.labelFComodityName setHidden:YES];
                [cell.labelFTotalQuantity setHidden:YES];
                [cell.labelFSource setHidden:YES];
                [cell.labelFDestination setHidden:YES];
                [cell.labelShipmentId setHidden:YES];
                [cell.labelTruckNo setHidden:YES];
                [cell.labelCompanyNmae setHidden:YES];
                
                [cell.labelComodityName setHidden:YES];
                [cell.labelTotalQuantity setHidden:YES];
                [cell.labelSource setHidden:YES];
                [cell.labelDestination setHidden:YES];
                [cell.greenImageView setHidden:YES];
                
                [cell.redImageView setHidden:YES];
                [cell.bgImageView setHidden:YES];
                [cell.rView setHidden:YES];
                
                [cell.labelAtPickUpLocation setHidden:YES];
                [cell.atPickUpBtn setHidden:YES];
                
                [cell.labelReadyToLoad setHidden:YES];
                [cell.readyToLoad setHidden:YES];
                
                [cell.labelLoading setHidden:YES];
                [cell.loading setHidden:YES];
                
                [cell.labelLoaded setHidden:YES];
                [cell.loaded setHidden:YES];
                
                [cell.labelReadyToMove setHidden:YES];
                [cell.readyToMove setHidden:YES];
                
                [cell.labelDispatch setHidden:YES];
                [cell.dispatch setHidden:YES];
            }
        }
    }
    return cell;
}
#pragma mark show tracking points details
-(void)detailsAtPickUpLocation:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    RSTrackingDetailsViewController *trackingDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"RSTrackingDetailsViewController"];
    trackingDetails.shipmentId = [[self.dataArray objectAtIndex:aIndexPath.row] valueForKey:@"id"];
    trackingDetails.statusId = @"6";
    [self.navigationController pushViewController:trackingDetails animated:YES];
 }
-(void)detailsAtreadyToLoadLocation:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    RSTrackingDetailsViewController *trackingDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"RSTrackingDetailsViewController"];
    trackingDetails.shipmentId = [[self.dataArray objectAtIndex:aIndexPath.row] valueForKey:@"id"];
    trackingDetails.statusId = @"7";
    [self.navigationController pushViewController:trackingDetails animated:YES];
}
-(void)detailsAtLoadingLocation:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    RSTrackingDetailsViewController *trackingDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"RSTrackingDetailsViewController"];
    trackingDetails.shipmentId = [[self.dataArray objectAtIndex:aIndexPath.row] valueForKey:@"id"];
    trackingDetails.statusId = @"8";
    [self.navigationController pushViewController:trackingDetails animated:YES];
}
-(void)detailsAtLoadedLocation:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    RSTrackingDetailsViewController *trackingDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"RSTrackingDetailsViewController"];
    trackingDetails.shipmentId = [[self.dataArray objectAtIndex:aIndexPath.row] valueForKey:@"id"];
    trackingDetails.statusId = @"9";
    [self.navigationController pushViewController:trackingDetails animated:YES];
}
-(void)detailsAtReadyToMoveLocation:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    RSTrackingDetailsViewController *trackingDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"RSTrackingDetailsViewController"];
    trackingDetails.shipmentId = [[self.dataArray objectAtIndex:aIndexPath.row] valueForKey:@"id"];
    trackingDetails.statusId = @"10";
    [self.navigationController pushViewController:trackingDetails animated:YES];
}
-(void)detailsAtDispatchLocation:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    RSTrackingDetailsViewController *trackingDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"RSTrackingDetailsViewController"];
    trackingDetails.shipmentId = [[self.dataArray objectAtIndex:aIndexPath.row] valueForKey:@"id"];
    trackingDetails.statusId = @"11";
    [self.navigationController pushViewController:trackingDetails animated:YES];
}
-(void)showOnePoint
{
    [cell.labelAtPickUpLocation setHidden:NO];
    [cell.atPickUpBtn setHidden:NO];
    
    [cell.labelReadyToLoad setHidden:YES];
    [cell.readyToLoad setHidden:YES];
    
    [cell.labelLoading setHidden:YES];
    [cell.loading setHidden:YES];
    
    [cell.labelLoaded setHidden:YES];
    [cell.loaded setHidden:YES];
    
    [cell.labelReadyToMove setHidden:YES];
    [cell.readyToMove setHidden:YES];
    
    [cell.labelDispatch setHidden:YES];
    [cell.dispatch setHidden:YES];
}

-(void)showTwoPoint
{
    [cell.labelAtPickUpLocation setHidden:NO];
    [cell.atPickUpBtn setHidden:NO];
    
    [cell.labelReadyToLoad setHidden:NO];
    [cell.readyToLoad setHidden:NO];
    
    [cell.labelLoading setHidden:YES];
    [cell.loading setHidden:YES];
    
    [cell.labelLoaded setHidden:YES];
    [cell.loaded setHidden:YES];
    
    [cell.labelReadyToMove setHidden:YES];
    [cell.readyToMove setHidden:YES];
    
    [cell.labelDispatch setHidden:YES];
    [cell.dispatch setHidden:YES];
}
-(void)showThreePoint
{
    [cell.labelAtPickUpLocation setHidden:NO];
    [cell.atPickUpBtn setHidden:NO];
    
    [cell.labelReadyToLoad setHidden:NO];
    [cell.readyToLoad setHidden:NO];
    
    [cell.labelLoading setHidden:NO];
    [cell.loading setHidden:NO];
    
    [cell.labelLoaded setHidden:YES];
    [cell.loaded setHidden:YES];
    
    [cell.labelReadyToMove setHidden:YES];
    [cell.readyToMove setHidden:YES];
    
    [cell.labelDispatch setHidden:YES];
    [cell.dispatch setHidden:YES];
}
-(void)showFourPoint
{
    [cell.labelAtPickUpLocation setHidden:NO];
    [cell.atPickUpBtn setHidden:NO];
    
    [cell.labelReadyToLoad setHidden:NO];
    [cell.readyToLoad setHidden:NO];
    
    [cell.labelLoading setHidden:NO];
    [cell.loading setHidden:NO];
    
    [cell.labelLoaded setHidden:NO];
    [cell.loaded setHidden:NO];
    
    [cell.labelReadyToMove setHidden:YES];
    [cell.readyToMove setHidden:YES];
    
    [cell.labelDispatch setHidden:YES];
    [cell.dispatch setHidden:YES];
}
-(void)showFivePoint
{
    [cell.labelAtPickUpLocation setHidden:NO];
    [cell.atPickUpBtn setHidden:NO];
    
    [cell.labelReadyToLoad setHidden:NO];
    [cell.readyToLoad setHidden:NO];
    
    [cell.labelLoading setHidden:NO];
    [cell.loading setHidden:NO];
    
    [cell.labelLoaded setHidden:NO];
    [cell.loaded setHidden:NO];
    
    [cell.labelReadyToMove setHidden:NO];
    [cell.readyToMove setHidden:NO];
    
    [cell.labelDispatch setHidden:YES];
    [cell.dispatch setHidden:YES];
}

-(void)showSixPoint
{
    [cell.labelAtPickUpLocation setHidden:NO];
    [cell.atPickUpBtn setHidden:NO];
    
    [cell.labelReadyToLoad setHidden:NO];
    [cell.readyToLoad setHidden:NO];
    
    [cell.labelLoading setHidden:NO];
    [cell.loading setHidden:NO];
    
    [cell.labelLoaded setHidden:NO];
    [cell.loaded setHidden:NO];
    
    [cell.labelReadyToMove setHidden:NO];
    [cell.readyToMove setHidden:NO];
    
    [cell.labelDispatch setHidden:NO];
    [cell.dispatch setHidden:NO];
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
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"pageIndex\":%d,\"pageSize\":%d,\"SubscriptionType\":\"%@\",\"WorkingSubscriptionType\":\"%@\"}",[[Utils getLogingDict] objectForKey:@"subscriptionId"],pageIndx,pageSiz,[[Utils getLogingDict] objectForKey:@"subscriptionType"],@""];
    NSLog(@"%@",userUpdate);
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,RSPICKUPLOCATION];
    
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
