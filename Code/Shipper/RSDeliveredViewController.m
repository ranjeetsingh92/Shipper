//
//  RSDeliveredViewController.m
//  Carrier
//
//  Created by QUIKHOP on 10/12/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import "RSDeliveredViewController.h"
#import "RSDeliveredTableViewCell.h"
#import "RSDeliveredDetailsViewController.h"

@interface RSDeliveredViewController ()
{
    int pageIndx ;
    int pageSiz ;
}

@end

@implementation RSDeliveredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray =[[NSMutableArray alloc] init];
    [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [SVProgressHUD show];
    [self performSelector:@selector(getAllWayToPickupLocationLoad) withObject:nil afterDelay:0.0];
    
}
-(void)getAllWayToPickupLocationLoad
{
    self.noMoreResultsAvail =NO;
    pageIndx= 1;
    pageSiz = 5;
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"pageIndex\":%d,\"pageSize\":%d,\"Status\":%@,\"SubscriptionType\":\"%@\",\"WorkingSubscriptionType\":\"%@\"}",[[Utils getLogingDict] objectForKey:@"subscriptionId"],pageIndx,pageSiz,@"16",[[Utils getLogingDict] objectForKey:@"subscriptionType"],@""];
    NSLog(@"%@",userUpdate);
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,RSDELIVERED];
    
    //{"Status":16,"SubscriptionId":60097,"SubscriptionType":"carrier","WorkingSubscriptionType":"","PageIndex":1,"PageSize":10}
    
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
             id rsJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             self.dataArray = [[NSMutableArray alloc]initWithArray:[rsJson valueForKey:@"loadList"]];
             NSLog(@"the json data is = %@", rsJson);
             
             if (self.dataArray.count != 0)
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
- (IBAction)leftBarBtnPressed:(id)sender
{
    [self.revealViewController revealToggle:self];
}

