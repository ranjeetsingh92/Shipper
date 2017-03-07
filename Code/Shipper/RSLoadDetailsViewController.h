//
//  RSLoadDetailsViewController.h
//  Shipper
//
//  Created by QUIKHOP on 1/9/17.
//  Copyright © 2017 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSLoadDetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;

@property (strong, nonatomic) IBOutlet UILabel *labelLoadId;
@property (strong, nonatomic) IBOutlet UILabel *labelCarierType;
@property (strong, nonatomic) IBOutlet UILabel *labelFromLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelToLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelPickUpAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelDropAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelClientName;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedBy;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelComodity;
@property (strong, nonatomic) IBOutlet UILabel *labelFQuantityType;

@property (strong, nonatomic) IBOutlet UILabel *labelTotalQuantity;
@property (strong, nonatomic) IBOutlet UILabel *labelPickUpDate;
@property (strong, nonatomic) IBOutlet UILabel *labelDispatchDate;
@property (strong, nonatomic) IBOutlet UILabel *labelYourOfferPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdatedBy;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelFStatus;

@property(nonatomic, strong)NSDictionary *receiveDataDict;

@end
