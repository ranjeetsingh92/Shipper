//
//  RSTruckListTableViewCell.h
//  Shipper
//
//  Created by QUIKHOP on 7/5/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSTruckListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *btnCheck;
@property (strong, nonatomic) IBOutlet UIImageView *truckImageView;

@property (strong, nonatomic) IBOutlet UILabel *labelTruckId;

@property (strong, nonatomic) IBOutlet UILabel *labelCarrierName;
@property (strong, nonatomic) IBOutlet UILabel *labelCarrierType;
@property (strong, nonatomic) IBOutlet UILabel *labelState;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckMaker;
@property (strong, nonatomic) IBOutlet UILabel *labelCapacity;
@property (strong, nonatomic) IBOutlet UILabel *labelOriginCity;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckType;


@property (strong, nonatomic) IBOutlet UILabel *fLabelTruckId;

@property (strong, nonatomic) IBOutlet UILabel *fLabelCarrierName;
@property (strong, nonatomic) IBOutlet UILabel *fLabelCarrierType;
@property (strong, nonatomic) IBOutlet UILabel *fLabelState;
@property (strong, nonatomic) IBOutlet UILabel *fLabelTruckMaker;
@property (strong, nonatomic) IBOutlet UILabel *fLabelCapacity;
@property (strong, nonatomic) IBOutlet UILabel *fLabelOriginCity;
@property (strong, nonatomic) IBOutlet UILabel *fLabelTruckType;













@end
