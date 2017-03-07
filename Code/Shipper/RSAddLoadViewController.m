//
//  RSAddLoadViewController.m
//  Shipper
//
//  Created by QUIKHOP on 1/16/17.
//  Copyright © 2017 QUIKHOP. All rights reserved.
//

#import "RSAddLoadViewController.h"

@interface RSAddLoadViewController ()
{
    BOOL tableShown;
    NSArray *selectQuantity;
    NSArray *selectQuantityUnit;
    NSArray *truckTypeArr;
    NSArray *comodityTypeArr;
    NSArray *selectSpecificRequirementArr;
    BOOL dateShown;
    
    NSArray *packageType;
    NSArray *perArr;
    NSArray *selectPQuantity;
    NSMutableArray *json;
    BOOL pTableShown;
    NSString *cityId;
    NSMutableArray *stateArray;
    NSMutableArray *clientInfoArr;

    
}


@end

@implementation RSAddLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableShown = false;
    dateShown  = false;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 2500)];
    [_rDatePicker setBackgroundColor:[UIColor whiteColor]];
    
    [_rTableView setBackgroundColor:[UIColor whiteColor]];
    _rTableView.layer.cornerRadius = 5.0;
    _rTableView.layer.borderWidth = 1.0;
    _rTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    selectQuantity = [[NSArray alloc]initWithObjects:@"Numbers",@"Weight",@"Litre", nil];
    perArr = [[NSArray alloc]initWithObjects:@"cm",@"in", nil];
    
    selectQuantityUnit = [[NSArray alloc]initWithObjects:@"Kg",@"Other",@"Quintal",@"Ton", nil];
    selectSpecificRequirementArr = [[NSArray alloc]initWithObjects:@"Kg",@"Other",@"Quintal",@"Ton", nil];
 
    [SVProgressHUD show];
    [self getPackagingType];
}

#pragma mark get packaging type
-(void)getPackagingType
{
//    [SVProgressHUD show];
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        //code to be executed on the main queue after delay
//        packageType = [[NSMutableArray alloc]initWithArray:[Utils getAllPackagingType]];
//        [_rPTableView reloadData];
//        [SVProgressHUD dismiss];
//    });
    
    NSString *completeLoginUrl = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_PACKAGING_TYPE];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:completeLoginUrl]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json"       forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         if (data != nil)
         {
            packageType = [[NSMutableArray alloc]initWithArray:[Utils getAllPackagingType]];
             
             [self setAllTruckType];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];

}


#pragma mark get all truck type
-(void)setAllTruckType
{
//    [SVProgressHUD show];
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        //code to be executed on the main queue after delay
//        truckTypeArr = [[NSMutableArray alloc]initWithArray:[Utils getTruckType]];
//        [_rTableView reloadData];
//        [SVProgressHUD dismiss];
//    });
//    
    
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@}",@"0"];
    NSLog(@"%@",userUpdate);
    
    //  {"Department":[{"DepartmentId":30033}],"SubscriptionId":30079}
    
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_ALL_TRUCK_TYPE];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:completeLoginUrlWithSpace]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json"       forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *fPostData = [userUpdate dataUsingEncoding:NSASCIIStringEncoding];
    [request setHTTPBody:fPostData];

    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         if (data != nil)
         {
              truckTypeArr = [[NSMutableArray alloc]initWithArray:[Utils getTruckType]];
             
             
                 [self setAllcomodityType];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];

}

