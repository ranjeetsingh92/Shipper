//
//  RSAddLoadViewController.h
//  Shipper
//
//  Created by QUIKHOP on 1/16/17.
//  Copyright © 2017 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAddLoadViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

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

@property (strong, nonatomic) IBOutlet UITextField *textFieldbtnNumbetOfQuantity;

@property (strong, nonatomic) IBOutlet UIButton *btnSelectUnit;
- (IBAction)btnSelectUnitPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldSelectUnit;

@property (strong, nonatomic) IBOutlet UIButton *btnSpecificRequirement;
- (IBAction)btnSpecificRequirementPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldSpecificRequirement;


- (IBAction)startDatePressed:(id)sender;
- (IBAction)endDate:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnStartDate;
@property (strong, nonatomic) IBOutlet UIButton *btnEndDate;

@property (strong, nonatomic) IBOutlet UITextField *testFieldStartDate;
@property (strong, nonatomic) IBOutlet UITextField *textFieldEndDate;


#pragma mark add pick up location

@property (strong, nonatomic) IBOutlet UITableView *rPTableView;

@property (strong, nonatomic) IBOutlet UIButton *btnPackageType;
- (IBAction)btnPackageTypePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPackageType;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLength;
@property (strong, nonatomic) IBOutlet UITextField *textFieldWidth;
@property (strong, nonatomic) IBOutlet UITextField *textFieldHeight;

@property (strong, nonatomic) IBOutlet UIButton *btnPer;
-(IBAction)btnPerPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPer;

@property (strong, nonatomic) IBOutlet UITextField *twxtFieldUnitWeight;

@property (strong, nonatomic) IBOutlet UIButton *btnTypeOfWeight;
-(IBAction)btnTypeOfWeightPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldTypeOfWeight;

@property (strong, nonatomic) IBOutlet UITextField *textFieldUnitOfWeight;

@property (strong, nonatomic) IBOutlet UITextField *textFieldTotal;

- (IBAction)btnTotalPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnTotal;


@property (strong, nonatomic) IBOutlet UIButton *btnState;
- (IBAction)btnStatePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldState;

@property (strong, nonatomic) IBOutlet UIButton *btnCity;
- (IBAction)btnCityPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldCity;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLocalAddress;

- (IBAction)btnLocalAddressPressed:(id)sender;

@property (strong, nonatomic) IBOutlet MKMapView *rMapView;

@property (strong, nonatomic) IBOutlet UILabel *labelLatLong;
- (IBAction)saveBtnPressed:(id)sender;




#pragma mark add delivery location


@property (strong, nonatomic) IBOutlet UITableView *rDTableView;

@property (strong, nonatomic) IBOutlet UITextField *textFieldWeightOfUnitWeight;

@property (strong, nonatomic) IBOutlet UIButton *btnTypeOfDWeight;
- (IBAction)btnTypeOfDWeightPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldTypeOfDWeight;

@property (strong, nonatomic) IBOutlet UITextField *textFieldUnitOfDUnitWeight;

@property (strong, nonatomic) IBOutlet UITextField *textFieldDTotal;
- (IBAction)btnDTotalPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnDTotal;

@property (strong, nonatomic) IBOutlet UIButton *btnDState;
- (IBAction)btnDStatePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldDState;

@property (strong, nonatomic) IBOutlet UIButton *btnSelectDClientInfo;
- (IBAction)btnSelectDClientInfoPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldSelectClientInfo;

@property (strong, nonatomic) IBOutlet UIButton *btnDCity;
- (IBAction)btnDCityPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldDCity;


@property (strong, nonatomic) IBOutlet UITextField *textFieldDLocalAddress;
- (IBAction)btnDSearchLocalAddressPressed:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *rDMapView;

@property (strong, nonatomic) IBOutlet UILabel *labelDLatLong;

- (IBAction)labeLDSaveBtnPressed:(id)sender;

- (IBAction)btnDSaveLoadPressed:(id)sender;

@property(nonatomic, strong)NSDictionary *receiveDatDict;




@end
