//
//  RSPickUpLocationTableViewCell.h
//  Carrier
//
//  Created by QUIKHOP on 10/14/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSPickUpLocationTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelFShipmentId;
@property (strong, nonatomic) IBOutlet UILabel *labelFTruckNo;
@property (strong, nonatomic) IBOutlet UILabel *labelFCompanyNmae;
@property (strong, nonatomic) IBOutlet UILabel *labelFComodityName;
@property (strong, nonatomic) IBOutlet UILabel *labelFTotalQuantity;
@property (strong, nonatomic) IBOutlet UILabel *labelFSource;
@property (strong, nonatomic) IBOutlet UILabel *labelFDestination;

@property (strong, nonatomic) IBOutlet UILabel *labelShipmentId;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckNo;
@property (strong, nonatomic) IBOutlet UILabel *labelCompanyNmae;
@property (strong, nonatomic) IBOutlet UILabel *labelComodityName;
@property (strong, nonatomic) IBOutlet UILabel *labelTotalQuantity;
@property (strong, nonatomic) IBOutlet UILabel *labelSource;
@property (strong, nonatomic) IBOutlet UILabel *labelDestination;
@property (strong, nonatomic) IBOutlet UIImageView *greenImageView;
@property (strong, nonatomic) IBOutlet UIImageView *redImageView;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;

@property (strong, nonatomic) IBOutlet UILabel *labelAtPickUpLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelReadyToLoad;
@property (strong, nonatomic) IBOutlet UILabel *labelLoading;
@property (strong, nonatomic) IBOutlet UILabel *labelLoaded;
@property (strong, nonatomic) IBOutlet UILabel *labelReadyToMove;
@property (strong, nonatomic) IBOutlet UILabel *labelDispatch;

@property (strong, nonatomic) IBOutlet UIButton *atPickUpBtn;
@property (strong, nonatomic) IBOutlet UIButton *readyToLoad;
@property (strong, nonatomic) IBOutlet UIButton *loading;
@property (strong, nonatomic) IBOutlet UIButton *loaded;
@property (strong, nonatomic) IBOutlet UIButton *readyToMove;
@property (strong, nonatomic) IBOutlet UIButton *dispatch;

@property (strong, nonatomic) IBOutlet UIView *rView;






@end
