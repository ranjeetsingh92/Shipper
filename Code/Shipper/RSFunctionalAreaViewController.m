//
//  RSFunctionalAreaViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/24/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSFunctionalAreaViewController.h"
#import "RSRegionTableViewCell.h"
#import "RSAddNewFunctionalAreaViewController.h"


@interface RSFunctionalAreaViewController ()
{
    int pageIndx ;
    int pageSiz ;
    RSRegionTableViewCell *cell;
}
@end

@implementation RSFunctionalAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.dataArray =[[NSMutableArray alloc] init];
    [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [SVProgressHUD show];
    [self performSelector:@selector(getAllFunctionalArea) withObject:nil afterDelay:0];
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(getAllFunctionalArea) userInfo:nil repeats:YES];
    
}

#pragma mark view did appear

-(void)viewWillAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self performSelector:@selector(getAllFunctionalArea) withObject:self afterDelay:0.1];
        
    });
}

-(void)getAllFunctionalArea
{
    pageIndx= 1;
    pageSiz = 5;
    self.noMoreResultsAvail =NO;
    
    
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"PageIndex\":%d,\"PageSize\":%d}",[logDict objectForKey:@"subscriptionId"],pageIndx,pageSiz];
    NSLog(@"%@",userUpdate);
    
    //  {"SubscriptionId":30073,"pageIndex":1,"PageSize":1000}
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_ALL_FUNCTIONAL_AREA];
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
             
             self.dataArray = [[NSMutableArray alloc]initWithArray:[rsJson valueForKey:@"functionalArea"]];
             
             if (self.dataArray != nil)
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

- (IBAction)addNewFunctionality:(id)sender
{
    RSAddNewFunctionalAreaViewController *addNewFunctionality = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAddNewFunctionalAreaViewController"];
    [self.navigationController pushViewController:addNewFunctionality animated:YES];
}

