//
//  RSAllAssignTruckViewController.m
//  Shipper
//
//  Created by QUIKHOP on 7/1/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSAllAssignTruckViewController.h"
#import "RSTruckListTableViewCell.h"

@interface RSAllAssignTruckViewController ()
{
    BOOL dropDwonTableShown;
    NSMutableArray *stateArr;
    NSMutableArray *cityArr;
     NSMutableArray *storeIndexArr;
    NSMutableArray *selectedDriver;
    RSTruckListTableViewCell *cell;
    __block NSString *cityStr;
    int pageIndx ;
    int pageSiz ;
   
}

@end

@implementation RSAllAssignTruckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dropDwonTableShown = false;
    [self setLoadData];
    pageIndx= 1;
    pageSiz = 5;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    storeIndexArr = [[NSMutableArray alloc]initWithCapacity:0];
    selectedDriver = [[NSMutableArray alloc]initWithCapacity:0];
    
    _dTableView.layer.cornerRadius = 5.0;
    _dTableView.layer.borderWidth = 1.0;
    _dTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    stateArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.rScrollView setContentSize:CGSizeMake(320, 1200)];
    [self hitStateService];
}

# pragma mark get all state for load

-(void)hitStateService
{
    if (stateArr.count == 0)
    {
        [SVProgressHUD show];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            [ stateArr addObjectsFromArray:[Utils getAllTruckerState]];
            [SVProgressHUD dismiss];
        });
    }
}
#pragma mark hit service to get city for tucker load
-(void)hitServiceToGetTruckerCity:(NSString *)stateId
{

        [SVProgressHUD show];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
             cityArr = (NSMutableArray *)[Utils getAllCityForAvailableTruck:stateId];
            [SVProgressHUD dismiss];
        });

}

