//
//  RSPlannedShowDetailsViewController.m
//  Shipper
//
//  Created by QUIKHOP on 7/1/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSPlannedShowDetailsViewController.h"
#import "RSPlannedTruckDetailsTableViewCell.h"
#import "RSPlannedDriverDetailsTableViewCell.h"

@interface RSPlannedShowDetailsViewController ()
{
    NSMutableArray *truckDriverMobileArray;
    NSMutableArray *driverArray;
    RSPlannedTruckDetailsTableViewCell *truckCell;
    long indexRow;
}

@end

@implementation RSPlannedShowDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    truckDriverMobileArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.rScrollView setContentSize:CGSizeMake(320, 2000)];
    [_rTableView setSeparatorColor:[UIColor clearColor]];
    
    [self setUserData];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    if (truckDriverMobileArray.count == 0)
    {
        [SVProgressHUD show];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            [ truckDriverMobileArray addObjectsFromArray:[Utils getTruckDriverMobileDetails:[[[_receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"loadId"]]];
            driverArray = [[NSMutableArray alloc]initWithArray:[truckDriverMobileArray valueForKey:@"drivers"] ];
            self.rTableView.backgroundColor = [UIColor lightTextColor];
            [_rTableView setFrame:CGRectMake(5, 293, 307, 273+(110*[[driverArray objectAtIndex:0]count]))];
            
            [_rTableView reloadData];
            [SVProgressHUD dismiss];
        });
    }
}