- (IBAction)leftBarButtonPressed:(id)sender
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
    static NSString *cellIndentifier =@"RSRegionTableViewCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    }
    
    if (self.dataArray.count != 0) {
        if(indexPath.row <[self.dataArray count])
        {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.labelregion           setHidden:NO];
            [cell.labelDescription      setHidden:NO];
            [cell.labelActive           setHidden:NO];
            [cell.labelCreatedDate      setHidden:NO];
            [cell.labelCreatedBy        setHidden:NO];
            [cell.labelUpdatedDate      setHidden:NO];
            [cell.labelUpdatedBy        setHidden:NO];
            
            [cell.btnEdit               setHidden:NO];
            [cell.btnDelete             setHidden:NO];
            
            [cell.labelFregion      setHidden:NO];
            [cell.labelFDescription setHidden:NO];
            [cell.labelFActive      setHidden:NO];
            [cell.labelFCreatedDate setHidden:NO];
            [cell.labelFCreatedBy   setHidden:NO];
            [cell.labelFUpdatedDate setHidden:NO];
            [cell.labelFUpdatedBy   setHidden:NO];
            [cell.bgImageView       setHidden:NO];

            
          
            
            
            
            
            
            
            [cell.labelregion setText:[NSString stringWithFormat:@"Region : %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"name"]]]];
            
            [cell.labelDescription setText:[NSString stringWithFormat:@"Description : %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"description"]]]];
            
            if ([[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"isActive"] boolValue])
            {
                [cell.labelActive setText:[NSString stringWithFormat:@"Active : %@",@"YES"]];
            }
            else
            {
                [cell.labelActive setText:[NSString stringWithFormat:@"Active : %@",@"NO"]];
            }
            
            
            [cell.labelCreatedDate setText:[NSString stringWithFormat:@"Created Date : %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"createdDate"]]]];
            
            [cell.labelCreatedBy setText:[NSString stringWithFormat:@"Created By : %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"createdBy"]]]];
            
            [cell.labelUpdatedDate setText:[NSString stringWithFormat:@"Updated Date : %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"updatedDate"]]]];
            
            [cell.labelUpdatedBy setText:[NSString stringWithFormat:@"Updated By : %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"updatedBy"]]]];
            
            [cell.btnEdit addTarget:self action:@selector(editBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnDelete addTarget:self action:@selector(deleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
            
        }
        else{
            if (!self.noMoreResultsAvail) {
                spinner.hidden =YES;
                
                [cell.labelregion           setHidden:YES];
                [cell.labelDescription      setHidden:YES];
                [cell.labelActive           setHidden:YES];
                [cell.labelCreatedDate      setHidden:YES];
                [cell.labelCreatedBy        setHidden:YES];
                [cell.labelUpdatedDate      setHidden:YES];
                [cell.labelUpdatedBy        setHidden:YES];
                [cell.btnEdit               setHidden:YES];
                [cell.btnDelete             setHidden:YES];
                
                [cell.labelFregion      setHidden:YES];
                [cell.labelFDescription setHidden:YES];
                [cell.labelFActive      setHidden:YES];
                [cell.labelFCreatedDate setHidden:YES];
                [cell.labelFCreatedBy   setHidden:YES];
                [cell.labelFUpdatedDate setHidden:YES];
                [cell.labelFUpdatedBy   setHidden:YES];
                [cell.bgImageView       setHidden:YES];

                
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
                
                [cell.labelregion           setHidden:YES];
                [cell.labelDescription      setHidden:YES];
                [cell.labelActive           setHidden:YES];
                [cell.labelCreatedDate      setHidden:YES];
                [cell.labelCreatedBy        setHidden:YES];
                [cell.labelUpdatedDate      setHidden:YES];
                [cell.labelUpdatedBy        setHidden:YES];
                [cell.btnEdit               setHidden:YES];
                [cell.btnDelete             setHidden:YES];
                
                [cell.labelFregion      setHidden:YES];
                [cell.labelFDescription setHidden:YES];
                [cell.labelFActive      setHidden:YES];
                [cell.labelFCreatedDate setHidden:YES];
                [cell.labelFCreatedBy   setHidden:YES];
                [cell.labelFUpdatedDate setHidden:YES];
                [cell.labelFUpdatedBy   setHidden:YES];
                [cell.bgImageView       setHidden:YES];
                
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
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
   // array = (NSMutableArray *)[Utils getAllFunctionalArea:pageIndx pageSize:pageSiz];
    
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"PageIndex\":%d,\"PageSize\":%d}",[logDict objectForKey:@"subscriptionId"],pageIndx,pageSiz];
    NSLog(@"%@",userUpdate);
    
    //  {"SubscriptionId":30073,"pageIndex":1,"PageSize":1000}
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_ALL_FUNCTIONAL_AREA];
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
             NSMutableArray *array = [skillDict objectForKey:@"functionalArea"] ;
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

    
//    NSError *err;
//    NSURLResponse *response;
//    
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//    NSLog(@"the responce is = %@",responseData);
//    NSString *dataString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"the string  is = %@",dataString);
//    
//    NSData *mData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray* dict = [[NSJSONSerialization JSONObjectWithData:mData options:0 error:nil] valueForKey:@"functionalArea"] ;
//    NSLog(@"the string  is = %@",dict);

    
//    [self.dataArray addObjectsFromArray:array];
//    NSInteger countAfter = [self.dataArray count];
//    if (countBefore!= countAfter)
//    {
//        [self.rTableView reloadData];
//        
//    }
//    else
//    {
//        [spinner stopAnimating];
//    }
}

-(void)editBtnPressed:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    
    RSAddNewFunctionalAreaViewController *newBranch = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAddNewFunctionalAreaViewController"];
    newBranch.receiveDataDict = [self.dataArray objectAtIndex:aIndexPath.row];
    [self.navigationController pushViewController:newBranch animated:YES];
}
-(void)deleteBtnPressed:(UIButton *)sender
{
    __block NSDictionary *dataDict;
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    
    [SVProgressHUD show];
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"id\":%@,\"isDeleted\":%@,\"createdBy\":\"%@\",\"ipAddress\":\"%@\",\"sourceDecice\":\"%@\",\"sourceBrowser\":\"%@\",\"rowVersion\":\"%@\"}",[logDict objectForKey:@"subscriptionId"],[[self.dataArray objectAtIndex:aIndexPath.row] objectForKey:@"id"],@"true",[logDict objectForKey:@"emailId"],@"",@"",@"",[[self.dataArray objectAtIndex:aIndexPath.row] objectForKey:@"rowVersion"]];
    NSLog(@"%@",userUpdate);
    
    //   {"subscriptionId":30073,"id":30061,"isDeleted":false,"createdBy":"ranjit.singh@quikhop.com","ipAddress":"","sourceDecice":null,"sourceBrowser":"","rowVersion":"AAAAAAACJno="}
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,DELETE_FUNCTIONALITY];
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
             dataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if (dataDict != nil)
             {
                 [Utils messageAlert:RECORD_DELETED title:INFO delegate:self];
                 [self viewDidAppear:YES];
             }
             else
             {
                 [Utils messageAlert:RECORD_NOT_DELETED title:INFO delegate:self];
                 
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
