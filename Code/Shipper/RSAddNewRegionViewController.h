//
//  RSAddNewRegionViewController.h
//  Shipper
//
//  Created by QUIKHOP on 7/8/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAddNewRegionViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;
@property (strong, nonatomic) IBOutlet UITextField *textFieldRegion;
@property (strong, nonatomic) IBOutlet UITextField *textFielddescription;
- (IBAction)submitBtnAction:(id)sender;
- (IBAction)cancelBtnAction:(id)sender;

@property(nonatomic, strong)NSDictionary *receiveDataDict;


@end