-(void)setLoadData
{
    [self.labelCarrierType setText:[Utils returnString:[_receiveDataDict valueForKey:@"powerUnitType"]]];
    [self.labelCommodity setText:[Utils returnString:[_receiveDataDict valueForKey:@"commodity"]]];
    
    NSString *ads = [NSString stringWithFormat:@"%@, %@ ,%@",
                     [Utils returnString:[[[_receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"fromLocation"]],
                     [Utils returnString:[[[_receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"pickUpCity"]],
                     [Utils returnString:[[[_receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"pickUpState"]]];
    
    [self.labelFromLocation setText:ads];
     NSString *adsToLocation = [NSString stringWithFormat:@"%@, %@ ,%@",
                               [Utils returnString:[[[_receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"toLocation"]],
                               [Utils returnString:[[[_receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"dispatchCity"]],
                               [Utils returnString:[[[_receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"dispatchState"]]];
    
    [self.labelToLocation setText:[Utils returnString:adsToLocation]];
    [self.labelQuantityType setText:[Utils returnString:[_receiveDataDict valueForKey:@"quantityType"]]];
    [self.labelCreatedDate setText:[Utils returnString:[[[_receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"updatedDate"]]];
    
    [self.labelQuantityNumbers setText:[Utils returnString:[_receiveDataDict valueForKey:@"totalQuantityValue"]]];
    
    [self.labelPickUpDate setText:[Utils returnString:[_receiveDataDict valueForKey:@"pickUpStartDate"]]];
    
    [self.labelDispatchDate setText:[Utils returnString:[_receiveDataDict valueForKey:@"pickUpEndDate"]]];
    [self.labelYourOfferPrice setText:[Utils returnString:[_receiveDataDict valueForKey:@"yourOfferPrice"]]];
    [self.labelUpdatedDate setText:[Utils returnString:[_receiveDataDict valueForKey:@"updatedDate"]]];
    [self.labelStatus setText:[Utils returnStateOfLoad:[[Utils returnString:[_receiveDataDict valueForKey:@"status"]] intValue]]];
    CGSize size = [self.labelStatus.text sizeWithAttributes:
                   @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
    self.labelStatus.frame = CGRectMake(self.labelStatus.frame.origin.x, self.labelStatus.frame.origin.y, size.width+5,self.labelStatus.frame.size.height);
}

#pragma mark table view data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _rTableView)
    {
        return [[truckDriverMobileArray valueForKey:@"mobiles"] count];
    }
    else
    {
        return [[driverArray objectAtIndex:0]count];
    }

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _rTableView)
    {
        truckCell = [tableView dequeueReusableCellWithIdentifier:@"RSPlannedTruckDetailsTableViewCell" forIndexPath:indexPath];
        
        
       [truckCell setFrame:CGRectMake(5, 293, 307, 273+(110*[[driverArray objectAtIndex:0]count]))];
        
        [truckCell.labelTruckNo setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[truckDriverMobileArray valueForKey:@"truckRegistrationNo"] objectAtIndex:0] ]]];
        [truckCell.labelTruckType setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[truckDriverMobileArray valueForKey:@"truckType"] objectAtIndex:0]]]];
        [truckCell.labelTruckOriginCity setText:[Utils returnString:[NSString stringWithFormat:@"%@ %@",[[truckDriverMobileArray valueForKey:@"originCity"] objectAtIndex:0],[[truckDriverMobileArray valueForKey:@"state"] objectAtIndex:0]]]];
        [truckCell.labelTruckStatus setText:[NSString stringWithFormat:@"%@",[Utils returnStateOfTruck:[[[truckDriverMobileArray valueForKey:@"status"] objectAtIndex:0]intValue]]]];
        [truckCell.labelTruckId setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[truckDriverMobileArray valueForKey:@"id"] objectAtIndex:0] stringValue]]]];
  
        [truckCell.labelMobileNumber setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[truckDriverMobileArray valueForKey:@"mobiles"] valueForKey:@"mobileNumber"] objectAtIndex:0] ]]];
        [truckCell.labelImeiNo setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[truckDriverMobileArray valueForKey:@"mobiles"] valueForKey:@"imeiNumber"] objectAtIndex:0] ]]];
        [truckCell.lanelBrandName setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[truckDriverMobileArray valueForKey:@"mobiles"] valueForKey:@"brandName"] objectAtIndex:0]]]];
        [truckCell.labelMobileId setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[truckDriverMobileArray valueForKey:@"mobiles"] valueForKey:@"id"] objectAtIndex:0]]]];
        [truckCell.labelNetworkType setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[truckDriverMobileArray valueForKey:@"mobiles"] valueForKey:@"networkType"] objectAtIndex:0]]]];
        indexRow = indexPath.row;
        [truckCell.driverTableView setFrame:CGRectMake(0, 271, 307, 110*[[driverArray objectAtIndex:0] count])];
        [truckCell.driverTableView reloadData];
        
         return truckCell;
    }
    else
    {
        RSPlannedDriverDetailsTableViewCell *driverCell = [tableView dequeueReusableCellWithIdentifier:@"RSPlannedDriverDetailsTableViewCell" forIndexPath:indexPath];

        
        [driverCell.labelName setText:[Utils returnString:[NSString stringWithFormat:@"%@ %@", [Utils returnString:[[[driverArray objectAtIndex:0]objectAtIndex:indexPath.row]objectForKey:@"firstName"]],[Utils returnString:[[[driverArray objectAtIndex:0]objectAtIndex:indexPath.row]objectForKey:@"middleName"]]]]];
        
        [driverCell.labelKnownName setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[driverArray objectAtIndex:0]objectAtIndex:indexPath.row] objectForKey:@"knownName"]]]];
        
        [driverCell.labelState setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[driverArray objectAtIndex:0]objectAtIndex:indexPath.row] objectForKey:@"state"]]]];
        
        [driverCell.labelCity setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[driverArray objectAtIndex:0] objectAtIndex:indexPath.row] objectForKey:@"city"]]]];
        
        [driverCell.labelVllage setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[driverArray objectAtIndex:0]objectAtIndex:indexPath.row] objectForKey:@"village"]]]];

        
        return driverCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (tableView == _rTableView)
    {
      return 273+(110*[[driverArray objectAtIndex:0]count]);
        
    }
    else
    {
        return 110;
    }
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
    
    if ([truckCell.driverTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [truckCell.driverTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([truckCell.driverTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [truckCell.driverTableView setLayoutMargins:UIEdgeInsetsZero];
    }

}




@end
