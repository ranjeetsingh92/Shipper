//
//  RSRequestedSubTableViewCell.h
//  Shipper
//
//  Created by QUIKHOP on 7/7/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSRequestedSubTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelCarrierComapny;
@property (strong, nonatomic) IBOutlet UILabel *labelTrukMaker;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckType;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckModel;
@property (strong, nonatomic) IBOutlet UILabel *labelCarrierType;
@property (strong, nonatomic) IBOutlet UILabel *labelCapacity;
@property (strong, nonatomic) IBOutlet UILabel *labelState;
@property (strong, nonatomic) IBOutlet UILabel *labelOriginCity;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;
@property (strong, nonatomic) IBOutlet UILabel *labelFstatus;
@end
