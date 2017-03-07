//
//  RSApprovalViewController.h
//  Shipper
//
//  Created by QUIKHOP on 1/6/17.
//  Copyright © 2017 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSApprovalViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UIActivityIndicatorView *spinner;
    
}

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic) BOOL noMoreResultsAvail;
@property (nonatomic) BOOL loading;

@property (strong, nonatomic) IBOutlet UITableView *rTableView;



@end
