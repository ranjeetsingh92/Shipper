//
//  RSDTrackViewController.m
//  Carrier
//
//  Created by QUIKHOP on 10/20/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import "RSDTrackViewController.h"

@interface RSDTrackViewController ()

@end

@implementation RSDTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}
-(void)viewDidAppear:(BOOL)animated
{
    [SVProgressHUD show];
    [self getAllWayToPickupLocationLoad ];
}
-(void)getAllWayToPickupLocationLoad
{
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"ShipmentId\":%@,}",_shipmentId];
    NSLog(@"%@",userUpdate);
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_SHIPMENT_DETAILS];
    
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
             dataArray = [[NSMutableDictionary alloc]initWithDictionary:rsJson];
             NSLog(@"the json data is = %@", rsJson);
             
             if (dataArray.count != 0)
             {
                 [self setShipmentData];
             }
             [SVProgressHUD dismiss];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];
}
#pragma mark set shipment data

-(void)setShipmentData
{
   
    if ([[dataArray valueForKey:@"company"] count] != 0 )
    {
        [self.labelComapnyName setText:[Utils returnString:[[dataArray valueForKey:@"company"] valueForKey:@"companyName"]]];
        [self.labelCompanyMobileNumber setText:[Utils returnString:[[dataArray valueForKey:@"company"] valueForKey:@"phone"]]];
    }
     
    if ([[dataArray valueForKey:@"truck"] count] != 0 )
    {
        [self.labelTruckType setText:[Utils returnString:[[dataArray valueForKey:@"truck"] valueForKey:@"truckType"]]];
        
        [self.labelTRN setText:[Utils returnString:[[dataArray valueForKey:@"truck"]valueForKey:@"truckRegistrationNo"]]];
        [self.labelTruckMaker setText:[Utils returnString:[[dataArray valueForKey:@"truck"]valueForKey:@"truckMake"]]];
        
        [self.labelTruckModel setText:[Utils returnString:[[dataArray valueForKey:@"truck"] valueForKey:@"truckModel"]]];
        [self.labelYearlyPermit setText:[Utils returnString:[[dataArray objectForKey:@"truck"]valueForKey:@"yearlyPermitIssueDate"]]];
        
        [self.labelFiveYearlyPermitDate setText:[Utils returnString:[[dataArray valueForKey:@"truck"]valueForKey:@"fiveYearPermitIssueDate"]]];
        
        [self.labelInsuranceCompanyName setText:[Utils returnString:[[dataArray valueForKey:@"truck"]valueForKey:@"insuranceCompanyName"]]];
        
        [self.labelInsuranceValidityExpitydate setText:[Utils returnString:[[dataArray valueForKey:@"truck"]valueForKey:@"insuranceValidityExpiryDate"]]];

    }
    
    if ([[dataArray valueForKey:@"driver"] count] != 0 )
    {
        [self.labelDriverName setText:[Utils returnString:[[[dataArray valueForKey:@"driver"] objectAtIndex:0]valueForKey:@"firstName"]]];
        [self.labelDriverMobileNo setText:[Utils returnString:[[[dataArray valueForKey:@"driver"] objectAtIndex:0]valueForKey:@"mobileNo"]]];
        [self.labelDriverLicenseExpiry setText:[Utils returnString:[[[dataArray valueForKey:@"driver"] objectAtIndex:0]valueForKey:@"expiryDate"]]];
        [self.labelDriverLicenseIssueDate setText:[Utils returnString:[[[dataArray valueForKey:@"driver"] objectAtIndex:0] valueForKey:@"originCity"]]];
    }
    
    
}

@end
