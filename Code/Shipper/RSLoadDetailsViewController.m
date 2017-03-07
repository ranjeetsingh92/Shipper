//
//  RSLoadDetailsViewController.m
//  Shipper
//
//  Created by QUIKHOP on 1/9/17.
//  Copyright © 2017 QUIKHOP. All rights reserved.
//

#import "RSLoadDetailsViewController.h"

@interface RSLoadDetailsViewController ()

@end

@implementation RSLoadDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_rScrollView setContentSize:CGSizeMake(320, 700)];
    
    if (self.receiveDataDict != nil)
    {
        [self setUserData];
    }
}
-(void)setUserData
{
    if (([_receiveDataDict objectForKey:@"fromPickUpLocation"] != nil)&& [[_receiveDataDict objectForKey:@"fromPickUpLocation"] count] != 0)
    {
        [self.labelLoadId setText:[NSString stringWithFormat:@"Load Id # %@",[Utils returnString:[[[_receiveDataDict objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"id"]]]];
        [self.labelFromLocation setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[_receiveDataDict objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"pickUpCity"]]]];
        [self.labelPickUpAddress setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[_receiveDataDict objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"fromLocation"]]]];
        [self.labelUpdatedBy setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[_receiveDataDict objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"updatedBy"]]]];

    }
    if (([_receiveDataDict objectForKey:@"fromPickUpLocation"] != [NSNull null])&& [[_receiveDataDict objectForKey:@"fromPickUpLocation"] count] != 0)
    {
        [self.labelToLocation setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[_receiveDataDict objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"toLocation"]]]];
        [self.labelDropAddress setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[_receiveDataDict objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"dispatchCity"]]]];
        [self.labelClientName setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[_receiveDataDict objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"clientMasterName"]]]];
        [self.labelCreatedBy setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[_receiveDataDict objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"createdBy"]]]];
        [self.labelUpdatedDate setText:[NSString stringWithFormat:@"%@",[Utils convertDateFormate:[Utils returnString:[[[[[_receiveDataDict objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"updatedDate"] componentsSeparatedByString:@"T"] objectAtIndex:0]]]]];
  
    }
    
    [self.labelCarierType setText:[NSString stringWithFormat:@"%@",[Utils returnString:[_receiveDataDict objectForKey:@"powerUnitType"] ]]];
    
    [self.labelCreatedDate setText:[NSString stringWithFormat:@"%@",[Utils convertDateFormate:[Utils returnString:[[[_receiveDataDict objectForKey:@"createdDate"] componentsSeparatedByString:@"T"] objectAtIndex:0]]]]];

    [self.labelComodity setText:[NSString stringWithFormat:@"%@",[Utils returnString:[_receiveDataDict objectForKey:@"commodity"] ]]];
    
    [self.labelFQuantityType setText:[NSString stringWithFormat:@"%@",[Utils returnString:[_receiveDataDict objectForKey:@"quantityType"] ]]];
    
    [self.labelTotalQuantity setText:[NSString stringWithFormat:@"%@",[Utils returnString:[_receiveDataDict objectForKey:@"totalQuantityValue"] ]]];

    [self.labelPickUpDate setText:[NSString stringWithFormat:@"%@",[Utils convertDateFormate:[Utils returnString:[[[_receiveDataDict objectForKey:@"pickUpStartDate"] componentsSeparatedByString:@"T"] objectAtIndex:0]]]]];
    
    [self.labelDispatchDate setText:[NSString stringWithFormat:@"%@",[Utils convertDateFormate:[Utils returnString:[[[_receiveDataDict objectForKey:@"pickUpEndDate"] componentsSeparatedByString:@"T"] objectAtIndex:0]]]]];
    
    [self.labelYourOfferPrice setText:[NSString stringWithFormat:@"%@",[Utils returnString:[_receiveDataDict objectForKey:@"yourOfferPrice"] ]]];
    
    [self.labelFStatus setText:[NSString stringWithFormat:@"%@",[Utils returnStateOfLoad:[[_receiveDataDict objectForKey:@"status"] intValue]]]];
    CGSize size = [self.labelFStatus.text sizeWithAttributes:
                   @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
   self.labelFStatus.frame = CGRectMake(self.labelFStatus.frame.origin.x, self.labelFStatus.frame.origin.y, size.width+10,self.labelFStatus.frame.size.height);

}

@end
