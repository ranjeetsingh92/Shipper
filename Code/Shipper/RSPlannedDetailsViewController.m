//
//  RSPlannedDetailsViewController.m
//  Shipper
//
//  Created by QUIKHOP on 7/1/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSPlannedDetailsViewController.h"

@interface RSPlannedDetailsViewController ()

@end

@implementation RSPlannedDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 650)];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [SVProgressHUD show];
    [self setUserData];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [ self.dataArray addObjectsFromArray:[Utils getBidDetails:[self.receiveDataDict valueForKey:@"id"]]];
        if (self.dataArray.count != 0)
        {
            [self setBidData];
        }
        else
        {
            [self hideBidData];
        }
        [self setUserData];
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
-(void)setBidData
{
    [self.bLabelCompanyName setText:@"******"];
    NSNumber *priceValue = (NSNumber *)[[self.dataArray objectAtIndex:0]  valueForKey:@"priceReview"];
    NSInteger imt = [priceValue intValue];
    int actualPriceValue = imt +((imt*10)/100);
    if (actualPriceValue < 1000)
    {
        actualPriceValue = actualPriceValue +1000;
    }
    [self.bLabelBidPrice setText:[NSString stringWithFormat:@"%d",actualPriceValue]];
    [self.bLabelStatus setText:[Utils returnStateOfLoad:[[[self.dataArray objectAtIndex:0]  valueForKey:@"priceStatus"] intValue]]];
    
    CGSize size = [self.bLabelStatus.text sizeWithAttributes:
                   @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
    self.bLabelStatus.frame = CGRectMake(self.bLabelStatus.frame.origin.x, self.bLabelStatus.frame.origin.y, size.width+10,self.bLabelStatus.frame.size.height);
}
-(void)hideBidData

{
    [_bLabelBidPrice setHidden:YES];
    [_bLabelCompanyName setHidden:YES];
    [_bLabelStatus setHidden:YES];
    [_fbLabelCompanyName setHidden:YES];
    [_fbLabelBidPrice setHidden:YES];
    [_fbLabelStatus setHidden:YES];
    
    
    
    
    
    
    
}
@end
