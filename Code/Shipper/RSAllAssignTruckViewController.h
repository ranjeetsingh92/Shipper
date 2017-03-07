//
//  RSAllAssignTruckViewController.h
//  Shipper
//
//  Created by QUIKHOP on 7/1/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAllAssignTruckViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UIActivityIndicatorView *spinner;
    
}

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic) BOOL noMoreResultsAvail;
@property (nonatomic) BOOL loading;



@property (strong, nonatomic) IBOutlet UILabel *labelCarrierType;
@property (strong, nonatomic) IBOutlet UILabel *labelCommodity;
@property (strong, nonatomic) IBOutlet UILabel *labelFromLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelToLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelQuantityType;
@property (strong, nonatomic) IBOutlet UILabel *labelQuantityNumbers;
@property (strong, nonatomic) IBOutlet UILabel *labelCreatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelPickUpDate;
@property (strong, nonatomic) IBOutlet UILabel *labelDispatchDate;
@property (strong, nonatomic) IBOutlet UILabel *labelYourOfferPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdatedDate;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;



@property(nonatomic, strong)NSDictionary *receiveDataDict;

@property (strong, nonatomic) IBOutlet UIButton *btnSelectState;
- (IBAction)btnSelectStatePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldSelectState;

@property (strong, nonatomic) IBOutlet UIButton *btnSelectCity;
- (IBAction)btnSelectCityPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textFieldSelectCity;

@property (strong, nonatomic) IBOutlet UITableView *rTableView;

@property (strong, nonatomic) IBOutlet UITableView *dTableView;

- (IBAction)searchBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *rScrollView;























@end
