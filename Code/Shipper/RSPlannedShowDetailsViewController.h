//
//  RSPlannedShowDetailsViewController.h
//  Shipper
//
//  Created by QUIKHOP on 7/1/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSPlannedShowDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>




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

@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
@property(nonatomic, strong)NSDictionary *receiveDataDict;
@property (strong, nonatomic) IBOutlet UITableView *rTableView;

// truck details










@end
