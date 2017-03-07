//
//  RSRequestTableViewCell.h
//  Carrier
//
//  Created by QUIKHOP on 5/23/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSRequestTableViewCell : UITableViewCell




@property (strong, nonatomic) IBOutlet UILabel *labelComodityAndQuantity;
@property (strong, nonatomic) IBOutlet UILabel *labelCompany;
@property (strong, nonatomic) IBOutlet UILabel *labelQuantityType;
@property (strong, nonatomic) IBOutlet UILabel *LabelPickupState;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedState;
@property (strong, nonatomic) IBOutlet UILabel *labelLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;
@property (strong, nonatomic) IBOutlet UILabel *status;

@property (strong, nonatomic) IBOutlet UIButton *btnRequestSent;
@property (strong, nonatomic) IBOutlet UIButton *btnFindtruck;










@end
