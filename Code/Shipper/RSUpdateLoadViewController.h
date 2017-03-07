//
//  RSUpdateLoadViewController.h
//  Shipper
//
//  Created by QUIKHOP on 6/28/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPickUpLocationTableViewCell.h"
#import "RSDeliveryLocationTableViewCell.h"

@interface RSUpdateLoadViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *rTableView;

@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
@property (strong, nonatomic) IBOutlet UIDatePicker *rDatePicker;

@property (strong, nonatomic) IBOutlet UIButton *btnCarrierType;
- (IBAction)btnCarrierTypePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldCarrierType;

@property (strong, nonatomic) IBOutlet UIButton *btnComodity;
- (IBAction)btnComodityPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldComodity;

@property (strong, nonatomic) IBOutlet UIButton *btnOfferPrice;
- (IBAction)btnOfferPricePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldOfferPrice;

@property (strong, nonatomic) IBOutlet UIButton *btnQuantity;
- (IBAction)btnCarrierQuantityPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldQuantity;

@property (strong, nonatomic) IBOutlet UIButton *btnNumbetOfQuantity;
- (IBAction)btnbtnNumbetOfQuantityPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldbtnNumbetOfQuantity;

@property (strong, nonatomic) IBOutlet UIButton *btnSelectUnit;
- (IBAction)btnSelectUnitPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldSelectUnit;

@property (strong, nonatomic) IBOutlet UIButton *btnSpecificRequirement;
- (IBAction)btnSpecificRequirementPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldSpecificRequirement;

- (IBAction)btnAddPickUpLocationPressed:(id)sender;

- (IBAction)startDatePressed:(id)sender;
- (IBAction)endDate:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnStartDate;
@property (strong, nonatomic) IBOutlet UIButton *btnEndDate;

@property (strong, nonatomic) IBOutlet UITextField *testFieldStartDate;
@property (strong, nonatomic) IBOutlet UITextField *textFieldEndDate;

@end
