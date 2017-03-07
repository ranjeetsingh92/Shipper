//
//  RSRequestedMainTableViewCell.h
//  Shipper
//
//  Created by QUIKHOP on 7/7/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSRequestedMainTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *tImageView;
@property (strong, nonatomic) IBOutlet UILabel *labelTCompany;
@property (strong, nonatomic) IBOutlet UILabel *labeltruckType;
@property (strong, nonatomic) IBOutlet UILabel *labelCity;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckStatus;

@end
