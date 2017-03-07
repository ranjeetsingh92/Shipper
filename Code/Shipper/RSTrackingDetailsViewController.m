//
//  RSTrackingDetailsViewController.m
//  Carrier
//
//  Created by QUIKHOP on 10/24/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import "RSTrackingDetailsViewController.h"
#import "RSTrackingDetailsTableViewCell.h"

@interface RSTrackingDetailsViewController ()

@end

@implementation RSTrackingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated
{
    [SVProgressHUD show];
    [self getTrackingHistoryDetails];
}
-(void)getTrackingHistoryDetails
{
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"ShipmentId\":%@,\"CurrentStatusId\":%@}",_shipmentId,_statusId];
    NSLog(@"%@",userUpdate);
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_TRACKING_DETAILS];
    
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
             self.dataArray = [[NSMutableArray alloc]initWithArray:[rsJson valueForKey:@"trackingHistory"]];
             NSLog(@"the json data is = %@", rsJson);
             
             if (self.dataArray.count != 0)
             {
                 [_trackingHistoryTableView reloadData];
                 
             }
             [SVProgressHUD dismiss];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];
 
}
#pragma mark table view datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSTrackingDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RSTrackingDetailsTableViewCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    [_trackingHistoryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cell.labelSerialNo setText:[NSString stringWithFormat:@"%ld",indexPath.row]];
    
    [cell.labelCurrentStatus setText:[Utils returnString:[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"currentStatus"]]];
    [cell.labelDate setText:[NSString stringWithFormat:@"%@ %@",[Utils returnString:[[[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"statusUpdatedDate"] componentsSeparatedByString:@"T"] objectAtIndex:0]],[Utils returnString:[[[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"statusUpdatedDate"] componentsSeparatedByString:@"T"] objectAtIndex:1]]]];
    [cell.labelUpdatedBy setText:[Utils returnString:[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"updatedBy"]]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92;
}

@end
