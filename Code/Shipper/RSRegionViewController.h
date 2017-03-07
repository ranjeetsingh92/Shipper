//
//  RSRegionViewController.h
//  Shipper
//
//  Created by QUIKHOP on 6/24/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSRegionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UIActivityIndicatorView *spinner;
    
}

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic) BOOL noMoreResultsAvail;
@property (nonatomic) BOOL loading;





- (IBAction)leftBarButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *rTableView;
@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
- (IBAction)addNewRegioBtnPressed:(id)sender;


@end
