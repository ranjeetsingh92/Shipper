//
//  RSAddPickUpLocationViewController.h
//  Shipper
//
//  Created by QUIKHOP on 6/28/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAddPickUpLocationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
@property (strong, nonatomic) IBOutlet UITableView *rTableView;

@property (strong, nonatomic) IBOutlet UIButton *btnPackageType;
- (IBAction)btnPackageTypePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPackageType;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLength;
@property (strong, nonatomic) IBOutlet UITextField *textFieldWidth;
@property (strong, nonatomic) IBOutlet UITextField *textFieldHeight;

@property (strong, nonatomic) IBOutlet UIButton *btnPer;
- (IBAction)btnPerPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPer;

@property (strong, nonatomic) IBOutlet UITextField *twxtFieldUnitWeight;

@property (strong, nonatomic) IBOutlet UIButton *btnTypeOfWeight;
- (IBAction)btnTypeOfWeightPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldTypeOfWeight;

@property (strong, nonatomic) IBOutlet UITextField *textFieldUnitOfWeight;

@property (strong, nonatomic) IBOutlet UITextField *textFieldTotal;

- (IBAction)btnTotalPressed:(id)sender;


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

- (IBAction)addMorePickUpLocationPressed:(id)sender;
- (IBAction)addDeliveryLocations:(id)sender;






































@end
