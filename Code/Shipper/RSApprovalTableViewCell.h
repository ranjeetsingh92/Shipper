//
//  RSApprovalTableViewCell.h
//  Shipper
//
//  Created by QUIKHOP on 1/6/17.
//  Copyright © 2017 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSApprovalTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *clabelCommodityInfo;
@property (strong, nonatomic) IBOutlet UILabel *labelLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelDate;
@property (strong, nonatomic) IBOutlet UILabel *labelOfferPrice;

@property (strong, nonatomic) IBOutlet UILabel *labelLoadId;
@property (strong, nonatomic) IBOutlet UILabel *labelToLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelToDate;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckType;

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *labelDropOff;
@property (strong, nonatomic) IBOutlet UILabel *fLabelOfferPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelPickUp;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;

@property (strong, nonatomic) IBOutlet UIImageView *redArrowImageView;
@property (strong, nonatomic) IBOutlet UIImageView *truckIconImageView;
@property (strong, nonatomic) IBOutlet UIView *rView;
@property (strong, nonatomic) IBOutlet UIImageView *leftArrowImageView;

@property (strong, nonatomic) IBOutlet UIButton *bidNowBtn;

@property (strong, nonatomic) IBOutlet UIButton *btnCancelLoad;
@property (strong, nonatomic) IBOutlet UIButton *btnEditLoad;
@property (strong, nonatomic) IBOutlet UIButton *btnDeleteLoad;
@property (strong, nonatomic) IBOutlet UIButton *btnFindTruck;
@property (strong, nonatomic) IBOutlet UIButton *btnShowDetails;



@end
