//
//  RSDocumentUploadTableViewCell.h
//  Carrier
//
//  Created by QUIKHOP on 10/21/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSDocumentUploadTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelSerialNo;
@property (strong, nonatomic) IBOutlet UILabel *labelDocumentName;
@property (strong, nonatomic) IBOutlet UILabel *labelDocumentUploaded;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;
@property (strong, nonatomic) IBOutlet UILabel *labelVerify;

@end
