//
//  RSAddNewFunctionalAreaViewController.m
//  Shipper
//
//  Created by QUIKHOP on 7/20/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSAddNewFunctionalAreaViewController.h"

@interface RSAddNewFunctionalAreaViewController ()
{
    BOOL tebleShown;
    NSArray *regionDict;
    NSString *selectedregionId;
    NSDictionary *dataDict;
}

@end

@implementation RSAddNewFunctionalAreaViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 1000)];
   
    _rTableView.layer.cornerRadius = 5.0;
    _rTableView.layer.borderWidth = 1.0;
    _rTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    tebleShown = false;
    
    if (_receiveDataDict != nil)
    {
        [self setFunctionality];
    }
    
}
-(void)setFunctionality

{
    [_textFieldSelectRegion setText:[_receiveDataDict objectForKey:@"departmentName"]];
    [_textFieldBranch       setText:[_receiveDataDict objectForKey:@"name"]];
    [_textFieldDescription  setText:[_receiveDataDict objectForKey:@"description"]];
}
-(void)viewDidAppear:(BOOL)animated
{
     [_rTableView setBackgroundColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1]];
    
}
-(void)getAllRegion
{
    [SVProgressHUD show];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        regionDict = [[NSArray alloc]initWithArray:[Utils getAllDepartmentToShow]]; ;
         [_rTableView setFrame:CGRectMake(8, 62, 304, 5+(25*[regionDict count]))];
        [_rTableView reloadData];
        [SVProgressHUD dismiss];
    });
}

#pragma mark textfield delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark table show and hide

-(BOOL)tableShowAndHide:(BOOL)isShown

{
    if (!isShown)
    {
        [_rTableView setHidden:NO];
        tebleShown = TRUE;
    }
    else
    {
        [_rTableView setHidden:YES];
        tebleShown = false;
    }
    return tebleShown;
}
- (IBAction)selectRegionBtnPressed:(id)sender
{
    [self getAllRegion];
    [self setFrameOfTableForRegion];
    [self tableShowAndHide:tebleShown];
    
}
- (IBAction)submitBtnPressed:(id)sender
{
    [SVProgressHUD show];
    if ([_textFieldSelectRegion.text isEqualToString:@""]||[_textFieldSelectRegion.text isEqualToString:@""]||[_textFieldSelectRegion.text isEqualToString:@""])
    {
        [Utils messageAlert:FILL_ALL_DATA title:INFO delegate:self];
        [SVProgressHUD dismiss];
    }
    else
    {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            dataDict = [Utils saveNewFunctionalArea:_textFieldBranch.text description:_textFieldDescription.text regionName:_textFieldSelectRegion.text regionId:selectedregionId];
            
            if ([[dataDict objectForKey:@"isSuccess"] boolValue])
            {
                [Utils messageAlert:@"Record has been successfully added" title:INFO delegate:self];
            }
            else
            {
                [Utils messageAlert:[dataDict objectForKey:@"message"] title:INFO delegate:self];
            }
            
            [SVProgressHUD dismiss];
        });
        
    }
}

- (IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark setFrameOfTableView

-(void)setFrameOfTableForRegion
{
   
}

#pragma mark tableview data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[regionDict valueForKey:@"name"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ranjit Singh"];
    cell.textLabel.text = [[regionDict objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_textFieldSelectRegion setText:[[regionDict objectAtIndex:indexPath.row] objectForKey:@"name"]];
    selectedregionId = [[regionDict objectAtIndex:indexPath.row] objectForKey:@"id"];
    [_rTableView setHidden:YES];
    tebleShown = false;
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



@end
