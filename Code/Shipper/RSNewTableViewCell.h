//
//  RSNewTableViewCell.h
//  Shipper
//
//  Created by QUIKHOP on 6/28/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSNewTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *fLabelCommodity;
@property (strong, nonatomic) IBOutlet UILabel *fLabelLocation;
@property (strong, nonatomic) IBOutlet UILabel *fLabelCreatedDate;
@property (strong, nonatomic) IBOutlet UILabel *fLabelPickUpDate;
@property (strong, nonatomic) IBOutlet UILabel *fLabelDispatchDate;
@property (strong, nonatomic) IBOutlet UILabel *fLabelOffer;
@property (strong, nonatomic) IBOutlet UILabel *fLabelStatus;



@property (strong, nonatomic) IBOutlet UILabel *labelCommodity;
@property (strong, nonatomic) IBOutlet UILabel *labelLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelPickUpDate;
@property (strong, nonatomic) IBOutlet UILabel *labelDispatchDate;
@property (strong, nonatomic) IBOutlet UILabel *labelOffer;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;
@property (strong, nonatomic) IBOutlet UIButton *findTruckBtn;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;

@end
