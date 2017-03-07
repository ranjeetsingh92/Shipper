//
//  RSWay2PickTableViewCell.h
//  Carrier
//
//  Created by QUIKHOP on 10/13/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSWay2PickTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;

@property (strong, nonatomic) IBOutlet UILabel *labelFLoadId;
@property (strong, nonatomic) IBOutlet UILabel *labelFTruckNo;
@property (strong, nonatomic) IBOutlet UILabel *labelFComanyName;
@property (strong, nonatomic) IBOutlet UILabel *labelFComodity;
@property (strong, nonatomic) IBOutlet UILabel *labelFQuantity;
@property (strong, nonatomic) IBOutlet UILabel *labelFCurrentStatus;
@property (strong, nonatomic) IBOutlet UILabel *labelFDistance;

@property (strong, nonatomic) IBOutlet UIButton *detailBtn;

@property (strong, nonatomic) IBOutlet UILabel *labelLoadId;
@property (strong, nonatomic) IBOutlet UILabel *labelTruckNo;
@property (strong, nonatomic) IBOutlet UILabel *labelComanyName;
@property (strong, nonatomic) IBOutlet UILabel *labelComodity;
@property (strong, nonatomic) IBOutlet UILabel *labelQuantity;
@property (strong, nonatomic) IBOutlet UILabel *labelCurrentStatus;

@property (strong, nonatomic) IBOutlet UILabel *labelFCovered;
@property (strong, nonatomic) IBOutlet UILabel *labelFRemaining;
@property (strong, nonatomic) IBOutlet UILabel *labelFTotal;

@property (strong, nonatomic) IBOutlet UILabel *labelCovered;
@property (strong, nonatomic) IBOutlet UILabel *labelRemaining;
@property (strong, nonatomic) IBOutlet UILabel *labelTotal;

@property (strong, nonatomic) IBOutlet UISlider *rSlider;


@property (strong, nonatomic) IBOutlet UILabel *labelRSourceStation;

@property (strong, nonatomic) IBOutlet UILabel *labelRDestinationStation;
@property (strong, nonatomic) IBOutlet UIImageView *geenLocationImageView;

@property (strong, nonatomic) IBOutlet UIImageView *redLocationImageView;
@end
