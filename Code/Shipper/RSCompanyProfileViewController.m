//
//  RSCompanyProfileViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/24/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSCompanyProfileViewController.h"

@interface RSCompanyProfileViewController ()

@end

@implementation RSCompanyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_rScrollView setContentSize:CGSizeMake(320, 1000)];
}

- (IBAction)leftBarButtonPressed:(id)sender
{
    [self.revealViewController revealToggle:self];
}

@end
