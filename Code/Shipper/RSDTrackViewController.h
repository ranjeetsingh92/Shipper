//
//  RSDTrackViewController.h
//  Carrier
//
//  Created by QUIKHOP on 10/20/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSDTrackViewController : UIViewController
{
    NSMutableDictionary *dataArray;
}
// company details

@property (strong, nonatomic) IBOutlet UILabel *labelComapnyName;
@property (strong, nonatomic) IBOutlet UILabel *labelCompanyMobileNumber;

// truck Details

@property (strong, nonatomic) IBOutlet UILabel *labelTruckType;
@property (strong, nonatomic) IBOutlet UILabel *labelTRN;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckMaker;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckModel;
@property (strong, nonatomic) IBOutlet UILabel *labelYearlyPermit;
@property (strong, nonatomic) IBOutlet UILabel *labelFiveYearlyPermitDate;
@property (strong, nonatomic) IBOutlet UILabel *labelInsuranceCompanyName;
@property (strong, nonatomic) IBOutlet UILabel *labelInsuranceValidityExpitydate;

// Driver Details

@property (strong, nonatomic) IBOutlet UILabel *labelDriverName;
@property (strong, nonatomic) IBOutlet UILabel *labelDriverMobileNo;
@property (strong, nonatomic) IBOutlet UILabel *labelDriverLicenseExpiry;
@property (strong, nonatomic) IBOutlet UILabel *labelDriverLicenseIssueDate;

@property(nonatomic, strong)NSString *shipmentId;










@end
