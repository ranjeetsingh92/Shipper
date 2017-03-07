//
//  RSUserViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/24/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSUserViewController.h"
#import "RSUserTableViewCell.h"
#import "RSAddNewUserViewController.h"
#import "RSAddNewUserViewController.h"


@interface RSUserViewController ()
{
    int pageIndx ;
    int pageSiz ;
    RSUserTableViewCell *cell;
    NSDictionary *userDictToDelete;
}

@end

@implementation RSUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pageIndx= 1;
    pageSiz = 5;
    
    self.dataArray =[[NSMutableArray alloc] init];
    [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [SVProgressHUD show];
    [self performSelector:@selector(getFunctionalArea) withObject:nil afterDelay:0];
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(getFunctionalArea) userInfo:nil repeats:YES];
    
}
#pragma mark view did appear
-(void)viewWillAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self performSelector:@selector(getFunctionalArea) withObject:self afterDelay:0.1];
        
    });
}
-(void)getFunctionalArea
{
    
    self.noMoreResultsAvail =NO;

       // [SVProgressHUD show];
    
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"UserId\":%@,\"PageIndex\":%d,\"PageSize\":%d}",[logDict objectForKey:@"subscriptionId"],[logDict objectForKey:@"id"],pageIndx,pageSiz];
    NSLog(@"%@",userUpdate);
    
    //  {"SubscriptionId":30073,"UserId":30101,"PageIndex":1,"PageSize":10}
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_ALL_USERS];
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
             
             self.dataArray = [[NSMutableArray alloc]initWithArray:[rsJson valueForKey:@"accountUsers"]];
             
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

- (IBAction)leftBarButtonPressed:(id)sender
{
    [self.revealViewController revealToggle:self];
}

