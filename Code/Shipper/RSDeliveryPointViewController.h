//
//  RSDeliveryPointViewController.h
//  Carrier
//
//  Created by QUIKHOP on 10/12/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSDeliveryPointViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UIActivityIndicatorView *spinner;
    
}

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic) BOOL noMoreResultsAvail;
@property (nonatomic) BOOL loading;

@property (strong, nonatomic) IBOutlet UITableView *rTableView;

- (IBAction)leftBarBtnPressed:(id)sender;
@end
