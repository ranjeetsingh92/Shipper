//
//  RSAddClientViewController.m
//  Shipper
//
//  Created by QUIKHOP on 7/15/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSAddClientViewController.h"
#import "Annotation.h"


@interface RSAddClientViewController ()
{
    BOOL tableShown;
    NSArray *stateArray;
    NSDictionary *dataDict;
     __block NSArray *json;
    CLLocationCoordinate2D curLatLong;
    NSString *stateId;
    NSString *cityId;
}


@end 

@implementation RSAddClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.rScrollView setContentSize:CGSizeMake(320, 1000)];
    [_rTableView setBackgroundColor:[UIColor whiteColor]];
    _rTableView.layer.cornerRadius = 5.0;
    _rTableView.layer.borderWidth = 1.0;
    _rTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    tableShown = false;
    if (_receiveDataDict != nil)
    {
        [self searchBtnPressed:self];
        [self setClientData];
    }
    
    stateId = [_receiveDataDict objectForKey:@"stateId"];
    cityId = [_receiveDataDict objectForKey:@"cityId"];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [SVProgressHUD show];
    NSString *completeLoginUrl = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,STATE_LIST];
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
             stateArray = [[NSMutableArray alloc]initWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
             NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
             [def setObject:[NSKeyedArchiver archivedDataWithRootObject:stateArray] forKey:@"stateData"];
             [def synchronize];

             
             if (stateArray != nil)
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
-(void)setClientData
{
    
    [_textFieldCompanyName       setText:[Utils returnString:[_receiveDataDict objectForKey:@"companyName"]]];
    [_textFieldEwbAddress        setText:[Utils returnString:[_receiveDataDict objectForKey:@"companyUrl"]]];
    [_textFieldMobileNo          setText:[Utils returnString:[_receiveDataDict objectForKey:@"phone"]]];
    [_textFieldFax               setText:[Utils returnString:[_receiveDataDict objectForKey:@"fax"]]];
    [_textFieldState             setText:[Utils returnString:[_receiveDataDict objectForKey:@"state"]]];
    
    [_textFieldCity              setText:[Utils returnString:[_receiveDataDict objectForKey:@"city"]]];
    [_textFieldPanNo             setText:[Utils returnString:[_receiveDataDict objectForKey:@"pan"]]];
    [_rexrFieldPostalCode        setText:[Utils returnString:[_receiveDataDict objectForKey:@"pinCode"]]];
    [_textFieldCompanyAddress    setText:[Utils returnString:[_receiveDataDict objectForKey:@"companyAddress"]]];
    [_textFieldCinNo             setText:[Utils returnString:[_receiveDataDict objectForKey:@"cin"]]];
    
    [_TextFieldTanNo             setText:[Utils returnString:[_receiveDataDict objectForKey:@"tan"]]];
    [_TextFieldSTNo              setText:[Utils returnString:[_receiveDataDict objectForKey:@"stn"]]];
    [_TextFieldContactPerson1    setText:[Utils returnString:[_receiveDataDict objectForKey:@"contactPerson1"]]];
    [_textFieldContactNumber1    setText:[Utils returnString:[_receiveDataDict objectForKey:@"contactNo1"]]];
    [_textFieldContactPerson2    setText:[Utils returnString:[_receiveDataDict objectForKey:@"contactPerson2"]]];
    
    [_textFieldContactNumber2    setText:[Utils returnString:[_receiveDataDict objectForKey:@"contactNo2"]]];
    [_textFieldAssociateMember   setText:[Utils returnString:[_receiveDataDict objectForKey:@"associationMember"]]];
    
}

#pragma mark table view data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_rTableView.tag == 1)
    {
        // return [[json valueForKey:@"stateName"] count];
        
        
        return [[[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"stateData"]] valueForKey:@"stateName"] count];
    }
    else if(_rTableView.tag == 2)
    {
        return [[json valueForKey:@"city"] count];
    }
    else
    {
        return 0;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ranjit Singh"];
    [_rTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (_rTableView.tag == 1)
    {
        [cell.textLabel setText:[[[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"stateData"]] valueForKey:@"stateName"] objectAtIndex:indexPath.row]];
        stateId = [[stateArray objectAtIndex:indexPath.row] valueForKey:@"id"];
        
    }
    else if(_rTableView.tag == 2)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel setText:[[json valueForKey:@"city"] objectAtIndex:indexPath.row]];
        cityId = [[json objectAtIndex:indexPath.row] valueForKey:@"city_ID"];
    }
    else
    {
        return nil;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_rTableView.tag ==1)
    {
        [_textFieldState setText:[[[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"stateData"]] valueForKey:@"stateName"]objectAtIndex:indexPath.row]];
        [_textFieldCity setText:@""];
        [_rTableView setHidden:YES];
        tableShown = false;
    }
    else
    {
        [_textFieldCity setText:[[json valueForKey:@"city"] objectAtIndex:indexPath.row]];
        [_rTableView setHidden:YES];
        tableShown = false;
    }
}
- (IBAction)btnStatePressed:(id)sender
{
    [_rTableView setTag:1];
    if (_btnState.tag == 1)
    {
        _btnCity.tag     = 1;
        _btnState.tag       = 2;
        [_rTableView setHidden:NO];
        tableShown = true;
        
        //[self hitStateService];
        [_rTableView reloadData];
        [self setTableViewFrameForState];
    }
    else
    {
        [self showtableView:tableShown];
        [_rTableView reloadData];
        //[self hitStateService];
        [self setTableViewFrameForState];
        
    }
  
}
- (IBAction)btnCityPressed:(id)sender
{
    [_rTableView setTag:2];

    [self hitCityService:_textFieldState.text];
    
    if (_btnCity.tag == 1)
    {
        _btnState.tag     = 1;
        _btnCity.tag       = 2;
        [_rTableView setHidden:NO];
        tableShown = true;
        
        
        [self setTableViewFrameForCity];
    }
    else
    {
        [self showtableView:tableShown];
        [self hitCityService:_textFieldState.text];
        [self setTableViewFrameForCity];
        
    }
}

