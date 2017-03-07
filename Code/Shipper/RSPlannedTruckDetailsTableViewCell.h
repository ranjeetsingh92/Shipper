//
//  RSPlannedTruckDetailsTableViewCell.h
//  Shipper
//
//  Created by QUIKHOP on 7/1/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSPlannedTruckDetailsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelTruckId;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckNo;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckType;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckOriginCity;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckStatus;


@property (strong, nonatomic) IBOutlet UILabel *labelMobileNumber;
@property (strong, nonatomic) IBOutlet UILabel *labelImeiNo;
@property (strong, nonatomic) IBOutlet UILabel *lanelBrandName;
@property (strong, nonatomic) IBOutlet UILabel *labelMobileId;
@property (strong, nonatomic) IBOutlet UILabel *labelNetworkType;


@property (strong, nonatomic) IBOutlet UITableView *driverTableView;








@end
