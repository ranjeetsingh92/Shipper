//
//  RSAddNewFunctionalAreaViewController.h
//  Shipper
//
//  Created by QUIKHOP on 7/20/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAddNewFunctionalAreaViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
@property (strong, nonatomic) IBOutlet UITableView *rTableView;

@property (strong, nonatomic) IBOutlet UIButton *selectRegionBtn;
@property (strong, nonatomic) IBOutlet UITextField *textFieldSelectRegion;
- (IBAction)selectRegionBtnPressed:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *textFieldBranch;
@property (strong, nonatomic) IBOutlet UITextField *textFieldDescription;

- (IBAction)submitBtnPressed:(id)sender;
- (IBAction)cancelBtnPressed:(id)sender;

@property (nonatomic, strong)NSDictionary *receiveDataDict;


@end