#pragma mark hit service to get city for tucker load
-(void)hitServiceToGetAllAvailableTruck:(NSString *)cityArray
{
    if (self.dataArray.count == 0)
    {
        [SVProgressHUD show];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            [ self.dataArray addObjectsFromArray:[Utils getAllAvailableTruckList:cityArray pageIndex:pageIndx pageSize:pageSiz]];
            self.rTableView.backgroundColor = [UIColor lightTextColor];
            [_rTableView reloadData];
            [SVProgressHUD dismiss];
        });
    }
}
-(void)setLoadData
{
    [self.labelCarrierType setText:[Utils returnString:[_receiveDataDict valueForKey:@"powerUnitType"]]];
    [self.labelCommodity setText:[Utils returnString:[_receiveDataDict valueForKey:@"commodity"]]];
    
    if ([[_receiveDataDict valueForKey:@"fromPickUpLocation"] count] != 0)
    {
        NSString *ads = [NSString stringWithFormat:@"%@, %@ ,%@",
                         [Utils returnString:[[[_receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"fromLocation"]],
                         [Utils returnString:[[[_receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"pickUpCity"]],
                         [Utils returnString:[[[_receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"pickUpState"]]];
        
        [self.labelFromLocation setText:ads];
        [self.labelCreatedDate setText:[Utils returnString:[[[_receiveDataDict valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"updatedDate"]]];

    }
    else
    {
        [self.labelFromLocation setText:@""];
        [self.labelCreatedDate setText:@""];
    }
    if ([[_receiveDataDict valueForKey:@"toPickUpLocation"] count] != 0)
    {
        NSString *adsToLocation = [NSString stringWithFormat:@"%@, %@ ,%@",
                                   [Utils returnString:[[[_receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"toLocation"]],
                                   [Utils returnString:[[[_receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"dispatchCity"]],
                                   [Utils returnString:[[[_receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"dispatchState"]]];
        
        [self.labelToLocation setText:[Utils returnString:adsToLocation]];
    }
    else
    {
         [self.labelToLocation setText:@""];
    }
    
    [self.labelQuantityType setText:[Utils returnString:[_receiveDataDict valueForKey:@"quantityType"]]];
    
    
    [self.labelQuantityNumbers setText:[Utils returnString:[_receiveDataDict valueForKey:@"totalQuantityValue"]]];
    
    [self.labelPickUpDate setText:[Utils returnString:[_receiveDataDict valueForKey:@"pickUpStartDate"]]];
    
    [self.labelDispatchDate setText:[Utils returnString:[_receiveDataDict valueForKey:@"pickUpEndDate"]]];
    [self.labelYourOfferPrice setText:[Utils returnString:[_receiveDataDict valueForKey:@"yourOfferPrice"]]];
    [self.labelUpdatedDate setText:[Utils returnString:[_receiveDataDict valueForKey:@"updatedDate"]]];
    [self.labelStatus setText:[Utils returnStateOfLoad:[[Utils returnString:[_receiveDataDict valueForKey:@"status"]] intValue]]];
    CGSize size = [self.labelStatus.text sizeWithAttributes:
                   @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
    self.labelStatus.frame = CGRectMake(self.labelStatus.frame.origin.x, self.labelStatus.frame.origin.y, size.width+5,self.labelStatus.frame.size.height);
}

#pragma mark table view data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (tableView == self.dTableView)
    {
        if (_dTableView.tag == 1)
        {
            return stateArr.count;
        }
        else
        {
            return cityArr.count;
        }
    }
    else
    {
        if([ self.dataArray count] ==0){
            return 0;
        }
        else {
            return [self.dataArray count]+1;
        }
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.dTableView)
    {
        if (_dTableView.tag == 1)
        {
            UITableViewCell *dcell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ranjit Singh"];
            [dcell.textLabel setText:[[stateArr valueForKey:@"stateName"] objectAtIndex:indexPath.row] ];
            dcell.textLabel.font = [UIFont systemFontOfSize:12];
            dcell.textLabel.textColor = [UIColor darkGrayColor];
            return dcell;
            
        }
        else
        {
            UITableViewCell *dcell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ranjit Singh"];
            [dcell.textLabel setText:[[cityArr objectAtIndex:indexPath.row] valueForKey:@"originCity"]];
            dcell.textLabel.font = [UIFont systemFontOfSize:12];
            dcell.textLabel.textColor = [UIColor darkGrayColor];
            return dcell;
        }
    }
    else
    {
        static NSString *cellIndentifier =@"RSTruckListTableViewCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if(cell == nil){
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
        }
        
        if (self.dataArray.count != 0) {
            if(indexPath.row <[self.dataArray count]){
               
                [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
                if (![storeIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
                {
                    [cell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
                    
                }
                else
                {
                    [cell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
                }
                
                [cell.btnCheck setHidden:NO];
                [cell.truckImageView setHidden:NO];
                [cell.labelTruckId setHidden:NO];
                [cell.labelCarrierName setHidden:NO];
                [cell.labelCarrierType setHidden:NO];
                [cell.labelState setHidden:NO];
                [cell.labelTruckMaker setHidden:NO];
                [cell.labelCapacity setHidden:NO];
                [cell.labelOriginCity setHidden:NO];
                [cell.labelTruckType setHidden:NO];
                [cell.fLabelTruckId setHidden:NO];
                [cell.fLabelCarrierName setHidden:NO];
                [cell.fLabelCarrierType setHidden:NO];
                [cell.fLabelTruckMaker setHidden:NO];
                [cell.fLabelCapacity setHidden:NO];
                [cell.fLabelOriginCity setHidden:NO];
                [cell.fLabelTruckType setHidden:NO];
                [cell.fLabelState setHidden:NO];

                [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.labelTruckId setText:[Utils returnString:[[self.dataArray objectAtIndex: indexPath.row] valueForKey:@"truckRegistrationNo"]]];
                [cell.labelCarrierName setText:[Utils returnString:[[self.dataArray objectAtIndex: indexPath.row] valueForKey:@"companyName"]]];
                [cell.labelCarrierType setText:[Utils returnString:[[self.dataArray objectAtIndex: indexPath.row] valueForKey:@"carrierType"]]];
                [cell.labelState setText:[Utils returnString:[[self.dataArray objectAtIndex: indexPath.row] valueForKey:@"state"]]];
                [cell.labelTruckMaker setText:[Utils returnString:[[self.dataArray objectAtIndex: indexPath.row] valueForKey:@"truckMake"]]];
                [cell.labelCapacity setText:[Utils returnString:[[self.dataArray objectAtIndex: indexPath.row] valueForKey:@"capacity"]]];
                [cell.labelOriginCity setText:[Utils returnString:[[self.dataArray objectAtIndex: indexPath.row] valueForKey:@"originCity"]]];
                [cell.labelTruckType setText:[Utils returnString:[[self.dataArray objectAtIndex: indexPath.row] valueForKey:@"truckType"]]];
                [cell.btnCheck addTarget:self action:@selector(checkBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            else{
                if (!self.noMoreResultsAvail) {
                    spinner.hidden =YES;
                    
                    [cell.btnCheck         setHidden:YES];
                    [cell.truckImageView   setHidden:YES];
                    [cell.labelTruckId     setHidden:YES];
                    [cell.labelCarrierName setHidden:YES];
                    [cell.labelCarrierType setHidden:YES];
                    [cell.labelState       setHidden:YES];
                    [cell.labelTruckMaker  setHidden:YES];
                    [cell.labelCapacity    setHidden:YES];
                    [cell.labelOriginCity  setHidden:YES];
                    [cell.labelTruckType   setHidden:YES];
                    [cell.fLabelTruckId    setHidden:YES];
                    [cell.fLabelCarrierName setHidden:YES];
                    [cell.fLabelCarrierType setHidden:YES];
                    [cell.fLabelTruckMaker  setHidden:YES];
                    [cell.fLabelCapacity    setHidden:YES];
                    [cell.fLabelOriginCity  setHidden:YES];
                    [cell.fLabelTruckType   setHidden:YES];
                    [cell.fLabelState       setHidden:YES];
                    
                    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    spinner.frame = CGRectMake(150, 10, 24, 50);
                    spinner.color = [UIColor colorWithRed:153.0/255 green:0.0/255 blue:0.0/255 alpha:1];
                    [cell addSubview:spinner];
                    if ([self.dataArray count] >= 5)
                    {
                        
                        [spinner startAnimating];
                        
                    }
                }
                else{
                    [spinner stopAnimating];
                    spinner.hidden=YES;
                    
                    [cell.btnCheck         setHidden:YES];
                    [cell.truckImageView   setHidden:YES];
                    [cell.labelTruckId     setHidden:YES];
                    [cell.labelCarrierName setHidden:YES];
                    [cell.labelCarrierType setHidden:YES];
                    [cell.labelState       setHidden:YES];
                    [cell.labelTruckMaker  setHidden:YES];
                    [cell.labelCapacity    setHidden:YES];
                    [cell.labelOriginCity  setHidden:YES];
                    [cell.labelTruckType   setHidden:YES];
                    [cell.fLabelTruckId    setHidden:YES];
                    [cell.fLabelCarrierName setHidden:YES];
                    [cell.fLabelCarrierType setHidden:YES];
                    [cell.fLabelTruckMaker  setHidden:YES];
                    [cell.fLabelCapacity    setHidden:YES];
                    [cell.fLabelOriginCity  setHidden:YES];
                    [cell.fLabelTruckType   setHidden:YES];
                    [cell.fLabelState       setHidden:YES];
                    
                    
//                    UILabel* loadingLabel = [[UILabel alloc]init];
//                    loadingLabel.font=[UIFont boldSystemFontOfSize:14.0f];
//                    loadingLabel.textAlignment = NSTextAlignmentLeft;
//                    loadingLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
//                    loadingLabel.numberOfLines = 0;
//                    loadingLabel.text=@"No More Video Available";
//                    loadingLabel.frame=CGRectMake(85,20, 302,25);
//                    [cell addSubview:loadingLabel];
                }
                
            }
        }
        return cell;

    }
    
}

#pragma UIScrollView Method:
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!self.loading) {
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self performSelector:@selector(loadDataDelayed) withObject:nil afterDelay:1];
        }
    }
}

#pragma UserDefined Method for generating data which are show in Table :::
-(void)loadDataDelayed
{
    if (self.dataArray.count%5 == 0)
    {
        pageIndx = (int)self.dataArray.count/5;
        pageIndx = ++pageIndx;
    }
    else
    {
        pageIndx = (int)self.dataArray.count/5;
        pageIndx = pageIndx+2;
    }
    NSInteger countBefore = [self.dataArray count];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    array = (NSMutableArray *)[Utils getAllAvailableTruckList:cityStr pageIndex:pageIndx pageSize:pageSiz];
    
    [self.dataArray addObjectsFromArray:array];
    NSInteger countAfter = [self.dataArray count];
    if (countBefore!= countAfter)
    {
        [self.rTableView reloadData];
        
    }
    else
    {
        [spinner stopAnimating];
    }
}
-(void)checkBtnPressed:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    cell = (RSTruckListTableViewCell *)[_rTableView cellForRowAtIndexPath:aIndexPath];
    if ([storeIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]])
    {
        [cell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
        [storeIndexArr removeObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
        NSString *deSelectedArrStr = [self.dataArray objectAtIndex:(long)aIndexPath.row];
        [selectedDriver removeObject:deSelectedArrStr];
        
    }
    else
    {
        [cell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
        [storeIndexArr addObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
        NSString *selectedArrStr = [self.dataArray objectAtIndex:(long)aIndexPath.row];
        [selectedDriver addObject:selectedArrStr];
    }
    NSLog(@"the selected city is = %@",selectedDriver);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.dTableView)
    {
        if (_dTableView.tag == 1)
        {
            [_textFieldSelectState setText:[[stateArr objectAtIndex:indexPath.row] valueForKey:@"stateName"]];
            [self hitServiceToGetTruckerCity:[[stateArr objectAtIndex:indexPath.row] valueForKey:@"id"]];
            [_dTableView setHidden:YES];
            dropDwonTableShown = false;
            
        }
        else
        {
            [_textFieldSelectCity setText: [[cityArr objectAtIndex:indexPath.row] valueForKey:@"originCity"]];
            [_dTableView setHidden:YES];
            dropDwonTableShown = false;
            
           
        }
    }
    else
    {
        
    }
}

- (IBAction)btnSelectStatePressed:(id)sender
{
    [_dTableView setTag:1];
    if (_btnSelectState.tag == 1)
    {
        _btnSelectCity.tag     = 1;
        _btnSelectState.tag       = 2;
        [_dTableView setHidden:NO];
        dropDwonTableShown = true;
        
        [_dTableView reloadData];
        [self setFrameForState];
    }
    else
    {
        [self hideAndShowDropDown:dropDwonTableShown];
        [_dTableView reloadData];
        [self setFrameForState];
        
    }
  
}
- (IBAction)btnSelectCityPressed:(id)sender
{
    [_dTableView setTag:2];
    if (_btnSelectCity.tag == 1)
    {
        _btnSelectState.tag      = 1;
        _btnSelectCity.tag       = 2;
        [_dTableView setHidden:NO];
        dropDwonTableShown = true;
        
        [_dTableView reloadData];
        [self setFrameForCity];
    }
    else
    {
        [self hideAndShowDropDown:dropDwonTableShown];
        [_dTableView reloadData];
        [self setFrameForCity];
        
    }
}
#pragma mark set frame of drop down table view

-(void)setFrameForState

{
    [_dTableView setFrame:CGRectMake(5, 300, 307, 200)];
}
-(void)setFrameForCity

{
    [_dTableView setFrame:CGRectMake(5, 336, 287, 200)];
}

#pragma mark drop don table view show and hide

-(BOOL) hideAndShowDropDown:(BOOL)isShown

{
    if(!isShown)
    {
        [_dTableView setHidden:NO];
        dropDwonTableShown = true;
    }
    else
    {
        [_dTableView setHidden:YES];
        dropDwonTableShown = false;
    }
    return dropDwonTableShown;
}

- (IBAction)searchBtnAction:(id)sender
{
    NSMutableDictionary *selectedCityDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:_textFieldSelectCity.text, @"City",nil ];
    NSMutableArray *dataAr = [[NSMutableArray alloc]initWithObjects:selectedCityDict, nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataAr options:kNilOptions error:&error];
    cityStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self hitServiceToGetAllAvailableTruck:cityStr];
    
}


















@end
