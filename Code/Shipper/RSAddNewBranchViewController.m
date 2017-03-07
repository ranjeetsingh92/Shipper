//
//  RSAddNewBranchViewController.m
//  Shipper
//
//  Created by QUIKHOP on 7/20/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSAddNewBranchViewController.h"

@interface RSAddNewBranchViewController ()
{
    BOOL tebleShown;
    NSArray *regionDict;
    NSString *selectedregionId;
    NSDictionary *dataDict;
}

@end

@implementation RSAddNewBranchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 1000)];
    [_rTableView setBackgroundColor:[UIColor whiteColor]];
    _rTableView.layer.cornerRadius = 5.0;
    _rTableView.layer.borderWidth = 1.0;
    _rTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    tebleShown = false;
    
    if (_receiveDataDict != nil)
    {
        [self setBranchData];
    }
    
}

-(void)setBranchData

{

    
    [_textFieldSelectRegion setText:[_receiveDataDict objectForKey:@"regionName"]];
    [_textFieldBranch       setText:[_receiveDataDict objectForKey:@"name"]];
    [_textFieldDescription  setText:[_receiveDataDict objectForKey:@"description"]];
}
-(void)getAllRegion
{
        [SVProgressHUD show];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            regionDict = [[NSArray alloc]initWithArray:[Utils getAllRegionToShow]]; ;
            self.rTableView.backgroundColor = [UIColor lightTextColor];
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
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            //code to be executed on the main queue after delay
//            dataDict = [Utils saveNewBranch:_textFieldBranch.text description:_textFieldDescription.text regionName:_textFieldSelectRegion.text regionId:selectedregionId];
//            
//            if ([[dataDict objectForKey:@"isSuccess"] boolValue])
//            {
//                [Utils messageAlert:@"Record has been successfully added" title:INFO delegate:self];
//            }
//            else
//            {
//                [Utils messageAlert:[dataDict objectForKey:@"message"] title:INFO delegate:self];
//            }
//            
//            [SVProgressHUD dismiss];
//        });
        
        
        NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
        
        NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"Name\":\"%@\",\"Description\":\"%@\",\"IPAddress\":\"%@\",\"SourceBrowser\":\"%@\",\"CreatedBY\":\"%@\",\"SourceDecice\":\"%@\",\"RegionName\":\"%@\",\"RegionMasterId\":\"%@\"}",[logDict objectForKey:@"subscriptionId"],_textFieldBranch.text,_textFieldDescription.text,@"",@"",[logDict objectForKey:@"emailId"],@"",_textFieldSelectRegion,selectedregionId];
        NSLog(@"%@",userUpdate);
        
        // {"Name":"asdfer","Description":"fgrtaser","RegionName":"abcd","RegionMasterId":20033,"SubscriptionId":30073,"IPAddress":"","SourceBrowser":"","CreatedBY":"","SourceDecice":"SourceDevice"}
        
        
        NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,SAVE_NEW_BRANCH];
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
                 NSDictionary *isSuccess = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 
                 if ([[isSuccess objectForKey:@"isSuccess"] boolValue])
                     {
                         [Utils messageAlert:@"Record has been successfully added" title:INFO delegate:self];
                     }
                     else
                     {
                         [Utils messageAlert:[dataDict objectForKey:@"message"] title:INFO delegate:self];
                     }
                 [SVProgressHUD dismiss];
             }
             else
             {
                 [SVProgressHUD dismiss];
             }
         }];

        
//        NSError *err;
//        NSURLResponse *response;
//        
//        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//        NSLog(@"the responce is = %@",responseData);
//        NSString *dataString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
//        NSLog(@"the string  is = %@",dataString);
//        // [SVProgressHUD dismiss];
//        
//        NSData *mData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *isSuccess = [NSJSONSerialization JSONObjectWithData:mData options:0 error:nil];
//        NSLog(@"the string  is = %@",isSuccess);

        
    }
}

- (IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark setFrameOfTableView

-(void)setFrameOfTableForRegion
{
    [_rTableView setFrame:CGRectMake(8, 62, 304, 200)];
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