#pragma handling visibility of date picker

-(BOOL)showtableView :(BOOL)passIsShown
{
    if (tableShown == true)
    {
        [_rTableView setHidden:YES];
        tableShown  = false;
    }
    else
    {
        [_rTableView setHidden:NO];
        tableShown  = true;
    }
    return tableShown;
}
#pragma  set table frame for state and city
-(void)setTableViewFrameForState
{
    [_rTableView setFrame:CGRectMake(8, 192, 304, 200)];
}
-(void)setTableViewFrameForCity
{
    [_rTableView setFrame:CGRectMake(8, 230, 304, 200)];
}
- (IBAction)searchBtnPressed:(id)sender
{
    curLatLong = [Utils getLocationFromAddressString:_textFieldCompanyAddress.text];
    [self addPinWithCoordinate:curLatLong color:MKPinAnnotationColorPurple title:@"Current Location" subTitle:@"" status:@""];
    [_rMapView setCenterCoordinate:curLatLong];
}

#pragma mark add pin on specified location

- (void) addPinWithCoordinate:(CLLocationCoordinate2D)pinLocation
                        color:(MKPinAnnotationColor)pinColor title:(NSString *)title subTitle:(NSString *)subtitle status:(NSString *)status   //<-- new
{
    PinPlaceMark *placeMark = [[PinPlaceMark alloc] initWithCoordinate:pinLocation];
    
    placeMark.myTitle = title;
    placeMark.mySubTitle = subtitle;
    placeMark.rStatus = [Utils returnStateOfTruck:[status intValue]];
    placeMark.myPinColor = pinColor;  //<-- new
    [self.rMapView addAnnotation:placeMark];
    
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        curLatLong = annotationView.annotation.coordinate;
        NSLog(@"Pin dropped at %f,%f", curLatLong.latitude, curLatLong.longitude);
        
    }
}
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
        if (! [annotation isKindOfClass:[PinPlaceMark class]]) {
        //if annotation is not a PinPlaceMark (eg. user location),
        //return nil so map view draws default view (eg. blue dot) for it...
        return nil;
    }
    
    static NSString *reuseId = @"id";
    // static NSString *annotationReuseId = @"annotationId";
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (pinView == nil)
    {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        pinView.canShowCallout = YES;
        
    }
    else
    {
        pinView.annotation = annotation;
    }
    PinPlaceMark *ppm = (PinPlaceMark *)annotation;
    pinView.pinColor = ppm.myPinColor;
    pinView.draggable = YES;
    [pinView setSelected:YES];
    return pinView;
}
- (IBAction)submitBtnPressed:(id)sender
{
    //	.	{"SubscriptionId":30073,"CompanyName":"man square","CompanyUrl":"","Phone":"","EmailId":null,"Fax":"","CompanyAddress":"noida sec 4","Latitude":null,"Longitude":null,"Country":"INDIA","StateId":22,"State":"UP","CityId":1,"City":"Noida","PinCode":"","AssociationMember":"","STN":"","CIN":"","PAN":"","Tan":"","IPAddress":"","SourceBrowser":"","CreatedBy":"","ContactPerson1":"","ContactNo1":"","ContactPerson2":"","ContactNo2":"","ID":20056}
    
    if ([_textFieldCompanyName.text isEqualToString:@""]||[_textFieldState.text isEqualToString:@""]||[_textFieldCity.text isEqualToString:@""]||[_textFieldCompanyAddress.text isEqualToString:@""])
    {
        [Utils messageAlert:FILL_ALL_DATA title:INFO delegate:self];
    }
    else
    {
     
        NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
        
        NSString *userUpdate = [NSString stringWithFormat:@"{\"SubscriptionId\":%@,\"CompanyName\":\"%@\",\"CompanyUrl\":\"%@\",\"Phone\":\"%@\",\"EmailId\":\"%@\",\"Fax\":\"%@\",\"CompanyAddress\":\"%@\",\"Latitude\":%f,\"Longitude\":%f,\"Country\":\"%@\",\"StateId\":%@,\"State\":\"%@\",\"CityId\":%@,\"City\":\"%@\",\"PinCode\":\"%@\",\"AssociationMember\":\"%@\",\"STN\":\"%@\",\"CIN\":\"%@\",\"PAN\":\"%@\",\"Tan\":\"%@\",\"IPAddress\":\"%@\",\"SourceBrowser\":\"%@\",\"CreatedBy\":\"%@\",\"ContactPerson1\":\"%@\",\"ContactNo1\":\"%@\",\"ContactPerson2\":\"%@\",\"ContactNo2\":\"%@\",\"ID\":\"%@\"}",[logDict objectForKey:@"subscriptionId"],_textFieldCompanyName.text,_textFieldEwbAddress.text,_textFieldMobileNo.text,[self.receiveDataDict objectForKey:@"emailId"],_textFieldFax.text,_textFieldCompanyAddress.text,[Utils getLocationFromAddressString:_textFieldCompanyAddress.text].latitude,[Utils getLocationFromAddressString:_textFieldCompanyAddress.text].longitude,[_receiveDataDict objectForKey:@"country"],stateId,_textFieldState.text,cityId,_textFieldCity.text,_rexrFieldPostalCode.text,_textFieldAssociateMember.text,_TextFieldSTNo.text,_textFieldCinNo.text,_textFieldPanNo.text,_TextFieldTanNo.text,@"",@"",[logDict objectForKey:@"emailId"],_TextFieldContactPerson1.text,_textFieldContactNumber1.text,_textFieldContactPerson2.text,_textFieldContactNumber2.text,[_receiveDataDict objectForKey:@"id"]];
        
        NSLog(@"the user update is = %@", userUpdate);
        
        [SVProgressHUD show];
        NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,ADD_NEW_CLIENT];
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
                 dataDict = [[NSDictionary alloc]initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                 NSLog(@"the responce is = %@",dataDict);

                 if (dataDict != nil)
                 {
                     [self resetMethod];
                     [Utils messageAlert:RECORD_ADDED_SUCCESSFULLY title:INFO delegate:self];
     
                 }
                 else
                 {
                   [Utils messageAlert:RECORD_NOT_ADDED title:INFO delegate:self];
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

- (IBAction)resetBtnPressed:(id)sender
{
    [self resetMethod];
}
-(void)resetMethod
{
    [_textFieldCompanyName       setText:@""];
    [_textFieldEwbAddress        setText:@""];
    [_textFieldMobileNo          setText:@""];
    [_textFieldFax               setText:@""];
    [_textFieldState             setText:@""];
    [_textFieldCity              setText:@""];
    [_textFieldAssociateMember   setText:@""];
    [_rexrFieldPostalCode        setText:@""];
    [_textFieldCompanyAddress    setText:@""];
    [_textFieldCinNo             setText:@""];
    [_textFieldPanNo             setText:@""];
    [_TextFieldTanNo             setText:@""];
    [_TextFieldSTNo              setText:@""];
    [_TextFieldContactPerson1    setText:@""];
    [_textFieldContactNumber1    setText:@""];
    [_textFieldContactPerson2    setText:@""];
    [_textFieldContactNumber2    setText:@""];
  
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
             
             json = [[NSArray alloc]initWithArray:rsJson];
             
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
