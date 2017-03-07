//
//  RSAddNewUserViewController.h
//  Shipper
//
//  Created by QUIKHOP on 7/20/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAddNewUserViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
@property (strong, nonatomic) IBOutlet UITableView *rTableView;
@property (strong, nonatomic) IBOutlet UITableView *pTableView;



@property (strong, nonatomic) IBOutlet UITextField *textFieldFName;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldMNmae;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldLname;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldMobNumber;

@property (strong, nonatomic) IBOutlet UIButton *btnState;
- (IBAction)btnStatePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldState;

@property (strong, nonatomic) IBOutlet UIButton *btnCity;
- (IBAction)btnCityPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldCity;

@property (strong, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (strong, nonatomic) IBOutlet UITextField *textFieldConfirlPassword;
@property (strong, nonatomic) IBOutlet UITextField *textFieldAddress;

@property (strong, nonatomic) IBOutlet UIButton *btnJobType;
- (IBAction)btnJobTypePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldJobType;

@property (strong, nonatomic) IBOutlet UIButton *btnEmpType;
- (IBAction)btnEmpTypePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldEmpType;

@property (strong, nonatomic) IBOutlet UIButton *btnRegion;
- (IBAction)btnRegionPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldRegion;

@property (strong, nonatomic) IBOutlet UIButton *btnBranch;
- (IBAction)btnBranchPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldBranch;

@property (strong, nonatomic) IBOutlet UIButton *btnRole;
- (IBAction)btnRolePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldRole;

@property (strong, nonatomic) IBOutlet UIButton *btnDepartment;
- (IBAction)btnDepartmentPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldDepartment;

@property (strong, nonatomic) IBOutlet UIButton *btnFunctionalArea;
- (IBAction)btnFunctionalAreaPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldFunctionalArea;

- (IBAction)submitBtnPressed:(id)sender;
- (IBAction)cancelBtnPressed:(id)sender;

@property(nonatomic, strong)NSDictionary *receiveDataDict;












@end
