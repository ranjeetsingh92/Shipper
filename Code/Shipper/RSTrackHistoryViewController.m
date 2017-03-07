//
//  RSTrackHistoryViewController.m
//  Carrier
//
//  Created by QUIKHOP on 10/20/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import "RSTrackHistoryViewController.h"
#import "RSTrackingHistoryTableViewCell.h"
#import "RSDocumentUploadTableViewCell.h"
#import "Annotation.h"
#import "PinPlaceMark.h"

@interface RSTrackHistoryViewController ()
{
    CLLocationCoordinate2D sourceLoc;
    CLLocationCoordinate2D destiLoc;
      MKDirectionsRequest *request;
}

@end

@implementation RSTrackHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_rScrolView setContentSize:CGSizeMake(320,800)];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self drawRouteLine];

}
-(void)viewWillAppear:(BOOL)animated
{
    [SVProgressHUD show];
    [_rMapView removeAnnotations:_rMapView.annotations];
    [self performSelector:@selector(getAllWayToPickupLocationLoad) withObject:nil afterDelay:0.0];
    
 
}


-(void)drawRouteLine
{
    
}

-(void)getAllWayToPickupLocationLoad
{
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"ShipmentId\":%@}",_shipmentId];
    NSLog(@"%@",userUpdate);
    
    NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@",DOMAIN_URL,GET_SHIPMENT_ALL_DETAILS];
    
    //{"SubscriptionId":60097,"PageIndex":1,"PageSize":5,"Status":7,"SubscriptionType":"carrier","WorkingSubscriptionType":""}
    
    NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:completeLoginUrlWithSpace]];
    
    [mRequest setHTTPMethod:@"POST"];
    [mRequest setValue:@"application/json"       forHTTPHeaderField:@"Accept"];
    [mRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *fPostData = [userUpdate dataUsingEncoding:NSASCIIStringEncoding];
    [mRequest setHTTPBody:fPostData];
    
    
    [NSURLConnection sendAsynchronousRequest:mRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         if (data != nil)
         {
             id rsJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             dataArray = [[NSMutableDictionary alloc]initWithDictionary:rsJson];
             NSLog(@"the json data is = %@", rsJson);
             
             if (dataArray.count != 0)
             {
                 [self showSourceLocationOnMap];
                 [self showDestinationLocationOnMap];
                 [self showTruckLocationOnMap];
                 [_documentUploadTableview reloadData];
                 [_trackingHistoryTableView reloadData];

             }
             [SVProgressHUD dismiss];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];
}

#pragma mark set mapview data
-(void)showSourceLocationOnMap
{
    
    if ([[[[dataArray objectForKey:@"load"]objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"latitude"] != [NSNull null])
    {
        sourceLoc.latitude = [[[[[dataArray objectForKey:@"load"]objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"latitude"] doubleValue];
    }
    if([[[[dataArray objectForKey:@"load"] objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"longitude"] != [NSNull null])
    {
        sourceLoc.longitude = [[[[[dataArray objectForKey:@"load"] objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"longitude"] doubleValue];
   
    }
//    Annotation *newAnnotation = [[Annotation alloc]
//                                 initWithTitle:[NSString stringWithFormat:@"%@, %@",[[[dataArray objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"fromLocation"],[[[dataArray objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"pickUpState"]] andCoordinate:sourceLoc];
//    [_rMapView addAnnotation:newAnnotation];
    
    [self addPinWithCoordinate:sourceLoc color:MKPinAnnotationColorGreen title:@"Source Location" subTitle:[NSString stringWithFormat:@"%@, %@",[[[[dataArray objectForKey:@"load"] objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"fromLocation"],[[[[dataArray objectForKey:@"load"]objectForKey:@"fromPickUpLocation"] objectAtIndex:0] objectForKey:@"pickUpState"]] status:@""];
    [self.rMapView setCenterCoordinate:sourceLoc];
}

-(void)showDestinationLocationOnMap
{
    if ([[[[dataArray objectForKey:@"load"]objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"latitude"] != [NSNull null])
    {
        destiLoc.latitude = [[[[[dataArray objectForKey:@"load"]objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"latitude"] doubleValue];
    }
    if ([[[[dataArray objectForKey:@"load"] objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"longitude"] != [NSNull null])
    {
        destiLoc.longitude = [[[[[dataArray objectForKey:@"load"] objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"longitude"] doubleValue];
    }

    
//    Annotation *newAnnotation = [[Annotation alloc]
//                                 initWithTitle:[NSString stringWithFormat:@"%@, %@",[[[dataArray objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"fromLocation"],[[[dataArray objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"pickUpState"]] andCoordinate:destiLoc];
   // [_rMapView addAnnotation:newAnnotation];
    
    [self addPinWithCoordinate:destiLoc color:MKPinAnnotationColorRed title:@"Destination Location" subTitle:[NSString stringWithFormat:@"%@, %@",[[[[dataArray objectForKey:@"load"]objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"toLocation"],[[[[dataArray objectForKey:@"load"]objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"dispatchState"]] status:@""];
}
-(void)showTruckLocationOnMap
{
    CLLocationCoordinate2D truckLoc;
    
    if ([[dataArray valueForKey:@"truck"]  objectForKey:@"latitude"] != [NSNull null])
    {
         truckLoc.latitude = [[[dataArray valueForKey:@"truck"]  objectForKey:@"latitude"] doubleValue];
         truckLoc.longitude = [[[dataArray valueForKey:@"truck"]  objectForKey:@"longitude"] doubleValue];
        
    }
    //    Annotation *newAnnotation = [[Annotation alloc]
    //                                 initWithTitle:[NSString stringWithFormat:@"%@, %@",[[[dataArray objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"fromLocation"],[[[dataArray objectForKey:@"toPickUpLocation"] objectAtIndex:0] objectForKey:@"pickUpState"]] andCoordinate:destiLoc];
    // [_rMapView addAnnotation:newAnnotation];
    
    [self addPinWithCoordinate:truckLoc color:MKPinAnnotationColorPurple title:@"Current Location" subTitle:[NSString stringWithFormat:@"%@, %@",[[dataArray objectForKey:@"truck"]  objectForKey:@"currentLocationCity"],[[dataArray objectForKey:@"truck"]  objectForKey:@"currentLocationState"]] status:@""];
     //[self.rMapView setCenterCoordinate:truckLoc];
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
    
    if ( [[NSString stringWithFormat:@"%@", ppm.subtitle] isEqualToString:@"adress"])
    {
        pinView.draggable = YES;
        [pinView setSelected:YES];
    }
    return pinView;
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


#pragma mark set tableview data

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    if (tableView == self.trackingHistoryTableView)
    {
        return [[dataArray objectForKey:@"trackingLog"] count];
    }
    else if(tableView == self.documentUploadTableview)
    {
      return   [[dataArray objectForKey:@"documentVerificationByDriver"] count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.trackingHistoryTableView)
    {
        
        RSTrackingHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RSTrackingHistoryTableViewCell" forIndexPath:indexPath];
        
        [cell.labelSerialNo setText:[NSString stringWithFormat:@"%ld", indexPath.row]];
        [cell.labelCurrentStatus setText:[Utils returnString:[[[dataArray objectForKey:@"trackingLog"] objectAtIndex:indexPath.row] objectForKey:@"currentStatus"]]];
        [cell.labelCurrentCity setText:[Utils returnString:[[[dataArray objectForKey:@"trackingLog"] objectAtIndex:indexPath.row] objectForKey:@"currentCity"]]];
        [cell.labelDesription setText:[Utils returnString:[[[dataArray objectForKey:@"trackingLog"] objectAtIndex:indexPath.row] objectForKey:@"currentStatus"]]];
        [cell.labelUpdatedDate setText:[Utils returnString:[[[[[dataArray objectForKey:@"trackingLog"] objectAtIndex:indexPath.row] objectForKey:@"updatedDate"] componentsSeparatedByString:@"T"] objectAtIndex:0]]];
        [cell.labelUpdatedBy setText:[Utils returnString:[[[dataArray objectForKey:@"trackingLog"] objectAtIndex:indexPath.row] objectForKey:@"statusUpdatedBy"]]];
        return cell;
    }
    else if(tableView == _documentUploadTableview)
    {
        RSDocumentUploadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RSDocumentUploadTableViewCell" forIndexPath:indexPath];
        
         [cell.labelSerialNo setText:[NSString stringWithFormat:@"%ld",indexPath.row]];
         [cell.labelDocumentName setText:[Utils returnString:[[[dataArray objectForKey:@"documentVerificationByDriver"] objectAtIndex:indexPath.row] objectForKey:@"documentName"]]];
         [cell.labelDocumentUploaded setText:[Utils returnString:[[[[dataArray objectForKey:@"documentVerificationByDriver"] objectAtIndex:indexPath.row] objectForKey:@"isDocumentUploaded"] stringValue]]];
         [cell.labelStatus setText:[Utils returnString:[[[[dataArray objectForKey:@"documentVerificationByDriver"] objectAtIndex:indexPath.row] objectForKey:@"status"] stringValue]]];
         [cell.labelVerify setText:[Utils returnString:[[[dataArray objectForKey:@"documentVerificationByDriver"] objectAtIndex:indexPath.row] objectForKey:@"updatedBy"]]];
        return cell;
    }
  else
  {
      UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ranjit Singh"];
      return cell;
  }
}


@end
