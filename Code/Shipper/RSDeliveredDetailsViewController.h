//
//  RSDeliveredDetailsViewController.h
//  Carrier
//
//  Created by QUIKHOP on 10/17/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSDeliveredDetailsViewController : UIViewController

// company details

@property (strong, nonatomic) IBOutlet UILabel *labelFId;
@property (strong, nonatomic) IBOutlet UILabel *labelFCompanyName;
@property (strong, nonatomic) IBOutlet UILabel *labelFMobileAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelFAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelFEmail;

@property (strong, nonatomic) IBOutlet UILabel *labelId;
@property (strong, nonatomic) IBOutlet UILabel *labelCompanyName;
@property (strong, nonatomic) IBOutlet UILabel *labelMobileAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelEmail;

// truck details

@property (strong, nonatomic) IBOutlet UILabel *labelFTruckId;
@property (strong, nonatomic) IBOutlet UILabel *labelFTRN;
@property (strong, nonatomic) IBOutlet UILabel *labelFBrand;
@property (strong, nonatomic) IBOutlet UILabel *labelFTruckType;
@property (strong, nonatomic) IBOutlet UILabel *labelFCity;

@property (strong, nonatomic) IBOutlet UILabel *labelTruckId;
@property (strong, nonatomic) IBOutlet UILabel *labelTRN;
@property (strong, nonatomic) IBOutlet UILabel *labelBrand;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckType;
@property (strong, nonatomic) IBOutlet UILabel *labelCity;


// truck details

@property (strong, nonatomic) IBOutlet UILabel *labelFMobileId;
@property (strong, nonatomic) IBOutlet UILabel *labelFMobileBrand;
@property (strong, nonatomic) IBOutlet UILabel *labelFMobileNumber;
@property (strong, nonatomic) IBOutlet UILabel *labelFMobileIMEI;
@property (strong, nonatomic) IBOutlet UILabel *labelFMobileNetwork;

@property (strong, nonatomic) IBOutlet UILabel *labelMobileId;
@property (strong, nonatomic) IBOutlet UILabel *labelMobileBrand;
@property (strong, nonatomic) IBOutlet UILabel *labelMobileNumber;
@property (strong, nonatomic) IBOutlet UILabel *labelMobileIMEI;
@property (strong, nonatomic) IBOutlet UILabel *labelMobileNetwork;

// Driver Details

@property (strong, nonatomic) IBOutlet UILabel *labelFDriverId;
@property (strong, nonatomic) IBOutlet UILabel *labelFDriverBrand;
@property (strong, nonatomic) IBOutlet UILabel *labelFDriverNumber;
@property (strong, nonatomic) IBOutlet UILabel *labelFDriverIMEI;
@property (strong, nonatomic) IBOutlet UILabel *labelFDriverNetwork;

@property (strong, nonatomic) IBOutlet UILabel *labelDriverId;
@property (strong, nonatomic) IBOutlet UILabel *labelDriverFirstName;
@property (strong, nonatomic) IBOutlet UILabel *labelDriverLastName;
@property (strong, nonatomic) IBOutlet UILabel *labelDriverCity;
@property (strong, nonatomic) IBOutlet UILabel *labelDriverMobileNo;

@property(nonatomic, strong)NSString *loadId;





































@end
