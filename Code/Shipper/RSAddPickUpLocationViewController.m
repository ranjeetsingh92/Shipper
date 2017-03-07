//
//  RSAddPickUpLocationViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/28/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSAddPickUpLocationViewController.h"
#import "RSAddDelieveryLocationViewController.h"

@interface RSAddPickUpLocationViewController ()
{
    NSArray *packageType;
    NSArray *perArr;
    NSArray *selectQuantity;
    NSMutableArray *json;
    BOOL tableShown;
    NSString *cityId;
}

@end

@implementation RSAddPickUpLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableShown = false;
    json = [[NSMutableArray alloc]initWithCapacity:0];
    
    [_rTableView setBackgroundColor:[UIColor whiteColor]];
    _rTableView.layer.cornerRadius = 5.0;
    _rTableView.layer.borderWidth = 1.0;
    _rTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 1000)];
    perArr = [[NSArray alloc]initWithObjects:@"cm",@"in", nil];
    selectQuantity = [[NSArray alloc]initWithObjects:@"Numbers",@"kg",@"Litre", nil];
    
    [self getPackagingType];
    
}

#pragma mark get packaging type
-(void)getPackagingType
{
    [SVProgressHUD show];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        packageType = [[NSMutableArray alloc]initWithArray:[Utils getAllPackagingType]];
        [_rTableView reloadData];
        [SVProgressHUD dismiss];
    });
}
#pragma mark table view data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if (_rTableView.tag==1)
    {
        return [packageType count];
    }
   else if (_rTableView.tag==2)
    {
         return [[[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"stateData"]] valueForKey:@"stateName"] count];
    }
    else if (_rTableView.tag==3)
    {
        return [[json valueForKey:@"city"] count];
    }
    else if (_rTableView.tag==4)
    {
        return [perArr count];
    }
    else
    {
        return [selectQuantity count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ranjit Singh"];
    
    if (_rTableView.tag==1)
    {
        [cell.textLabel setText:[[packageType objectAtIndex:indexPath.row] valueForKey:@"name"]];
    }
    else if (_rTableView.tag==2)
    {
        cell.textLabel.text = [[[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"stateData"]] valueForKey:@"stateName"] objectAtIndex:indexPath.row];
    }
    else if (_rTableView.tag==3)
    {
        [cell.textLabel setText:[[json valueForKey:@"city"] objectAtIndex:indexPath.row]];
        cityId = [[json objectAtIndex:indexPath.row] valueForKey:@"city_ID"];
    }
    else if (_rTableView.tag==4)
    {
        [cell.textLabel setText:[perArr objectAtIndex:indexPath.row]];
    }
    else
    {
        [cell.textLabel setText:[selectQuantity objectAtIndex:indexPath.row]];
    }
    
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    return cell;
}

- (IBAction)btnPackageTypePressed:(id)sender
{
    [_rTableView setTag:1];
    if (_btnPackageType.tag == 1)
    {
        _btnPackageType.tag = 2;
        _btnPer.tag = 2;
        _btnTypeOfWeight.tag    = 1;
        _btnState.tag    = 1;
        _btnCity.tag  = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameOfPackageType];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameOfPackageType];
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
- (IBAction)btnTotalPressed:(id)sender {
}
- (IBAction)btnLocalAddressPressed:(id)sender {
}
- (IBAction)saveBtnPressed:(id)sender {
}

- (IBAction)addMorePickUpLocationPressed:(id)sender {
}

- (IBAction)addDeliveryLocations:(id)sender
{
    RSAddDelieveryLocationViewController *addPickUp = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAddDelieveryLocationViewController"];
    [self.navigationController pushViewController:addPickUp animated:YES];

}

- (IBAction)btnPerPressed:(id)sender
{
    [_rTableView setTag:2];
    if (_btnPer.tag == 1)
    {
        _btnPer.tag = 2;
        _btnPackageType.tag = 1;
        _btnTypeOfWeight.tag    = 1;
        _btnState.tag    = 1;
        _btnCity.tag  = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFramePer];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFramePer];
    }
  
}
- (IBAction)btnTypeOfWeightPressed:(id)sender
{
    [_rTableView setTag:3];
    if (_btnTypeOfWeight.tag == 1)
    {
        _btnTypeOfWeight.tag = 2;
        _btnPackageType.tag = 1;
        _btnPackageType.tag    = 1;
        _btnState.tag    = 1;
        _btnCity.tag  = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameTypeOfWeight];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameTypeOfWeight];
    }
}
- (IBAction)btnStatePressed:(id)sender
{
    [_rTableView setTag:4];
    if (_btnState.tag == 1)
    {
        _btnState.tag = 2;
        _btnPackageType.tag = 1;
        _btnPackageType.tag    = 1;
        _btnTypeOfWeight.tag    = 1;
        _btnCity.tag  = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameOfState];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameOfState];
    }
  
}
- (IBAction)btnCityPressed:(id)sender
{
    [_rTableView setTag:5];
    if (_btnCity.tag == 1)
    {
        _btnCity.tag = 2;
        _btnPackageType.tag = 1;
        _btnPackageType.tag    = 1;
        _btnTypeOfWeight.tag    = 1;
        _btnState.tag  = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameOfCity];
    }
    else
    {
        [self hideAndShowTableVew:tableShown];
        [_rTableView reloadData];
        [self setFrameOfCity];
    }
    
}

#pragma mark set frame of drop down table view
-(void)setFrameOfPackageType
{
    if (25*packageType.count<=200)
    {
         [_rTableView setFrame:CGRectMake(9, 45, 303, 25*packageType.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(9, 45, 303, 200)];
    }
    
   
}
-(void)setFramePer
{
    if (25*packageType.count<=200)
    {
        [_rTableView setFrame:CGRectMake(9, 45, 303, 25*packageType.count)];
    }
    else
    {
        [_rTableView setFrame:CGRectMake(9, 45, 303, 200)];
    }
    
    [_rTableView setFrame:CGRectMake(236, 112, 74, 30)];
}
-(void)setFrameTypeOfWeight
{
    [_rTableView setFrame:CGRectMake(163, 179, 76, 30)];
}
-(void)setFrameOfState
{
    [_rTableView setFrame:CGRectMake(9, 255, 301, 30)];
}
-(void)setFrameOfCity
{
    [_rTableView setFrame:CGRectMake(9, 293, 301, 30)];
}

#pragma mark hitservice to fetch state name

-(void)hitCityService:(NSString *)stateName
{
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@?state=%@",DOMAIN_URL,CITY_LIST,stateName];
    NSString* completeLoginUrl = [completeLoginUrlWithSpace stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [SVProgressHUD show];
    
    
    
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

@end
