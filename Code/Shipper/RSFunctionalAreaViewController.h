//
//  RSFunctionalAreaViewController.h
//  Shipper
//
//  Created by QUIKHOP on 6/24/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSFunctionalAreaViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UIActivityIndicatorView *spinner;
    
}

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic) BOOL noMoreResultsAvail;
@property (nonatomic) BOOL loading;
@property (strong, nonatomic) IBOutlet UITableView *rTableView;
@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;

- (IBAction)addNewFunctionality:(id)sender;

- (IBAction)leftBarButtonPressed:(id)sender;
@end
