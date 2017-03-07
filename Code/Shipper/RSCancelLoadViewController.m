//
//  RSCancelLoadViewController.m
//  Shipper
//
//  Created by QUIKHOP on 1/11/17.
//  Copyright © 2017 QUIKHOP. All rights reserved.
//

#import "RSCancelLoadViewController.h"

@interface RSCancelLoadViewController ()
{
    NSMutableArray *reasonArray;
    BOOL tableShown;
}

@end

@implementation RSCancelLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rTableView.layer.cornerRadius = 5.0;
    
    reasonArray = [[NSMutableArray alloc]initWithCapacity:0];
    [_rTableView setHidden:YES];
    tableShown = false;
    
    self.descriptionTextView.text = @"Enter description";
    self.descriptionTextView.textColor = [UIColor lightGrayColor];
    self.descriptionTextView.delegate = self;
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    self.descriptionTextView.text = @"";
    self.descriptionTextView.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(self.descriptionTextView.text.length == 0){
        self.descriptionTextView.textColor = [UIColor lightGrayColor];
        self.descriptionTextView.text = @"Enter description";
        [self.descriptionTextView resignFirstResponder];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(getAllReasonForCancelLoad) withObject:nil afterDelay:0.0];
}


- (IBAction)btnDropDownPressed:(id)sender
{
    [self showAndHideTableView:tableShown];
    [self setFrameOfTableView];
}

- (IBAction)submitBtnPressed:(id)sender
{
    [SVProgressHUD show];
    
    int row = (int)[[reasonArray valueForKey:@"reason"] indexOfObject:_textFieldReason.text];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"LoadId\":%@,\"ReasonId\":%@,\"Reason\":\"%@\",\"Description\":\"%@\",\"CreatedBy\":\"%@\",\"UpdatedBy\":\"%@\",\"IPAddress\":\"%@\",\"SourceBrowser\":\"%@\",\"SourceDecice\":\"%@\"}",[NSString stringWithFormat:@"%@",[[Utils getLogingDict] objectForKey:@"subscriptionId"]],[[[_receiveDataDict objectForKey:@"toPickUpLocation"] objectAtIndex:0]objectForKey:@"loadId"],[NSString stringWithFormat:@"%@",[[reasonArray valueForKey:@"id"] objectAtIndex:row]],_textFieldReason.text,_descriptionTextView.text,[[Utils getLogingDict] objectForKey:@"createdBy"],[Utils returnString:[[Utils getLogingDict] objectForKey:@"updatedBy"]],@"",@"",@""];
    
    NSLog(@"%@",userUpdate);
    
    //{"SubscriptionId":60096,"LoadId":50354,"ReasonId":6,"Reason":"Rate Not Matched","Description":"yes","CreatedBy":"pankaj.kumar@quikhop.com","UpdatedBy":"pankaj.kumar@quikhop.com","IPAddress":"182.71.8.114","SourceBrowser":"Chrome 55.0","SourceDecice":"SoroleceDevice"}
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,CANCEL_LIST];
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
             
             NSDictionary *deletedDict = [[NSDictionary alloc]initWithDictionary:rsJson copyItems:YES];
             
             if ([[deletedDict objectForKey:@"isDeleted"] boolValue] == true)
             {
                 [Utils messageAlert:CANCEL_LOAD title:INFO delegate:self];
             }
             else
             {
              [Utils messageAlert:NOT_CANCEL_LOAD title:INFO delegate:self];
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
    return reasonArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ranjit Singh"];
    [cell.textLabel setText:[[reasonArray objectAtIndex:indexPath.row] objectForKey:@"reason"]];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_textFieldReason setText:[[reasonArray objectAtIndex:indexPath.row] objectForKey:@"reason"]];
    [_rTableView setHidden:YES];
    tableShown = false;
}

#pragma mark get all reason list
-(void)getAllReasonForCancelLoad
{
 
        [SVProgressHUD show];
        
        NSLog(@"%@",[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]]);
        NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
        
        NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@}",[logDict objectForKey:@"subscriptionId"]];
        NSLog(@"%@",userUpdate);
        
        //{"SubscriptionId":30073,"Status":5,"TruckRequestStatus":0,"CreatedBy":"ranjit.singh@quikhop.com","IsAll":false,"PageIndex":1,"PageSize":5}
        
        NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,REASON_LIST];
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
                 
                 reasonArray = [[NSMutableArray alloc]initWithArray:rsJson copyItems:YES];
                 
                 if (reasonArray != nil)
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

-(BOOL)showAndHideTableView:(BOOL)shown
{
    if (shown)
    {
        [_rTableView setHidden:YES];
        tableShown = false;
    }
    else
    {
        [_rTableView setHidden:NO];
        tableShown = true;
    }
    return tableShown;
}

-(void)setFrameOfTableView
{
    [_rTableView setFrame:CGRectMake(_rTableView.frame.origin.x, _rTableView.frame.origin.y, _rTableView.frame.size.width, 25*reasonArray.count)];
}

@end