#pragma mark get all comodity type
-(void)setAllcomodityType
{
//    [SVProgressHUD show];
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        //code to be executed on the main queue after delay
//        comodityTypeArr = [[NSMutableArray alloc]initWithArray:[Utils getAllComodityList]];
//        [_rTableView reloadData];
//        [SVProgressHUD dismiss];
//    });
    
    
    NSString *completeLoginUrl = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_ALL_COMODITY_LIST];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:completeLoginUrl]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json"       forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         if (data != nil)
         {
             comodityTypeArr = [[NSMutableArray alloc]initWithArray:[Utils getAllComodityList]];
             
                 [self getStateList];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];

}
#pragma mark get state list
-(void)getStateList
{
    NSString *completeLoginUrl = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,STATE_LIST];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:completeLoginUrl]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json"       forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         if (data != nil)
         {
             stateArray = [[NSMutableArray alloc]initWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
             
                 [self  getClientInfo];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];

}
#pragma mark get state list
-(void)getClientInfo
{
    NSString *completeLoginUrl = [NSString stringWithFormat:@"%@%@?SubscriptionId=%@",DOMAIN_URL,CLIEN_INFO,[[Utils getLogingDict] objectForKey:@"subscriptionId"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:completeLoginUrl]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json"       forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         if (data != nil)
         {
             clientInfoArr = [[NSMutableArray alloc]initWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
             
             if (clientInfoArr != nil)
             {
             }
             [SVProgressHUD dismiss];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];
    
}

#pragma mark hitservice to fetch state name

-(void)hitCityService:(NSString *)stateName
{
    [SVProgressHUD show];
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@?state=%@",DOMAIN_URL,CITY_LIST,stateName];
    NSString* completeLoginUrl = [completeLoginUrlWithSpace stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:completeLoginUrl]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json"       forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         if (data != nil)
         {
             id rsJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             json = [[NSMutableArray alloc]initWithArray:rsJson];
             
             if (json != nil)
             {
                 [_rTableView reloadData];
             }
             [SVProgressHUD dismiss];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];
}

#pragma mark table view data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if (_rTableView.tag == 1)
        {
            return truckTypeArr.count;
        }
        else if(_rTableView.tag == 2)
        {
            return comodityTypeArr.count;
        }
        else if (_rTableView.tag == 3)
        {
            return selectQuantity.count;
        }
        else if (_rTableView.tag == 4)
        {
            return selectQuantityUnit.count;
        }
        else if(_rTableView.tag == 5)
        {
            return selectSpecificRequirementArr.count;
        }
        else if (_rTableView.tag == 6)
        {
            return packageType.count;
        }
        else if (_rTableView.tag == 7)
        {
            return perArr.count;
        }
        else if (_rTableView.tag == 8)
        {
            return selectQuantity.count;
        }
        else if (_rTableView.tag == 9)
        {
            return [[stateArray valueForKey:@"stateName"] count];
        }
        else if(_rTableView.tag == 10)
        {
            return  [[json valueForKey:@"city"] count];
        }
        else if(_rTableView.tag == 11)
        {
            return  [selectQuantity count];
        }
        else if(_rTableView.tag == 12)
        {
            return  [clientInfoArr count];
        }
        else if(_rTableView.tag == 13)
        {
            return  [stateArray count];
        }
        else if(_rTableView.tag == 14)
        {
            return  [[json valueForKey:@"city"] count];
        }


        else
        {
            return 0;
        }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ranjit Singh"];
    
        if (_rTableView.tag == 1)
        {
            [cell.textLabel setText:[[truckTypeArr objectAtIndex:indexPath.row] valueForKey:@"truckType"]];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        else if(_rTableView.tag == 2)
        {
            [cell.textLabel setText:[[comodityTypeArr objectAtIndex:indexPath.row] valueForKey:@"commodityName"]];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
            
        }
        else if (_rTableView.tag == 3)
        {
            [cell.textLabel setText:[selectQuantity objectAtIndex:indexPath.row] ];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
            
        }
        else if (_rTableView.tag == 4)
        {
            [cell.textLabel setText:[selectQuantityUnit objectAtIndex:indexPath.row] ];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        else if(_rTableView.tag == 5)
        {
            [cell.textLabel setText:[selectSpecificRequirementArr objectAtIndex:indexPath.row] ];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }

        else if(tableView.tag == 6)
        {
            [cell.textLabel setText:[[packageType objectAtIndex:indexPath.row] valueForKey:@"name"] ];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        else if(tableView.tag == 7)
        {
            [cell.textLabel setText:[perArr objectAtIndex:indexPath.row] ];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        else if(tableView.tag == 8)
        {
            [cell.textLabel setText:[selectQuantity objectAtIndex:indexPath.row] ];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:10.0];
        }
        else if(tableView.tag == 9)
        {
            cell.textLabel.text = [[stateArray valueForKey:@"stateName"] objectAtIndex:indexPath.row];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        else if(tableView.tag == 10)
        {
            [cell.textLabel setText:[[json valueForKey:@"city"] objectAtIndex:indexPath.row]];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        else if(tableView.tag == 11)
        {
            [cell.textLabel setText:[selectQuantity objectAtIndex:indexPath.row]];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        else if(tableView.tag == 12)
        {
            [cell.textLabel setText:[[clientInfoArr objectAtIndex:indexPath.row] objectForKey:@"companyName"]];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        else if(tableView.tag == 13)
        {
            cell.textLabel.text = [[stateArray valueForKey:@"stateName"] objectAtIndex:indexPath.row];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        else if(tableView.tag == 14)
        {
            [cell.textLabel setText:[[json valueForKey:@"city"] objectAtIndex:indexPath.row]];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }


    
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (_rTableView.tag == 1)
        {
            [_textFieldCarrierType setText:[[truckTypeArr objectAtIndex:indexPath.row] valueForKey:@"truckType"]];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
        else if(_rTableView.tag == 2)
        {
            [_textFieldComodity setText:[[comodityTypeArr objectAtIndex:indexPath.row] valueForKey:@"commodityName"]];
            [_rTableView setHidden:YES];
            tableShown = false;
            
        }
        else if (_rTableView.tag == 3)
        {
            [_textFieldQuantity setText:[selectQuantity objectAtIndex:indexPath.row] ];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
        else if (_rTableView.tag == 4)
        {
            [_textFieldSelectUnit setText:[selectQuantityUnit objectAtIndex:indexPath.row] ];
            [_rTableView setHidden:YES];
            tableShown = false;    }
        else if(_rTableView.tag == 5)
        {
            [_textFieldSpecificRequirement setText:[selectSpecificRequirementArr objectAtIndex:indexPath.row] ];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
        else if(_rTableView.tag == 6)
        {
            [_textFieldPackageType setText:[[packageType objectAtIndex:indexPath.row] valueForKey:@"name"] ];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
        else if(tableView.tag == 7)
        {
            [_textFieldPer setText:[perArr objectAtIndex:indexPath.row]  ];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
        else if(tableView.tag == 8)
        {
            [_textFieldTypeOfWeight setText:[selectQuantity objectAtIndex:indexPath.row]  ];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
        else if(tableView.tag == 9)
        {
            [_textFieldState setText:[[stateArray valueForKey:@"stateName"] objectAtIndex:indexPath.row]];
            [_rTableView setHidden:YES];
            tableShown = false;
            
            [self hitCityService:[[stateArray valueForKey:@"stateName"] objectAtIndex:indexPath.row]];
        }
        else if(tableView.tag == 10)
        {
            [_textFieldCity setText:[[json valueForKey:@"city"] objectAtIndex:indexPath.row]];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
        else if(tableView.tag == 11)
        {
            [_textFieldTypeOfDWeight setText:[selectQuantity objectAtIndex:indexPath.row]];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
        else if (_rTableView.tag == 12)
        {
            [_textFieldSelectClientInfo setText: [[clientInfoArr objectAtIndex:indexPath.row] objectForKey:@"companyName"]];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
        else if (_rTableView.tag == 13)
        {
            [_textFieldDState setText:[[stateArray valueForKey:@"stateName"] objectAtIndex:indexPath.row]];
            [_rTableView setHidden:YES];
            tableShown = false;
            
            [self hitCityService:[[stateArray valueForKey:@"stateName"] objectAtIndex:indexPath.row]];
        }
        else if(tableView.tag == 14)
        {
            [_textFieldDCity setText:[[json valueForKey:@"city"] objectAtIndex:indexPath.row]];
            [_rTableView setHidden:YES];
            tableShown = false;
        }


}
#pragma mark table view hide and show

-(BOOL)hideAndShowTableVew:(BOOL)isShown
{
    if (!isShown)
    {
        [_rTableView setHidden:NO];
        tableShown = true;
    }
    else
    {
        [_rTableView setHidden:YES];
        tableShown = false;
    }
    return tableShown;
}

- (IBAction)btnCarrierTypePressed:(id)sender
{
    [_rTableView setTag:1];
    if (_btnCarrierType.tag == 1)
    {
        _btnCarrierType.tag = 2;
        _btnComodity.tag    = 1;
        _btnQuantity.tag    = 1;
        _btnSelectUnit.tag  = 1;
        _btnSpecificRequirement.tag = 1;
        _btnPackageType.tag   = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForCarrierType];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForCarrierType];
    }
    
}
- (IBAction)btnComodityPressed:(id)sender
{
    [_rTableView setTag:2];
    if (_btnComodity.tag == 1)
    {
        _btnComodity.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnQuantity.tag    = 1;
        _btnSelectUnit.tag  = 1;
        _btnSpecificRequirement.tag = 1;
        _btnPackageType.tag   = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForComodity];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForComodity];
    }
    
}
- (IBAction)btnOfferPricePressed:(id)sender
{
    
}
- (IBAction)btnCarrierQuantityPressed:(id)sender
{
    [_rTableView setTag:3];
    if (_btnQuantity.tag == 1)
    {
        _btnQuantity.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnSelectUnit.tag  = 1;
        _btnSpecificRequirement.tag = 1;
        _btnPackageType.tag   = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForQuantity];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForQuantity];
    }
}

- (IBAction)btnSelectUnitPressed:(id)sender
{
    [_rTableView setTag:4];
    if (_btnSelectUnit.tag == 1)
    {
       _btnSelectUnit.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnQuantity.tag  = 1;
        _btnSpecificRequirement.tag = 1;
        _btnPackageType.tag   = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForUnit];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForUnit];
    }
    
}
- (IBAction)btnSpecificRequirementPressed:(id)sender
{
    [_rTableView setTag:5];
    if (_btnSpecificRequirement.tag == 1)
    {
        _btnSpecificRequirement.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnQuantity.tag  = 1;
        _btnSelectUnit.tag = 1;
        _btnPackageType.tag   = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForSpecificRequirement];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForSpecificRequirement];
    }
    
}

//- (IBAction)btnAddPickUpLocationPressed:(id)sender
//{
//    RSAddPickUpLocationViewController *addPickUp = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAddPickUpLocationViewController"];
//    [self.navigationController pushViewController:addPickUp animated:YES];
//}

- (IBAction)startDatePressed:(id)sender
{
    if (_btnStartDate.tag == 1)
    {
        _rDatePicker.tag = 1;
        _btnStartDate.tag     = 2;
        _btnEndDate.tag       = 1;
        
        // [self showdatePicker:dateShown];
        [_rDatePicker setHidden:NO];
        dateShown = true;
        [self datePickerChanged:_rDatePicker];
        [self setDatePickerFrameForStartDate];
    }
    else
    {
        [self showdatePicker:dateShown];
        [self datePickerChanged:_rDatePicker];
        [self setDatePickerFrameForStartDate];
        
    }
    
}

- (IBAction)endDate:(id)sender
{
    _rDatePicker.tag = 2;
    if (_btnEndDate.tag == 1)
    {
        _btnEndDate.tag     = 2;
        _btnStartDate.tag       = 1;
        
        // [self showdatePicker:dateShown];
        [_rDatePicker setHidden:NO];
        dateShown = true;
        [self datePickerChanged:_rDatePicker];
        [self setDatePickerFrameForEndDate];
    }
    else
    {
        [self showdatePicker:dateShown];
        [self datePickerChanged:_rDatePicker];
        [self setDatePickerFrameForEndDate];
        
    }
    
}

- (IBAction)btnTotalPressed:(id)sender
{
    _rDatePicker.tag = 3;
    if (_btnTotal.tag == 1)
    {
        _btnTotal.tag         = 2;
        _btnStartDate.tag       = 1;
        _btnEndDate.tag = 1;
        
        // [self showdatePicker:dateShown];
        [_rDatePicker setHidden:NO];
        dateShown = true;
        [self datePickerChanged:_rDatePicker];
        [self setDatePickerFrameForTotal];
    }
    else
    {
        [self showdatePicker:dateShown];
        [self datePickerChanged:_rDatePicker];
        [self setDatePickerFrameForTotal];
        
    }
  
}
- (IBAction)btnDTotalPressed:(id)sender
{
    _rDatePicker.tag = 4;
    if (_btnDTotal.tag == 1)
    {
        _btnDTotal.tag         = 2;
        _btnStartDate.tag       = 1;
        _btnEndDate.tag = 1;
        _btnTotal.tag = 1;
        
        // [self showdatePicker:dateShown];
        [_rDatePicker setHidden:NO];
        dateShown = true;
        [self datePickerChanged:_rDatePicker];
        [self setDatePickerFrameForDTotal];
    }
    else
    {
        [self showdatePicker:dateShown];
        [self datePickerChanged:_rDatePicker];
        [self setDatePickerFrameForDTotal];
        
    }
    
}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    if (_rDatePicker.tag ==1)
    {
        self.testFieldStartDate.text = strDate;
        
    }
    else if(_rDatePicker.tag ==2)
    {
        self.textFieldEndDate.text = strDate;
    }
    else if (_rDatePicker.tag ==3)
    {
       self.textFieldTotal.text = strDate;
    }
    else if (_rDatePicker.tag ==4)
    {
        self.textFieldDTotal.text = strDate;
    }

}
#pragma mark set frame of date piker
-(void)setDatePickerFrameForStartDate
{
    [_rDatePicker setFrame:CGRectMake(8, 298, 278, 30)];
}

-(void)setDatePickerFrameForEndDate
{
    [_rDatePicker setFrame:CGRectMake(8, 336, 278, 30)];
}
-(void)setDatePickerFrameForTotal
{
    [_rDatePicker setFrame:CGRectMake(8, 627, 278, 30)];
}
-(void)setDatePickerFrameForDTotal
{
    [_rDatePicker setFrame:CGRectMake(8, 1037, 278, 30)];
}

#pragma mark set frame of tableview

-(void)setFrameForCarrierType
{
    if (25*truckTypeArr.count<=200)
    {
        [_rTableView setFrame:CGRectMake(8, 40, 304, 25*truckTypeArr.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(8, 40, 304, 200)];
    }
    
}

-(void)setFrameForSpecificRequirement
{
    if (25*selectSpecificRequirementArr.count<=200)
    {
        [_rTableView setFrame:CGRectMake(8, 374, 304, 25*selectSpecificRequirementArr.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(8, 374, 304, 200)];
    }
}
-(void)setFrameForComodity
{
    if (25*comodityTypeArr.count<=200)
    {
        [_rTableView setFrame:CGRectMake(8, 78, 304, 25*comodityTypeArr.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(8, 78, 304, 200)];
    }
}
-(void)setFrameForQuantity
{
    if (25*selectQuantity.count<=200)
    {
        [_rTableView setFrame:CGRectMake(8, 154, 304, 25*selectQuantity.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(8, 154, 304, 200)];
    }
    
}


-(void)setFrameForUnit
{
    if (25*selectQuantityUnit.count<=200)
    {
        [_rTableView setFrame:CGRectMake(8, 230, 304, 25*selectQuantityUnit.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(8, 230, 304, 200)];
    }
    
}
-(void)setFrameForPackagingType
{
    if (25*packageType.count<=200)
    {
        [_rTableView setFrame:CGRectMake(10, 454, 304, 25*packageType.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(8, 454, 304, 200)];
    }
    
}
-(void)setFrameForPer
{
    if (25*perArr.count<=200)
    {
        [_rTableView setFrame:CGRectMake(237, 522, 74, 25*perArr.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(237, 522, 74, 200)];
    }
    
}
-(void)setFrameForTypeOfWeight
{
    if (25*selectQuantity.count<=200)
    {
        [_rTableView setFrame:CGRectMake(164, 589, 76, 25*selectQuantity.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(164, 589, 76, 200)];
    }
    
}
-(void)setFrameForState
{
    if (25*stateArray.count<=200)
    {
        [_rTableView setFrame:CGRectMake(10, 665, 301, 25*stateArray.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(10, 665, 301, 200)];
    }
    
}
-(void)setFrameForCity
{
    if (25*stateArray.count<=200)
    {
        [_rTableView setFrame:CGRectMake(10, 703, 301, 25*stateArray.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(10, 703, 301, 200)];
    }
    
}
-(void)setFrameForDWeight
{
    if (25*selectQuantity.count<=200)
    {
        [_rTableView setFrame:CGRectMake(164, 999, 76, 25*selectQuantity.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(164, 999, 76, 200)];
    }
    
}
-(void)setFrameForClientInfo
{
    if (25*clientInfoArr.count<=200)
    {
        [_rTableView setFrame:CGRectMake(10, 1075, 301, 25*clientInfoArr.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(10, 1075, 301, 200)];
    }
    
}
-(void)setFrameForDState
{
    if (25*stateArray.count<=200)
    {
        [_rTableView setFrame:CGRectMake(10, 1112, 301, 25*stateArray.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(10, 1112, 301, 200)];
    }
    
}
-(void)setFrameForDCity
{
    if (25*stateArray.count<=200)
    {
        [_rTableView setFrame:CGRectMake(10, 1151, 301, 25*stateArray.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(10, 1151, 301, 200)];
    }
    
}
#pragma mark textfield delegate methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark set full width of separator
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)rCell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([rCell respondsToSelector:@selector(setSeparatorInset:)]) {
        [rCell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([rCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [rCell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.rTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.rTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.rTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.rTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma handling visibility of date picker

-(BOOL)showdatePicker :(BOOL)passIsShown
{
    if (dateShown == true)
    {
        [_rDatePicker setHidden:YES];
        dateShown  = false;
    }
    else
    {
        [_rDatePicker setHidden:NO];
        dateShown  = true;
    }
    return dateShown;
}


#pragma mark pick up location actions

- (IBAction)btnPackageTypePressed:(id)sender
{
    [_rTableView setTag:6];
    if (_btnPackageType.tag == 1)
    {
        _btnPackageType.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnQuantity.tag  = 1;
        _btnSelectUnit.tag = 1;
        _btnSpecificRequirement.tag   = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForPackagingType];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForPackagingType];
    }
   
}


- (IBAction)btnPerPressed:(id)sender
{
    [_rTableView setTag:7];
    if (_btnPer.tag == 1)
    {
        _btnPer.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnQuantity.tag  = 1;
        _btnSelectUnit.tag = 1;
        _btnSpecificRequirement.tag   = 1;
        _btnPackageType.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForPer];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForPer];
    }
}


- (IBAction)btnTypeOfWeightPressed:(id)sender
{
    [_rTableView setTag:8];
    if (_btnTypeOfWeight.tag == 1)
    {
        _btnTypeOfWeight.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnQuantity.tag  = 1;
        _btnSelectUnit.tag = 1;
        _btnSpecificRequirement.tag   = 1;
        _btnPackageType.tag = 1;
        _btnPer.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForTypeOfWeight];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForTypeOfWeight];
    }
}
- (IBAction)btnStatePressed:(id)sender
{
    [_rTableView setTag:9];
    if (_btnState.tag == 1)
    {
        _btnState.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnQuantity.tag  = 1;
        _btnSelectUnit.tag = 1;
        _btnSpecificRequirement.tag   = 1;
        _btnPackageType.tag = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForState];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForState];
    }
    
}

- (IBAction)btnCityPressed:(id)sender
{
 
    [_rTableView setTag:10];
    if (_btnCity.tag == 1)
    {
        _btnCity.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnQuantity.tag  = 1;
        _btnSelectUnit.tag = 1;
        _btnSpecificRequirement.tag   = 1;
        _btnPackageType.tag = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForCity];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForCity];
    }

}

- (IBAction)btnTypeOfDWeightPressed:(id)sender
{
    [_rTableView setTag:11];
    if (_btnTypeOfDWeight.tag == 1)
    {
        _btnTypeOfDWeight.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnQuantity.tag  = 1;
        _btnSelectUnit.tag = 1;
        _btnSpecificRequirement.tag   = 1;
        _btnPackageType.tag = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForDWeight];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForDWeight];
    }
 
}
- (IBAction)btnSelectDClientInfoPressed:(id)sender
{
    [_rTableView setTag:12];
    if (_btnSelectDClientInfo.tag == 1)
    {
        _btnSelectDClientInfo.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnQuantity.tag  = 1;
        _btnSelectUnit.tag = 1;
        _btnSpecificRequirement.tag   = 1;
        _btnPackageType.tag = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnDState.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForClientInfo];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForClientInfo];
    }
    
}

- (IBAction)btnDStatePressed:(id)sender
{
    [_rTableView setTag:13];
    if (_btnDState.tag == 1)
    {
        _btnDState.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnQuantity.tag  = 1;
        _btnSelectUnit.tag = 1;
        _btnSpecificRequirement.tag   = 1;
        _btnPackageType.tag = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDCity.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForDState];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForDState];
    }
    
}
- (IBAction)btnDCityPressed:(id)sender
{
    [_rTableView setTag:14];
    if (_btnDCity.tag == 1)
    {
        _btnDCity.tag = 2;
        _btnCarrierType.tag    = 1;
        _btnComodity.tag    = 1;
        _btnQuantity.tag  = 1;
        _btnSelectUnit.tag = 1;
        _btnSpecificRequirement.tag   = 1;
        _btnPackageType.tag = 1;
        _btnPer.tag = 1;
        _btnTypeOfWeight.tag = 1;
        _btnState.tag = 1;
        _btnCity.tag = 1;
        _btnTypeOfDWeight.tag = 1;
        _btnSelectDClientInfo.tag = 1;
        _btnDState.tag = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForDCity];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameForDCity];
    }
    
}
- (IBAction)btnLocalAddressPressed:(id)sender
{
    [self.rMapView removeAnnotations:self.rMapView.annotations];
    CLLocationCoordinate2D pickUpLocation = [Utils getLocationFromAddressString:_textFieldLocalAddress.text];
    NSLog(@"Location lat = %f, long is = %f",pickUpLocation.latitude,pickUpLocation.longitude);
    [_labelLatLong setText:[NSString stringWithFormat:@"Lat = %f long = %f",pickUpLocation.latitude, pickUpLocation.longitude]];
    [self addPinWithCoordinate:pickUpLocation color:MKPinAnnotationColorGreen title:[NSString stringWithFormat:@"%@",@"Current Location"] subTitle:@"" status:nil mapView:self.rMapView];
    [self.rMapView setCenterCoordinate:pickUpLocation];
}

- (IBAction)btnDSearchLocalAddressPressed:(id)sender
{
    [self.rDMapView removeAnnotations:self.rDMapView.annotations];
    CLLocationCoordinate2D pickUpLocation = [Utils getLocationFromAddressString:_textFieldDLocalAddress.text];
    NSLog(@"Location lat = %f, long is = %f",pickUpLocation.latitude,pickUpLocation.longitude);
    [_labelDLatLong setText:[NSString stringWithFormat:@"Lat = %f long = %f",pickUpLocation.latitude, pickUpLocation.longitude]];
    [self addPinWithCoordinate:pickUpLocation color:MKPinAnnotationColorGreen title:[NSString stringWithFormat:@"%@",@"Current Location"] subTitle:@"" status:nil mapView:self.rDMapView];
    [self.rDMapView setCenterCoordinate:pickUpLocation];
  
}

#pragma mark add pin on specified location
     
 - (void)addPinWithCoordinate:(CLLocationCoordinate2D)pinLocation
                        color:(MKPinAnnotationColor)pinColor title:(NSString *)title subTitle:(NSString *)subtitle status:(NSString *)status mapView:(MKMapView *)mapView   //<-- new
{
    PinPlaceMark *placeMark = [[PinPlaceMark alloc] initWithCoordinate:pinLocation];
    
    placeMark.myTitle = title;
    placeMark.mySubTitle = subtitle;
    placeMark.rStatus = [Utils returnStateOfTruck:[status intValue]];
    placeMark.myPinColor = pinColor;  //<-- new
    [mapView addAnnotation:placeMark];
    
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    //      PinPlaceMark *ppm = (PinPlaceMark *)annotation;
    
    //        UIImage *anImage = nil;
    //        static NSString *AnnotationViewID = @"annotation";
    //        MKAnnotationView *annView=(MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    //        if(annView==nil){
    //            annView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    //        }
    //            anImage=[UIImage imageNamed:@"truck_black.png"];
    //
    //    else if([ppm.rStatus isEqualToString:@"Assigned"])
    //    {
    //        anImage=[UIImage imageNamed:@"box_yellow.png"];
    //    }
    //    else if([ppm.rStatus isEqualToString:@"Way To Pickup"])
    //    {
    //        anImage=[UIImage imageNamed:@"box_red.png"];
    //    }
    //    if([ppm.rStatus isEqualToString:@"location"])
    //    {
    //        anImage=[UIImage imageNamed:@"location.png"];
    //        annView.draggable = YES;
    //    }
    //    else
    //    {
    //      anImage=[UIImage imageNamed:@"box_gray.png"];
    //    }
    //        annView.image = anImage;
    //        return annView;
    
    
    
    if (! [annotation isKindOfClass:[PinPlaceMark class]]) {
        //if annotation is not a PinPlaceMark (eg. user location),
        //return nil so map view draws default view (eg. blue dot) for it...
        return nil;
    }
    
    static NSString *reuseId = @"id";
    // static NSString *annotationReuseId = @"annotationId";
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (pinView == nil)
    {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        pinView.canShowCallout = YES;
        
    }
    else
    {
        pinView.annotation = annotation;
    }
    PinPlaceMark *ppm = (PinPlaceMark *)annotation;
    pinView.pinColor = ppm.myPinColor;
    
    pinView.draggable   = YES;
    [pinView setSelected:YES];
    return pinView;
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        NSLog(@"Pin dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
        [mapView setCenterCoordinate:droppedAt];
        
        if (mapView == _rMapView)
        {
            [_labelLatLong setText:[NSString stringWithFormat:@"Lat = %f long = %f",droppedAt.latitude, droppedAt.longitude]];
        }
        else if (mapView == _rDMapView)
        {
          [_labelDLatLong setText:[NSString stringWithFormat:@"Lat = %f long = %f",droppedAt.latitude, droppedAt.longitude]];
        }
        
    }
    
}

- (IBAction)saveBtnPressed:(id)sender
{
    
}
- (IBAction)btnDSaveLoadPressed:(id)sender
{
    
}
@end
