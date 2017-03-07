//
//  RSAddNewRoleViewController.h
//  Shipper
//
//  Created by QUIKHOP on 7/20/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAddNewRoleViewController : UIViewController<UITextFieldDelegate>



@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
@property (strong, nonatomic) IBOutlet UITextField *textFieldBranch;
@property (strong, nonatomic) IBOutlet UITextField *textFieldDescription;

- (IBAction)submitBtnPressed:(id)sender;
- (IBAction)cancelBtnPressed:(id)sender;

@property (nonatomic, strong)NSDictionary *receiveDataDict;


@end
