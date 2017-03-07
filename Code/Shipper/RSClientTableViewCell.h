//
//  RSClientTableViewCell.h
//  Shipper
//
//  Created by QUIKHOP on 7/8/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSClientTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelClientName;
@property (strong, nonatomic) IBOutlet UILabel *labelPhone;
@property (strong, nonatomic) IBOutlet UILabel *labelComapnyAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelContactPersona;
@property (strong, nonatomic) IBOutlet UILabel *labelContactNo;
@property (strong, nonatomic) IBOutlet UILabel *labelSecondaryContactPerson;
@property (strong, nonatomic) IBOutlet UILabel *labelSecondaryContactNo;
@property (strong, nonatomic) IBOutlet UILabel *labelPan;
@property (strong, nonatomic) IBOutlet UILabel *labelTan;
@property (strong, nonatomic) IBOutlet UILabel *labelStn;
@property (strong, nonatomic) IBOutlet UILabel *labelCin;
@property (strong, nonatomic) IBOutlet UILabel *labelState;
@property (strong, nonatomic) IBOutlet UILabel *labelCity;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedDate;

@property (strong, nonatomic) IBOutlet UIButton *btnEdit;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;

@property (strong, nonatomic) IBOutlet UILabel *labelFClientName;
@property (strong, nonatomic) IBOutlet UILabel *labelFPhone;
@property (strong, nonatomic) IBOutlet UILabel *labelFComapnyAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelFContactPersona;
@property (strong, nonatomic) IBOutlet UILabel *labelFContactNo;
@property (strong, nonatomic) IBOutlet UILabel *labelFSecondaryContactPerson;
@property (strong, nonatomic) IBOutlet UILabel *labelFSecondaryContactNo;
@property (strong, nonatomic) IBOutlet UILabel *labelFPan;
@property (strong, nonatomic) IBOutlet UILabel *labelFTan;
@property (strong, nonatomic) IBOutlet UILabel *labelFStn;
@property (strong, nonatomic) IBOutlet UILabel *labelFCin;
@property (strong, nonatomic) IBOutlet UILabel *labelFState;
@property (strong, nonatomic) IBOutlet UILabel *labelFCity;
@property (strong, nonatomic) IBOutlet UILabel *labelFCreatedDate;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;

@end
