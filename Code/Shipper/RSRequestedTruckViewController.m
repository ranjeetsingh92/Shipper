//
//  RSRequestedTruckViewController.m
//  Shipper
//
//  Created by QUIKHOP on 7/7/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSRequestedTruckViewController.h"
#import "RSRequestedMainTableViewCell.h"
#import "RSRequestedSubTableViewCell.h"

@interface RSRequestedTruckViewController ()
{
    int pageIndx ;
    int pageSiz ;
    
    RSRequestedMainTableViewCell *cell;
    RSRequestedSubTableViewCell *subCell;
}

@end

@implementation RSRequestedTruckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pageIndx= 1;
    pageSiz = 5;
    
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
      self.dataArray =[[NSMutableArray alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 800)];
    [self setLoadData];
}
-(void)viewDidAppear:(BOOL)animated
{
    
    self.noMoreResultsAvail =NO;
    if (self.dataArray.count == 0)
    {
        [SVProgressHUD show];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            [ self.dataArray addObjectsFromArray:[Utils getAssignedTruck:[[[_receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"loadId"] pageIndex:pageIndx pageSize:pageSiz]];
            self.rTableView.backgroundColor = [UIColor lightTextColor];
            [_rTableView reloadData];
            [SVProgressHUD dismiss];
        });
    }
}


