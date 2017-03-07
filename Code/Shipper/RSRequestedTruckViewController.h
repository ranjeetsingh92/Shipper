//
//  RSRequestedTruckViewController.h
//  Shipper
//
//  Created by QUIKHOP on 7/7/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSRequestedTruckViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableIndexSet *expandedSections;
    UIActivityIndicatorView *spinner;
    
}
@property(nonatomic, strong)NSDictionary *receiveDataDict;


@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic) BOOL noMoreResultsAvail;
@property (nonatomic) BOOL loading;


@property (strong, nonatomic) IBOutlet UILabel *labelComodityAndQuantity;
@property (strong, nonatomic) IBOutlet UILabel *labelCompany;
@property (strong, nonatomic) IBOutlet UILabel *labelQuantityType;
@property (strong, nonatomic) IBOutlet UILabel *LabelPickupState;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedState;
@property (strong, nonatomic) IBOutlet UILabel *labelLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
@property (strong, nonatomic) IBOutlet UITableView *rTableView;

@end
