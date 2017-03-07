//
//  RSAddDelieveryLocationViewController.h
//  Shipper
//
//  Created by QUIKHOP on 6/28/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAddDelieveryLocationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
@property (strong, nonatomic) IBOutlet UITableView *rTableView;

@property (strong, nonatomic) IBOutlet UITextField *textFieldWeightOfUnitWeight;

@property (strong, nonatomic) IBOutlet UIButton *btnTypeOfWeight;
- (IBAction)btnTypeOfWeightPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldTypeOfWeight;

@property (strong, nonatomic) IBOutlet UITextField *textFieldUnitOfUnitWeight;

@property (strong, nonatomic) IBOutlet UITextField *textFieldTotal;
- (IBAction)btnTotalPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnState;
- (IBAction)btnStatePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldState;

@property (strong, nonatomic) IBOutlet UIButton *btnSelectClientInfo;
- (IBAction)btnSelectClientInfoPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldSelectClientInfo;

@property (strong, nonatomic) IBOutlet UIButton *btnCity;
- (IBAction)btnCityPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldCity;


@property (strong, nonatomic) IBOutlet UITextField *textFieldLocalAddress;
- (IBAction)btnSearchLocalAddressPressed:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *rMapView;

@property (strong, nonatomic) IBOutlet UILabel *labelLatLong;

- (IBAction)labeLSaveBtnPressed:(id)sender;

- (IBAction)addMoreDeliveryLocationPressed:(id)sender;

- (IBAction)savbtnSaveLoadPressed:(id)sender;









@end
