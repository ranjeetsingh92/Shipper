   //
//  RSClientViewController.m
//  Shipper
//
//  Created by QUIKHOP on 6/24/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSClientViewController.h"
#import "RSClientTableViewCell.h"
#import "RSAddClientViewController.h"


@interface RSClientViewController ()
{
    int pageIndx ;
    int pageSiz ;
    
    RSClientTableViewCell *cell;
   
}

@end

@implementation RSClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray =[[NSMutableArray alloc] init];
    [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [SVProgressHUD show];
    [self performSelector:@selector(getAllClient) withObject:nil afterDelay:0];
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(getAllClient) userInfo:nil repeats:YES];


}
-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.findScreenStr = @"AddClient";
}
-(void)getAllClient
{
    pageIndx= 1;
    pageSiz = 5;
    self.noMoreResultsAvail =NO;
    
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"PageIndex\":%d,\"PageSize\":%d}",[logDict objectForKey:@"subscriptionId"],pageIndx,pageSiz];
    NSLog(@"%@",userUpdate);
    
    //  {"SubscriptionId":30073,"pageIndex":1,"PageSize":1000}
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_ALL_CLIENT];
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
             
             self.dataArray = [[NSMutableArray alloc]initWithArray:[rsJson valueForKey:@"clientList"]];
             
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
    static NSString *cellIndentifier =@"RSClientTableViewCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    }
    
    if (self.dataArray.count != 0) {
        if(indexPath.row <[self.dataArray count])
        {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.labelClientName                    setHidden:NO];
            [cell.labelPhone                         setHidden:NO];
            [cell.labelComapnyAddress                setHidden:NO];
            [cell.labelContactPersona                setHidden:NO];
            [cell.labelContactNo                     setHidden:NO];
            [cell.labelSecondaryContactPerson        setHidden:NO];
            [cell.labelSecondaryContactNo            setHidden:NO];
            [cell.labelPan                           setHidden:NO];
            [cell.labelTan                           setHidden:NO];
            [cell.labelStn                           setHidden:NO];
            [cell.labelCin                           setHidden:NO];
            [cell.labelState                         setHidden:NO];
            [cell.labelCity                          setHidden:NO];
            [cell.labelCreatedDate                   setHidden:NO];
            
            [cell.btnEdit                            setHidden:NO];
            [cell.btnDelete                          setHidden:NO];
            
            [cell.labelFClientName                    setHidden:NO];
            [cell.labelFPhone                         setHidden:NO];
            [cell.labelFComapnyAddress                setHidden:NO];
            [cell.labelFContactPersona                setHidden:NO];
            [cell.labelFContactNo                     setHidden:NO];
            [cell.labelFSecondaryContactPerson        setHidden:NO];
            [cell.labelFSecondaryContactNo        setHidden:NO];
            [cell.labelFPan                           setHidden:NO];
            [cell.labelFTan                           setHidden:NO];
            [cell.labelFStn                           setHidden:NO];
            [cell.labelFCin                           setHidden:NO];
            [cell.labelFState                         setHidden:NO];
            [cell.labelFCity                          setHidden:NO];
            [cell.labelFCreatedDate                   setHidden:NO];
            [cell.bgImageView                         setHidden:NO];

            
            
            [cell.labelClientName setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"companyName"]]]];
            
            [cell.labelPhone setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"phone"]]]];
            
            [cell.labelComapnyAddress setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"companyAddress"]]]];
            
            [cell.labelContactPersona setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"contactPerson1"]]]];
            
            [cell.labelContactNo setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"contactNo1"]]]];
            
            [cell.labelSecondaryContactPerson setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"contactPerson2"]]]];
            
            [cell.labelSecondaryContactNo setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"contactNo2"]]]];
            
            [cell.labelPan setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"pan"]]]];
            
            [cell.labelTan setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"tan"]]]];
            
            [cell.labelStn setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"stn"]]]];
            
            [cell.labelCin setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"cin"]]]];
            
            [cell.labelState setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"state"]]]];
            
            [cell.labelCity setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"city"]]]];
            
            [cell.labelCreatedDate setText:[NSString stringWithFormat:@"%@",[Utils returnString:[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"createdDate"]]]];
            
            [cell.btnEdit addTarget:self action:@selector(editBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnDelete addTarget:self action:@selector(deleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
            
        }
        else{
            if (!self.noMoreResultsAvail) {
                spinner.hidden =YES;
                
                [cell.labelClientName                    setHidden:YES];
                [cell.labelPhone                         setHidden:YES];
                [cell.labelComapnyAddress                setHidden:YES];
                [cell.labelContactPersona                setHidden:YES];
                [cell.labelContactNo                     setHidden:YES];
                [cell.labelSecondaryContactPerson        setHidden:YES];
                [cell.labelSecondaryContactNo        setHidden:YES];
                [cell.labelPan                           setHidden:YES];
                [cell.labelTan                           setHidden:YES];
                [cell.labelStn                           setHidden:YES];
                [cell.labelCin                           setHidden:YES];
                [cell.labelState                         setHidden:YES];
                [cell.labelCity                          setHidden:YES];
                [cell.labelCreatedDate                   setHidden:YES];
                
                [cell.btnEdit                            setHidden:YES];
                [cell.btnDelete                          setHidden:YES];
                
                [cell.labelFClientName                    setHidden:YES];
                [cell.labelFPhone                         setHidden:YES];
                [cell.labelFComapnyAddress                setHidden:YES];
                [cell.labelFContactPersona                setHidden:YES];
                [cell.labelFContactNo                     setHidden:YES];
                [cell.labelFSecondaryContactPerson        setHidden:YES];
                [cell.labelFSecondaryContactNo        setHidden:YES];
                [cell.labelFPan                           setHidden:YES];
                [cell.labelFTan                           setHidden:YES];
                [cell.labelFStn                           setHidden:YES];
                [cell.labelFCin                           setHidden:YES];
                [cell.labelFState                         setHidden:YES];
                [cell.labelFCity                          setHidden:YES];
                [cell.labelFCreatedDate                   setHidden:YES];
                [cell.bgImageView                         setHidden:YES];
                
                
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
                
                
                [cell.labelClientName                    setHidden:YES];
                [cell.labelPhone                         setHidden:YES];
                [cell.labelComapnyAddress                setHidden:YES];
                [cell.labelContactPersona                setHidden:YES];
                [cell.labelContactNo                     setHidden:YES];
                [cell.labelSecondaryContactPerson        setHidden:YES];
                [cell.labelSecondaryContactNo            setHidden:YES];
                [cell.labelPan                           setHidden:YES];
                [cell.labelTan                           setHidden:YES];
                [cell.labelStn                           setHidden:YES];
                [cell.labelCin                           setHidden:YES];
                [cell.labelState                         setHidden:YES];
                [cell.labelCity                          setHidden:YES];
                [cell.labelCreatedDate                   setHidden:YES];
                
                [cell.btnEdit                            setHidden:YES];
                [cell.btnDelete                          setHidden:YES];
                
                [cell.labelFClientName                    setHidden:YES];
                [cell.labelFPhone                         setHidden:YES];
                [cell.labelFComapnyAddress                setHidden:YES];
                [cell.labelFContactPersona                setHidden:YES];
                [cell.labelFContactNo                     setHidden:YES];
                [cell.labelFSecondaryContactPerson        setHidden:YES];
                [cell.labelFSecondaryContactNo        setHidden:YES];
                [cell.labelFPan                           setHidden:YES];
                [cell.labelFTan                           setHidden:YES];
                [cell.labelFStn                           setHidden:YES];
                [cell.labelFCin                           setHidden:YES];
                [cell.labelFState                         setHidden:YES];
                [cell.labelFCity                          setHidden:YES];
                [cell.labelFCreatedDate                   setHidden:YES];
                [cell.bgImageView                         setHidden:YES];

                
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
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"PageIndex\":%d,\"PageSize\":%d}",[logDict objectForKey:@"subscriptionId"],pageIndx,pageSiz];
    NSLog(@"%@",userUpdate);
    
    //  {"SubscriptionId":30073,"pageIndex":1,"PageSize":1000}
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_ALL_CLIENT];
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
             NSMutableArray *array = [skillDict objectForKey:@"clientList"] ;
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
    
    RSAddClientViewController *addClient = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAddClientViewController"];
    addClient.receiveDataDict = [self.dataArray objectAtIndex:aIndexPath.row];
    [self.navigationController pushViewController:addClient animated:YES];
}
-(void)deleteBtnPressed:(UIButton *)sender
{
    __block NSDictionary *dataDict;
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_rTableView];
    NSIndexPath *aIndexPath = [_rTableView indexPathForRowAtPoint:buttonPosition];

    
    [SVProgressHUD show];
    
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"id\":%@,\"isDeleted\":%@,\"createdBy\":\"%@\",\"ipAddress\":\"%@\",\"sourceDecice\":\"%@\",\"sourceBrowser\":\"%@\",\"rowVersion\":\"%@\"}",[logDict objectForKey:@"subscriptionId"],[[self.dataArray objectAtIndex:aIndexPath.row] objectForKey:@"id"],@"false",[logDict objectForKey:@"emailId"],@"",@"",@"",[[self.dataArray objectAtIndex:aIndexPath.row] objectForKey:@"rowVersion"]];
    NSLog(@"%@",userUpdate);
    
    //   {"subscriptionId":30073,"id":30061,"isDeleted":false,"createdBy":"ranjit.singh@quikhop.com","ipAddress":"","sourceDecice":null,"sourceBrowser":"","rowVersion":"AAAAAAACJno="}
    
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,DELETE_CLIENT];
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

- (IBAction)leftBarButtonPressed:(id)sender
{
    [self.revealViewController revealToggle:self];
}

- (IBAction)addNewClientBtnPressed:(id)sender
{
    RSAddClientViewController *addClient = [self.storyboard instantiateViewControllerWithIdentifier:@"RSAddClientViewController"];
    [self.navigationController pushViewController:addClient animated:YES];
    
}

@end