#pragma mark - Table View
- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    if (section>=0) return YES;
    
    return NO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([ self.dataArray count] ==0){
        return 0;
    }
    else {
        if ([self tableView:tableView canCollapseSection:section])
        {
            if ([expandedSections containsIndex:section])
            {
                return 2; // return rows when expanded
            }
            
            return 1; // only top row showing
        }
        
        // Return the number of rows in the section.
        return self.dataArray.count+1;
    }
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *rCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (rCell == nil) {
        rCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (self.dataArray.count != 0) {
        if(indexPath.row <[self.dataArray count]){
            
            [cell.tImageView setHidden:NO];
            [cell.labelTCompany setHidden:NO];
            [cell.accessoryView setHidden:NO];

            
            // Configure the cell...
            
            if ([self tableView:tableView canCollapseSection:indexPath.section])
            {
                if (!indexPath.row)
                {
                    // first row
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:@"RSRequestedMainTableViewCell" forIndexPath:indexPath];// only top row showing
                    
                    [cell.labelTCompany setText:[NSString stringWithFormat:@"Truck Id :%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"id"]]]];
                    
                    if ([expandedSections containsIndex:indexPath.section])
                    {
                        cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeUp];
                    }
                    else
                    {
                        cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeDown];
                    }
                    return cell;
                }
                else
                {
                    // all other rows
                    
                    subCell = [tableView dequeueReusableCellWithIdentifier:@"RSRequestedSubTableViewCell" forIndexPath:indexPath];
                    
                    [subCell.labelCarrierComapny setText:[NSString stringWithFormat:@"Company Name :%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"companyName"]]]];
                    
                    [subCell.labelTrukMaker setText:[NSString stringWithFormat:@"TruckMaker :%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"truckMake"]]]];
                    
                    [subCell.labelTruckType setText:[NSString stringWithFormat:@"Truck Type:%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"truckType"]]]];
                    
                    [subCell.labelTruckModel setText:[NSString stringWithFormat:@"truck Model :%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"truckModel"]]]];
                    
                    [subCell.labelCarrierType setText:[NSString stringWithFormat:@"Carrier Type :%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"carrierType"]]]];
                    
                    [subCell.labelCapacity setText:[NSString stringWithFormat:@"Capacity :%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"capacity"]]]];
                    
                    [subCell.labelState setText:[NSString stringWithFormat:@"State :%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"state"]]]];
                    
                    [subCell.labelOriginCity setText:[NSString stringWithFormat:@"City Name :%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"originCity"]]]];
                    
                    [subCell.labelStatus setText:[Utils returnStateOfTruck:[[[self.dataArray objectAtIndex:indexPath.section] valueForKey:@"status"] intValue]]];
                    CGSize size = [subCell.labelStatus.text sizeWithAttributes:
                                   @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
                    subCell.labelStatus.frame = CGRectMake(subCell.labelStatus.frame.origin.x, subCell.labelStatus.frame.origin.y, size.width,subCell.labelStatus.frame.size.height);
                    return subCell;
                }
            }
            else
            {
                rCell.accessoryView = nil;
                rCell.textLabel.text = @"Normal Cell";
                
            }
            
            return rCell;
            
        }
        else{
            if (!self.noMoreResultsAvail) {
                spinner.hidden =YES;
                
                [cell.tImageView setHidden:YES];
                [cell.labelTCompany setHidden:YES];
                [cell.accessoryView setHidden:YES];
                
                
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
                
                [cell.tImageView setHidden:YES];
                [cell.labelTCompany setHidden:YES];
                [cell.accessoryView setHidden:YES];

                
//                UILabel* loadingLabel = [[UILabel alloc]init];
//                loadingLabel.font=[UIFont boldSystemFontOfSize:14.0f];
//                loadingLabel.textAlignment = NSTextAlignmentLeft;
//                loadingLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
//                loadingLabel.numberOfLines = 0;
//                loadingLabel.text=@"No More Video Available";
//                loadingLabel.frame=CGRectMake(85,20, 302,25);
//                [cell addSubview:loadingLabel];
            }
            
        }
    }
    return cell;
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
    array = (NSMutableArray *)[Utils getAssignedTruck:[[[_receiveDataDict valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"loadId"] pageIndex:pageIndx pageSize:pageSiz];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            // only first row toggles exapand/collapse
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
                
            }
            else
            {
                [expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }
            
            for (int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i
                                                               inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            
            UITableViewCell *mCell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                
                mCell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeDown];
                
            }
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                mCell.accessoryView =  [ALCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:ALCustomColoredAccessoryTypeUp];
                
            }
        }
        else {
            NSLog(@"Selected Section is %ld and subrow is %ld ",(long)indexPath.section ,(long)indexPath.row);
            
        }
        
    }
    else{
        //DetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        //[self.navigationController pushViewController:controller animated:YES];
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            return 54;
        }
        else
        {
            return 205;
        }
    }
    else
    {
        return 0;
    }

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

#pragma mark set load data

-(void)setLoadData

{
    [self.labelComodityAndQuantity setText:[NSString stringWithFormat:@"%@ %@",
                                            [self.receiveDataDict objectForKey:@"commodity"],[self.receiveDataDict objectForKey:@"totalQuantityValue"]]];
    
    [self.labelCompany             setText:[self.receiveDataDict objectForKey:@"companyName"]];
    [self.labelQuantityType        setText:[self.receiveDataDict objectForKey:@"quantityType"]];
    [self.labelQuantityType        setText:
     [NSString stringWithFormat:@"Pick up date from %@ to %@",
      [self.receiveDataDict valueForKey:@"pickUpStartDate"] ,
      [self.receiveDataDict valueForKey:@"pickUpEndDate"] ]];
    
    [self.labelCreatedState       setText:[self.receiveDataDict objectForKey:@"createdDate"]];
    [self.labelLocation           setText:[NSString stringWithFormat:@"Pick up date from %@ to %@",
                                           [[[self.receiveDataDict objectForKey:@"fromPickUpLocation"]objectAtIndex:0]valueForKey:@"fromLocation"] ,[[[self.receiveDataDict objectForKey:@"toPickUpLocation"]objectAtIndex:0]valueForKey:@"toLocation"] ]];
    
    [self.status setText:[Utils returnStateOfLoad:(int)[[self.receiveDataDict objectForKey:@"status"] integerValue]]];
    CGSize size = [self.status.text sizeWithAttributes:
                   @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
    self.status.frame = CGRectMake(self.status.frame.origin.x, self.status.frame.origin.y, size.width,self.status.frame.size.height);
}

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
