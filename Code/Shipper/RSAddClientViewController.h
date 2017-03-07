//
//  RSAddClientViewController.h
//  Shipper
//
//  Created by QUIKHOP on 7/15/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RSAddClientViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
@property (strong, nonatomic) IBOutlet UITableView *rTableView;
@property (strong, nonatomic) IBOutlet UITextField *textFieldCompanyName;
@property (strong, nonatomic) IBOutlet UITextField *textFieldEwbAddress;
@property (strong, nonatomic) IBOutlet UITextField *textFieldMobileNo;
@property (strong, nonatomic) IBOutlet UITextField *textFieldFax;

@property (strong, nonatomic) IBOutlet UITextField *textFieldState;
@property (strong, nonatomic) IBOutlet UIButton *btnState;
- (IBAction)btnStatePressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *textFieldCity;
@property (strong, nonatomic) IBOutlet UIButton *btnCity;
- (IBAction)btnCityPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *textFieldAssociateMember;
@property (strong, nonatomic) IBOutlet UITextField *rexrFieldPostalCode;
@property (strong, nonatomic) IBOutlet UITextField *textFieldCompanyAddress;

- (IBAction)searchBtnPressed:(id)sender;

@property (strong, nonatomic) IBOutlet MKMapView *rMapView;

@property (strong, nonatomic) IBOutlet UITextField *textFieldCinNo;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPanNo;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldTanNo;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldSTNo;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldContactPerson1;
@property (strong, nonatomic) IBOutlet UITextField *textFieldContactNumber1;
@property (strong, nonatomic) IBOutlet UITextField *textFieldContactPerson2;
@property (strong, nonatomic) IBOutlet UITextField *textFieldContactNumber2;


@property(nonatomic, strong)NSDictionary *receiveDataDict;

- (IBAction)submitBtnPressed:(id)sender;
- (IBAction)resetBtnPressed:(id)sender;























@end
