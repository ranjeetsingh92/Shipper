//
//  RSUserTableViewCell.h
//  Shipper
//
//  Created by QUIKHOP on 7/8/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSUserTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelUser;
@property (strong, nonatomic) IBOutlet UILabel *labelMobile;
@property (strong, nonatomic) IBOutlet UILabel *labelEmailId;
@property (strong, nonatomic) IBOutlet UILabel *labelState;
@property (strong, nonatomic) IBOutlet UILabel *labelCity;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelRole;
@property (strong, nonatomic) IBOutlet UILabel *labelRegion;
@property (strong, nonatomic) IBOutlet UILabel *labelBranch;
@property (strong, nonatomic) IBOutlet UILabel *labelDepartment;
@property (strong, nonatomic) IBOutlet UILabel *labelFunctionalArea;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedBy;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdatedBy;

@property (strong, nonatomic) IBOutlet UIButton *btnEdit;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;


@property (strong, nonatomic) IBOutlet UILabel *labelFUser;
@property (strong, nonatomic) IBOutlet UILabel *labelFMobile;
@property (strong, nonatomic) IBOutlet UILabel *labelFEmailId;
@property (strong, nonatomic) IBOutlet UILabel *labelFState;
@property (strong, nonatomic) IBOutlet UILabel *labelFCity;
@property (strong, nonatomic) IBOutlet UILabel *labelFCreatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelFRole;
@property (strong, nonatomic) IBOutlet UILabel *labelFRegion;
@property (strong, nonatomic) IBOutlet UILabel *labelFBranch;
@property (strong, nonatomic) IBOutlet UILabel *labelFDepartment;
@property (strong, nonatomic) IBOutlet UILabel *labelFFunctionalArea;
@property (strong, nonatomic) IBOutlet UILabel *labelFCreatedBy;
@property (strong, nonatomic) IBOutlet UILabel *labelFUpdatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelFUpdatedBy;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;













@end
