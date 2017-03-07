//
//  RSBookedBiddingDetailsViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/30/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSBookedBiddingDetailsViewController.h"
#import "RSBiddingDetailsTableViewCell.h"

@interface RSBookedBiddingDetailsViewController ()
{
    NSMutableArray *dataArray;
}

@end

@implementation RSBookedBiddingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [SVProgressHUD show];
    [self setUserData];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [ dataArray addObjectsFromArray:[Utils getBidDetails:[self.receiveDataDict valueForKey:@"id"]]];
        self.rTableView.backgroundColor = [UIColor lightTextColor];
        [_rTableView reloadData];
        [SVProgressHUD dismiss];
    });
    
}
-(void)setUserData
{
    [self.labelCarrierType setText:[Utils returnString:[self.receiveDataDict valueForKey:@"powerUnitType"]]];
    [self.labelCommodity setText:[Utils returnString:[self.receiveDataDict valueForKey:@"commodity"]]];
    
    NSString *ads = [NSString stringWithFormat:@"%@, %@ ,%@",
                     [Utils returnString:[[[self.receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"fromLocation"]],
                     [Utils returnString:[[[self.receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"pickUpCity"]],
                     [Utils returnString:[[[self.receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"pickUpState"]]];
    
    [self.labelFromLocation setText:ads];
    
    
    
    
    NSString *adsToLocation = [NSString stringWithFormat:@"%@, %@ ,%@",
                               [Utils returnString:[[[self.receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"toLocation"]],
                               [Utils returnString:[[[self.receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"dispatchCity"]],
                               [Utils returnString:[[[self.receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"dispatchState"]]];
    
    [self.labelToLocation setText:[Utils returnString:adsToLocation]];
    [self.labelQuantityType setText:[Utils returnString:[self.receiveDataDict valueForKey:@"quantityType"]]];
    [self.labelCreatedDate setText:[Utils returnString:[[[self.receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"updatedDate"]]];
    
    [self.labelQuantityNumbers setText:[Utils returnString:[self.receiveDataDict valueForKey:@"totalQuantityValue"]]];
    
    [self.labelPickUpDate setText:[Utils returnString:[self.receiveDataDict valueForKey:@"pickUpStartDate"]]];
    
    [self.labelDispatchDate setText:[Utils returnString:[self.receiveDataDict valueForKey:@"pickUpEndDate"]]];
    [self.labelYourOfferPrice setText:[Utils returnString:[self.receiveDataDict valueForKey:@"yourOfferPrice"]]];
    [self.labelUpdatedDate setText:[Utils returnString:[self.receiveDataDict valueForKey:@"updatedDate"]]];
    [self.labelStatus setText:[Utils returnStateOfLoad:[[Utils returnString:[self.receiveDataDict valueForKey:@"status"]] intValue]]];
    
    CGSize size = [self.labelStatus.text sizeWithAttributes:
                   @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
    self.labelStatus.frame = CGRectMake(self.labelStatus.frame.origin.x, self.labelStatus.frame.origin.y, size.width+5,self.labelStatus.frame.size.height);
}

#pragma mark table view data source method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSBiddingDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RSBiddingDetailsTableViewCell" forIndexPath:indexPath];
    
    [cell.labelCompanyName setText:@"******"];
    NSNumber *priceValue = (NSNumber *)[[dataArray objectAtIndex:indexPath.row] valueForKey:@"priceReview"];
    NSInteger imt = [priceValue intValue];
    int actualPriceValue = imt +((imt*10)/100);
    if (actualPriceValue < 1000)
    {
        actualPriceValue = actualPriceValue +1000;
    }
    [cell.labelBidPrice setText:[NSString stringWithFormat:@"%d",actualPriceValue]];
    [cell.labelStatus setText:[Utils returnStateOfLoad:[[[dataArray objectAtIndex:indexPath.row] valueForKey:@"priceStatus"] intValue]]];
    
    CGSize size = [cell.labelStatus.text sizeWithAttributes:
                   @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
    cell.labelStatus.frame = CGRectMake(cell.labelStatus.frame.origin.x, cell.labelStatus.frame.origin.y, size.width+10,cell.labelStatus.frame.size.height);
    
    return cell;
}

@end
