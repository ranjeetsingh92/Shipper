//
//  RSBiddingDetailsTableViewCell.h
//  Shipper
//
//  Created by QUIKHOP on 6/30/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSBiddingDetailsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelCompanyName;
@property (strong, nonatomic) IBOutlet UILabel *labelBidPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;

@property (strong, nonatomic) IBOutlet UIButton *btnAccept;
@property (strong, nonatomic) IBOutlet UIButton *btnReject;


@property (strong, nonatomic) IBOutlet UILabel *fLabelCompanyName;
@property (strong, nonatomic) IBOutlet UILabel *fLabelBidPrice;
@property (strong, nonatomic) IBOutlet UILabel *fLabelStatus;


@end
