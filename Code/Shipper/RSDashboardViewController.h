//
//  RSDashboardViewController.h
//  Shipper
//
//  Created by QUIKHOP on 6/23/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSLContainerViewController.h"
#import "YSLScrollMenuView.h"

@interface RSDashboardViewController : UIViewController<YSLContainerViewControllerDelegate,YSLScrollMenuViewDelegate>

- (IBAction)leftBarButtonPressed:(id)sender;
- (IBAction)AddNewLoadBtnPressed:(id)sender;
@end
