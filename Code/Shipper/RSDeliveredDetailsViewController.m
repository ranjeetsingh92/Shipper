//
//  RSDeliveredDetailsViewController.m
//  Carrier
//
//  Created by QUIKHOP on 10/17/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import "RSDeliveredDetailsViewController.h"

@interface RSDeliveredDetailsViewController ()
{
    NSMutableDictionary *truckMobileDriverDataDict;
}

@end

@implementation RSDeliveredDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(getAllWayToPickupLocationLoad) withObject:nil afterDelay:0.0];
}

-(void)getAllWayToPickupLocationLoad
{
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"LoadId\":%@}",[[Utils getLogingDict] objectForKey:@"subscriptionId"],_loadId];
    NSLog(@"%@",userUpdate);
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_COMPANY_DRIVER_MOBILE_TRUCK];
    
    //{"LoadId":50345,"SubscriptionId":60097}
    
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
             truckMobileDriverDataDict = [[NSMutableDictionary alloc]initWithDictionary:[[rsJson valueForKey:@"truckDriverMobile"] objectAtIndex:0]];
             NSLog(@"the json data is = %@", rsJson);
             if (truckMobileDriverDataDict.count !=0)
             {
                 [self setContentData];
             }
             else
             {
                 
             }
             [SVProgressHUD dismiss];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];
    
}
-(void)setContentData
{

    // company details
    
    [self.labelId setText:[NSString stringWithFormat:@"%@",[Utils returnString:[truckMobileDriverDataDict objectForKey:@"id"]]]];
    [self.labelCompanyName setText:[Utils returnString:[[truckMobileDriverDataDict objectForKey:@"company"] valueForKey:@"companyName"]]];
    [self.labelMobileAddress setText:[Utils returnString:[[truckMobileDriverDataDict objectForKey:@"mobiles"] valueForKey:@"mobileNumber"]]];
    [self.labelAddress setText:[Utils returnString:[[truckMobileDriverDataDict objectForKey:@"company"] valueForKey:@"companyAddress"]]];
    [self.labelEmail setText:[Utils returnString:[[truckMobileDriverDataDict objectForKey:@"company"] valueForKey:@"emailId"]]];
    
    // truck details
    
    [self.labelTruckId setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[truckMobileDriverDataDict objectForKey
                                                                                       :@"drivers"] objectAtIndex:0] valueForKey:@"truckId"]]]];
    [self.labelTRN setText:[Utils returnString:[[truckMobileDriverDataDict valueForKey:@"truckDriverMobile"] valueForKey:@"truckRegistrationNo"]]];
    [self.labelBrand setText:[Utils returnString:[truckMobileDriverDataDict valueForKey:@"truckMake"] ]];
    [self.labelTruckType setText:[Utils returnString:[truckMobileDriverDataDict valueForKey:@"truckType"]]];
    [self.labelCity setText:[Utils returnString:[truckMobileDriverDataDict valueForKey:@"originCity"] ]];
    
    // truck details

    
    [self.labelMobileId setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[truckMobileDriverDataDict valueForKey:@"mobiles"] valueForKey:@"id"]]]];
    [self.labelMobileBrand setText:[Utils returnString:[[truckMobileDriverDataDict valueForKey:@"mobiles"] valueForKey:@"brandName"]]];
    [self.labelMobileNumber setText:[Utils returnString:[[truckMobileDriverDataDict valueForKey:@"mobiles"] valueForKey:@"mobileNumber"]]];
    [self.labelMobileIMEI setText:[Utils returnString:[[truckMobileDriverDataDict valueForKey:@"mobiles"] valueForKey:@"imeiNumber"]]];
    [self.labelMobileNetwork setText:[Utils returnString:[[truckMobileDriverDataDict valueForKey:@"mobiles"] valueForKey:@"networkType"]]];

    
   //  Driver Details
    
    [self.labelDriverId setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[truckMobileDriverDataDict valueForKey:@"drivers"] objectAtIndex:0] valueForKey:@"id"]]]];
    [self.labelDriverFirstName setText:[Utils returnString:[[[truckMobileDriverDataDict valueForKey:@"drivers"] objectAtIndex:0]valueForKey:@"firstName"]]];
    [self.labelDriverLastName setText:[Utils returnString:[[[truckMobileDriverDataDict valueForKey:@"drivers"] objectAtIndex:0] valueForKey:@"middleName"]]];
    [self.labelDriverCity setText:[Utils returnString:[[[truckMobileDriverDataDict valueForKey:@"drivers"] objectAtIndex:0]valueForKey:@"issuedFromCity"]]];
    [self.labelDriverMobileNo setText:[Utils returnString:[[[truckMobileDriverDataDict valueForKey:@"drivers"] objectAtIndex:0] valueForKey:@"mobileNo"]]];

}
@end
