//
//  RSTrackingDetailsViewController.h
//  Carrier
//
//  Created by QUIKHOP on 10/24/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSTrackingDetailsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *trackingHistoryTableView;


@property(nonatomic, strong)NSString *shipmentId;
@property(nonatomic, strong)NSString *statusId;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
