//
//  RSUserPermisionViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/24/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSUserPermisionViewController.h"

@interface RSUserPermisionViewController ()

@end

@implementation RSUserPermisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)leftBarButtonPressed:(id)sender
{
    [self.revealViewController revealToggle:self];
}

@end
