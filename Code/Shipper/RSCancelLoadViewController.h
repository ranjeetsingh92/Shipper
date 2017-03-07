//
//  RSCancelLoadViewController.h
//  Shipper
//
//  Created by QUIKHOP on 1/11/17.
//  Copyright © 2017 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSCancelLoadViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *rScrolView;
@property (strong, nonatomic) IBOutlet UITextField *textFieldReason;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIButton *btnDropDown;
- (IBAction)btnDropDownPressed:(id)sender;
- (IBAction)submitBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *rTableView;

@property(nonatomic, strong)NSDictionary *receiveDataDict;

@end
