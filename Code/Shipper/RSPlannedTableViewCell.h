//
//  RSPlannedTableViewCell.h
//  Shipper
//
//  Created by QUIKHOP on 6/29/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSPlannedTableViewCell : UITableViewCell



@property (strong, nonatomic) IBOutlet UILabel *labelCarrierType;
@property (strong, nonatomic) IBOutlet UILabel *labelCommodity;
@property (strong, nonatomic) IBOutlet UILabel *labelFromLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelToLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelQuantityType;
@property (strong, nonatomic) IBOutlet UILabel *labelQuantityNumbers;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelPickUpDate;
@property (strong, nonatomic) IBOutlet UILabel *labelDispatchDate;
@property (strong, nonatomic) IBOutlet UILabel *labelYourOfferPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;

@property (strong, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (strong, nonatomic) IBOutlet UILabel *fLabelCarrierType;
@property (strong, nonatomic) IBOutlet UILabel *fLabelCommodity;
@property (strong, nonatomic) IBOutlet UILabel *fLabelFromLocation;
@property (strong, nonatomic) IBOutlet UILabel *fLabelToLocation;
@property (strong, nonatomic) IBOutlet UILabel *fLabelQuantityType;
@property (strong, nonatomic) IBOutlet UILabel *fLabelQuantityNumbers;
@property (strong, nonatomic) IBOutlet UILabel *fLabelCreatedDate;
@property (strong, nonatomic) IBOutlet UILabel *fLabelPickUpDate;
@property (strong, nonatomic) IBOutlet UILabel *fLabelDispatchDate;
@property (strong, nonatomic) IBOutlet UILabel *fLabelYourOfferPrice;
@property (strong, nonatomic) IBOutlet UILabel *fLabelUpdatedDate;
@property (strong, nonatomic) IBOutlet UILabel *fLabelStatus;

// bidding detail label
@property (strong, nonatomic) IBOutlet UILabel *bLebelCompany;
@property (strong, nonatomic) IBOutlet UILabel *bLebelBidPrice;
@property (strong, nonatomic) IBOutlet UILabel *bLebelStatus;
@property (strong, nonatomic) IBOutlet UILabel *fBLebelCompany;
@property (strong, nonatomic) IBOutlet UILabel *fBLebelBidPrice;
@property (strong, nonatomic) IBOutlet UILabel *fBLebelStatus;
@property (strong, nonatomic) IBOutlet UIButton *btnAssignTruck;

















@end
