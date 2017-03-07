//
//  RSMainDashBoardViewController.h
//  Shipper
//
//  Created by QUIKHOP on 6/27/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSMainDashBoardViewController : UIViewController
- (IBAction)newLoadBtnPressed:(id)sender;
- (IBAction)biddingBtnPressed:(id)sender;
- (IBAction)requestedBtnPressed:(id)sender;
- (IBAction)bookedBtnPessed:(id)sender;

- (IBAction)plabbedBtnPressed:(id)sender;
- (IBAction)allBtnPressed:(id)sender;

- (IBAction)leftBarButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *labelNewLoad;
@property (strong, nonatomic) IBOutlet UILabel *labelRequestedLoad;
@property (strong, nonatomic) IBOutlet UILabel *labelBidding;
@property (strong, nonatomic) IBOutlet UILabel *labelBooked;
@property (strong, nonatomic) IBOutlet UILabel *labelPlanned;










@end
