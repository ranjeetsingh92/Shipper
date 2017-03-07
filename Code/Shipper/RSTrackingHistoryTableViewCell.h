//
//  RSTrackingHistoryTableViewCell.h
//  Carrier
//
//  Created by QUIKHOP on 10/21/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSTrackingHistoryTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelSerialNo;
@property (strong, nonatomic) IBOutlet UILabel *labelCurrentCity;
@property (strong, nonatomic) IBOutlet UILabel *labelCurrentStatus;
@property (strong, nonatomic) IBOutlet UILabel *labelDesription;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdatedBy;

@end
