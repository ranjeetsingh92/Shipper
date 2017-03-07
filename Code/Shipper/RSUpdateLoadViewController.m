//
//  RSUpdateLoadViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/28/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSUpdateLoadViewController.h"
#import "RSAddPickUpLocationViewController.h"


@interface RSUpdateLoadViewController ()
{
    BOOL tableShown;
    NSArray *selectQuantity;
    NSArray *selectQuantityUnit;
    NSArray *truckTypeArr;
    NSArray *comodityTypeArr;
    NSArray *selectSpecificRequirementArr;
    BOOL dateShown;
}

@end

@implementation RSUpdateLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableShown = false;
    dateShown  = false;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 1000)];
    [_rDatePicker setBackgroundColor:[UIColor whiteColor]];
    
    [_rTableView setBackgroundColor:[UIColor whiteColor]];
    _rTableView.layer.cornerRadius = 5.0;
    _rTableView.layer.borderWidth = 1.0;
    _rTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    selectQuantity = [[NSArray alloc]initWithObjects:@"Numbers",@"Weight",@"Litre", nil];
    
    selectQuantityUnit = [[NSArray alloc]initWithObjects:@"Kg",@"Other",@"Quintal",@"Ton", nil];
    selectSpecificRequirementArr = [[NSArray alloc]initWithObjects:@"Kg",@"Other",@"Quintal",@"Ton", nil];
    [self setAllTruckType];
    [self setAllcomodityType];
    
}

#pragma mark get all truck type
-(void)setAllTruckType
{
    [SVProgressHUD show];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        truckTypeArr = [[NSMutableArray alloc]initWithArray:[Utils getTruckType]];
        [_rTableView reloadData];
        [SVProgressHUD dismiss];
    });
}

#pragma mark get all comodity type
-(void)setAllcomodityType
{
    [SVProgressHUD show];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        comodityTypeArr = [[NSMutableArray alloc]initWithArray:[Utils getAllComodityList]];
        [_rTableView reloadData];
        [SVProgressHUD dismiss];
    });
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
    else
    {
        return selectSpecificRequirementArr.count;
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
    else
    {
        [cell.textLabel setText:[selectSpecificRequirementArr objectAtIndex:indexPath.row] ];
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
    else
    {
        [_textFieldSpecificRequirement setText:[selectSpecificRequirementArr objectAtIndex:indexPath.row] ];
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
- (IBAction)btnbtnNumbetOfQuantityPressed:(id)sender
{
    
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

- (IBAction)btnAddPickUpLocationPressed:(id)sender
{
    RSAddPickUpLocationViewController *addPickUp = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAddPickUpLocationViewController"];
    [self.navigationController pushViewController:addPickUp animated:YES];
}

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
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    if (_btnStartDate.tag==2)
    {
        self.testFieldStartDate.text = strDate;
        
    }
    else if(_btnEndDate.tag==2)
    {
        self.textFieldEndDate.text = strDate;
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

@end