#pragma mark table view data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([ self.dataArray count] ==0){
        return 0;
    }
    else {
        return [self.dataArray count]+1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIndentifier =@"RSDeliveredTableViewCell";
    
    RSDeliveredTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (self.dataArray.count != 0) {
        if(indexPath.row <[self.dataArray count]){
            
            [cell.labelFSNo           setHidden:NO];
            [cell.labelFLoadId        setHidden:NO];
            [cell.labelFComodity      setHidden:NO];
            [cell.labelFCompanyName   setHidden:NO];
            [cell.labelFTotalQuantity setHidden:NO];
            [cell.labelFPlacementDate setHidden:NO];
            [cell.labelFDispatchDate  setHidden:NO];
            [cell.labelFOrigin        setHidden:NO];
            [cell.labelFDestination   setHidden:NO];
            
            [cell.labelSNo           setHidden:NO];
            [cell.labelLoadId        setHidden:NO];
            [cell.labelComodity      setHidden:NO];
            [cell.labelCompanyName   setHidden:NO];
            [cell.labelTotalQuantity setHidden:NO];
            [cell.labelPlacementDate setHidden:NO];
            [cell.labelDispatchDate  setHidden:NO];
            [cell.labelOrigin        setHidden:NO];
            [cell.labelDestination   setHidden:NO];
            [cell.bgImageView        setHidden:NO];
            [cell.lebelSerialNo      setHidden:NO];
            [cell.labelFSNo          setHidden:NO];

            
            [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            
            [cell.lebelSerialNo setText:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
            [cell.labelLoadId setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"fromPickUpLocation"]objectAtIndex:0]valueForKey:@"loadId"]]]];
            
            [cell.labelComodity setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"commodity"]]];
            [cell.labelCompanyName setText:@"Quikhop Logistic Solution Pvt. Ltd."];
            
            [cell.labelTotalQuantity setText:[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"totalQuantityValue"]]];
            [cell.labelPlacementDate setText:[Utils returnString:[[[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"createdDate"] componentsSeparatedByString:@"T"] objectAtIndex:0]]];
            
            [cell.labelDispatchDate setText:[Utils returnString:[[[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"createdDate"] componentsSeparatedByString:@"T"] objectAtIndex:0]]];
            
            [cell.labelOrigin setText:[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"fromPickUpLocation"] objectAtIndex:0] valueForKey:@"fromLocation"]]];
            
            [cell.labelDestination setText:[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"toPickUpLocation"] objectAtIndex:0] valueForKey:@"toLocation"]]];
            
            
        }
        else{
            if (!self.noMoreResultsAvail) {
                spinner.hidden =YES;
                
                [cell.labelFSNo           setHidden:YES];
                [cell.labelFLoadId        setHidden:YES];
                [cell.labelFComodity      setHidden:YES];
                [cell.labelFCompanyName   setHidden:YES];
                [cell.labelFTotalQuantity setHidden:YES];
                [cell.labelFPlacementDate setHidden:YES];
                [cell.labelFDispatchDate  setHidden:YES];
                [cell.labelFOrigin        setHidden:YES];
                [cell.labelFDestination   setHidden:YES];
                
                [cell.labelSNo           setHidden:YES];
                [cell.labelLoadId        setHidden:YES];
                [cell.labelComodity      setHidden:YES];
                [cell.labelCompanyName   setHidden:YES];
                [cell.labelTotalQuantity setHidden:YES];
                [cell.labelPlacementDate setHidden:YES];
                [cell.labelDispatchDate  setHidden:YES];
                [cell.labelOrigin        setHidden:YES];
                [cell.labelDestination   setHidden:YES];
                [cell.bgImageView        setHidden:YES];
                [cell.lebelSerialNo      setHidden:YES];
                [cell.labelFSNo          setHidden:YES];
                
                
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
                
                [cell.labelFSNo           setHidden:YES];
                [cell.labelFLoadId        setHidden:YES];
                [cell.labelFComodity      setHidden:YES];
                [cell.labelFCompanyName   setHidden:YES];
                [cell.labelFTotalQuantity setHidden:YES];
                [cell.labelFPlacementDate setHidden:YES];
                [cell.labelFDispatchDate  setHidden:YES];
                [cell.labelFOrigin        setHidden:YES];
                [cell.labelFDestination   setHidden:YES];
                
                [cell.labelSNo           setHidden:YES];
                [cell.labelLoadId        setHidden:YES];
                [cell.labelComodity      setHidden:YES];
                [cell.labelCompanyName   setHidden:YES];
                [cell.labelTotalQuantity setHidden:YES];
                [cell.labelPlacementDate setHidden:YES];
                [cell.labelDispatchDate  setHidden:YES];
                [cell.labelOrigin        setHidden:YES];
                [cell.labelDestination   setHidden:YES];
                [cell.bgImageView        setHidden:YES];
                [cell.lebelSerialNo      setHidden:YES];
                [cell.labelFSNo          setHidden:YES];
            }
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSDeliveredDetailsViewController *detailVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RSDeliveredDetailsViewController"];
    detailVc.loadId = [[[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"fromPickUpLocation"]objectAtIndex:0]valueForKey:@"loadId"];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}
#pragma mark slider Action

-(void)showDetails:(UIButton *)sender
{
    
}
-(void)detailBtnPressed:(UIButton *)sender
{
    
}
#pragma UIScrollView Method::
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
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    // array = (NSMutableArray *)[Utils hitPlanned:pageIndx pageSize:pageSiz];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"pageIndex\":%d,\"pageSize\":%d,\"Status\":%@,\"SubscriptionType\":\"%@\",\"WorkingSubscriptionType\":\"%@\"}",[[Utils getLogingDict] objectForKey:@"subscriptionId"],pageIndx,pageSiz,@"16",[[Utils getLogingDict] objectForKey:@"subscriptionType"],@""];
    NSLog(@"%@",userUpdate);
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,RSDELIVERED];
    
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
             NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             
             NSData *mData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary* skillDict = [NSJSONSerialization JSONObjectWithData:mData options:0 error:nil];
             NSMutableArray *array = [skillDict objectForKey:@"loadList"] ;
             NSLog(@"The user update is = %@",array);
             [self.dataArray addObjectsFromArray:array];
             NSInteger countAfter = [self.dataArray count];
             [self.rTableView reloadData];
             
             if (countBefore!= countAfter)
             {
                 //[self.rTableView reloadData];
             }
             else
             {
                 [spinner stopAnimating];
                 [spinner hidesWhenStopped];
                 self.noMoreResultsAvail = YES;
             }
         }
         else
         {
             [self loadDataDelayed];
         }
     }];
}
#pragma mark full width separator

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
