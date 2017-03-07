//
//  RSRegionTableViewCell.h
//  Shipper
//
//  Created by QUIKHOP on 7/8/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSRegionTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelregion;
@property (strong, nonatomic) IBOutlet UILabel *labelDescription;
@property (strong, nonatomic) IBOutlet UILabel *labelActive;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedBy;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdatedBy;

@property (strong, nonatomic) IBOutlet UIButton *btnEdit;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;

@property (strong, nonatomic) IBOutlet UILabel *labelFregion;
@property (strong, nonatomic) IBOutlet UILabel *labelFDescription;
@property (strong, nonatomic) IBOutlet UILabel *labelFActive;
@property (strong, nonatomic) IBOutlet UILabel *labelFCreatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelFCreatedBy;
@property (strong, nonatomic) IBOutlet UILabel *labelFUpdatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelFUpdatedBy;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;

@end