- (IBAction)addNewUserBtnPressed:(id)sender
{
    RSAddNewUserViewController *addUser = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAddNewUserViewController"];
    [self.navigationController pushViewController:addUser animated:YES];
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
    static NSString *cellIndentifier =@"RSUserTableViewCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell == nil){
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    }
    
    if (self.dataArray.count != 0) {
        if(indexPath.row <[self.dataArray count])
        {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.labelUser          setHidden:NO];
            [cell.labelMobile        setHidden:NO];
            [cell.labelEmailId       setHidden:NO];
            [cell.labelState         setHidden:NO];
            [cell.labelCity          setHidden:NO];
            [cell.labelCreatedDate   setHidden:NO];
            [cell.labelRole          setHidden:NO];
            [cell.labelRegion        setHidden:NO];
            [cell.labelBranch        setHidden:NO];
            [cell.labelDepartment    setHidden:NO];
            [cell.labelFunctionalArea setHidden:NO];
            [cell.labelCreatedBy     setHidden:NO];
            [cell.labelUpdatedDate   setHidden:NO];
            [cell.labelUpdatedBy     setHidden:NO];
            
            [cell.btnEdit               setHidden:NO];
            [cell.btnDelete             setHidden:NO];
            
            [cell.labelFUser          setHidden:NO];
            [cell.labelFMobile        setHidden:NO];
            [cell.labelFEmailId       setHidden:NO];
            [cell.labelFState         setHidden:NO];
            [cell.labelFCity          setHidden:NO];
            [cell.labelFCreatedDate   setHidden:NO];
            [cell.labelFRole          setHidden:NO];
            [cell.labelFRegion        setHidden:NO];
            [cell.labelFBranch        setHidden:NO];
            [cell.labelFDepartment    setHidden:NO];
            [cell.labelFFunctionalArea setHidden:NO];
            [cell.labelFCreatedBy     setHidden:NO];
            [cell.labelFUpdatedDate   setHidden:NO];
            [cell.labelFUpdatedBy     setHidden:NO];
            [cell.bgImageView         setHidden:NO];

            
            [cell.labelUser setText:[NSString stringWithFormat:@"Name : %@ %@ %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"firstName"]],[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"middleName"]],[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"lastName"]]]];
            
            [cell.labelMobile setText:[NSString stringWithFormat:@"Description : %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"mobileNumber"]]]];
            
            
            [cell.labelEmailId setText:[NSString stringWithFormat:@"Created Date : %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"emailId"]]]];
            
            [cell.labelState setText:[NSString stringWithFormat:@"Created By : %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"state"]]]];
            
            [cell.labelCity setText:[NSString stringWithFormat:@"Updated Date : %@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"city"]]]];
            
            
            [cell.labelCreatedDate setText:[NSString stringWithFormat:@"Region : %@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"userRegion"] objectAtIndex:0] valueForKey:@"createdDate"]]]];
            
            [cell.labelRole setText:[NSString stringWithFormat:@"Role : %@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"userRole"] objectAtIndex:0] valueForKey:@"roleName"]]]];
            
            [cell.labelRegion setText:[NSString stringWithFormat:@"Created Date By : %@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"userRegion"] objectAtIndex:0] valueForKey:@"regionName"]]]];
            
            [cell.labelBranch setText:[NSString stringWithFormat:@"Branch : %@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"userBranch"] objectAtIndex:0] valueForKey:@"branchName"]]]];
            
            
            [cell.labelDepartment setText:[NSString stringWithFormat:@"Department : %@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"userDepartment"] objectAtIndex:0] valueForKey:@"departmentName"]]]];
            
            [cell.labelFunctionalArea setText:[NSString stringWithFormat:@"Functional Area : %@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"userFunctionalArea"] objectAtIndex:0] valueForKey:@"unctionalAreaName"]]]];
            
            [cell.labelCreatedBy setText:[NSString stringWithFormat:@"Created By : %@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"userFunctionalArea"] objectAtIndex:0] valueForKey:@"createdBy"]]]];
            
            [cell.labelUpdatedDate setText:[NSString stringWithFormat:@"Updated Date : %@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"userFunctionalArea"] objectAtIndex:0] valueForKey:@"updatedDate"]]]];
            
            [cell.labelUpdatedBy setText:[NSString stringWithFormat:@"Updated By : %@",[Utils returnString:[[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"userFunctionalArea"] objectAtIndex:0] valueForKey:@"updatedBy"]]]];
            
            [cell.btnEdit addTarget:self action:@selector(editBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnDelete addTarget:self action:@selector(deleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
        else{
            if (!self.noMoreResultsAvail) {
                spinner.hidden =YES;
                
                [cell.labelUser          setHidden:YES];
                [cell.labelMobile        setHidden:YES];
                [cell.labelEmailId       setHidden:YES];
                [cell.labelState         setHidden:YES];
                [cell.labelCity          setHidden:YES];
                [cell.labelCreatedDate   setHidden:YES];
                [cell.labelRole          setHidden:YES];
                [cell.labelRegion        setHidden:YES];
                [cell.labelBranch        setHidden:YES];
                [cell.labelDepartment    setHidden:YES];
                [cell.labelFunctionalArea setHidden:YES];
                [cell.labelCreatedBy     setHidden:YES];
                [cell.labelUpdatedDate   setHidden:YES];
                [cell.labelUpdatedBy     setHidden:YES];
                
                [cell.btnEdit               setHidden:YES];
                [cell.btnDelete             setHidden:YES];
                
                [cell.labelFUser          setHidden:YES];
                [cell.labelFMobile        setHidden:YES];
                [cell.labelFEmailId       setHidden:YES];
                [cell.labelFState         setHidden:YES];
                [cell.labelFCity          setHidden:YES];
                [cell.labelFCreatedDate   setHidden:YES];
                [cell.labelFRole          setHidden:YES];
                [cell.labelFRegion        setHidden:YES];
                [cell.labelFBranch        setHidden:YES];
                [cell.labelFDepartment    setHidden:YES];
                [cell.labelFFunctionalArea setHidden:YES];
                [cell.labelFCreatedBy     setHidden:YES];
                [cell.labelFUpdatedDate   setHidden:YES];
                [cell.labelFUpdatedBy     setHidden:YES];
                [cell.bgImageView         setHidden:YES];

                
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
                [cell.labelUser          setHidden:YES];
                [cell.labelMobile        setHidden:YES];
                [cell.labelEmailId       setHidden:YES];
                [cell.labelState         setHidden:YES];
                [cell.labelCity          setHidden:YES];
                [cell.labelCreatedDate   setHidden:YES];
                [cell.labelRole          setHidden:YES];
                [cell.labelRegion        setHidden:YES];
                [cell.labelBranch        setHidden:YES];
                [cell.labelDepartment    setHidden:YES];
                [cell.labelFunctionalArea setHidden:YES];
                [cell.labelCreatedBy     setHidden:YES];
                [cell.labelUpdatedDate   setHidden:YES];
                [cell.labelUpdatedBy     setHidden:YES];
                
                [cell.btnEdit               setHidden:YES];
                [cell.btnDelete             setHidden:YES];
                
                [cell.labelFUser          setHidden:YES];
                [cell.labelFMobile        setHidden:YES];
                [cell.labelFEmailId       setHidden:YES];
                [cell.labelFState         setHidden:YES];
                [cell.labelFCity          setHidden:YES];
                [cell.labelFCreatedDate   setHidden:YES];
                [cell.labelFRole          setHidden:YES];
                [cell.labelFRegion        setHidden:YES];
                [cell.labelFBranch        setHidden:YES];
                [cell.labelFDepartment    setHidden:YES];
                [cell.labelFFunctionalArea setHidden:YES];
                [cell.labelFCreatedBy     setHidden:YES];
                [cell.labelFUpdatedDate   setHidden:YES];
                [cell.labelFUpdatedBy     setHidden:YES];
                [cell.bgImageView         setHidden:YES];

                
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
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"UserId\":%@,\"PageIndex\":%d,\"PageSize\":%d}",[logDict objectForKey:@"subscriptionId"],[logDict objectForKey:@"id"],pageIndx,pageSiz];
    NSLog(@"%@",userUpdate);
    
    //  {"SubscriptionId":30073,"UserId":30101,"PageIndex":1,"PageSize":10}
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_ALL_USERS];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:completeLoginUrlWithSpace]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json"       forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *fPostData = [userUpdate dataUsingEncoding:NSASCIIStringEncoding];
    [request setHTTPBody:fPostData];
    
    NSError *err;
    NSURLResponse *response;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSLog(@"the responce is = %@",responseData);
    NSString *dataString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"the string  is = %@",dataString);
    
    NSData *mData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* dict = [[NSJSONSerialization JSONObjectWithData:mData options:0 error:nil] valueForKey:@"accountUsers"] ;
    NSLog(@"the string  is = %@",dict);
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (data != nil)
         {
             NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             
             NSData *mData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary* skillDict = [NSJSONSerialization JSONObjectWithData:mData options:0 error:nil];
             NSMutableArray *array = [skillDict objectForKey:@"accountUsers"] ;
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

-(void)editBtnPressed:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    
    RSAddNewUserViewController *newBranch = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAddNewUserViewController"];
    newBranch.receiveDataDict = [self.dataArray objectAtIndex:aIndexPath.row];
    [self.navigationController pushViewController:newBranch animated:YES];
}
-(void)deleteBtnPressed:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];
    userDictToDelete = [[NSDictionary alloc]initWithDictionary:[self.dataArray objectAtIndex:aIndexPath.row]];
    UIAlertView *deletAlert = [[UIAlertView alloc]initWithTitle:INFO message:@"Do you want to delete this user???" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [deletAlert show];
    [deletAlert setTag:1];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        if (buttonIndex == 0)
        {
            [SVProgressHUD show];
            
            NSString *userUpdate = [NSString stringWithFormat:@"{\"id\":%@,\"UpdatedBy\":\"%@\"}",[userDictToDelete objectForKey:@"id"],[Utils returnString:[userDictToDelete objectForKey:@"updatedBy"]]];
            NSLog(@"%@",userUpdate);
            
            
            NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,DELETE_USER];
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
                     NSDictionary *deletedDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                     
                     if ([[deletedDict objectForKey:@"isDeleted"] boolValue] ==  true)
                     {
                         [_rTableView reloadData];
                     }
                     else
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
    }
}
@end
