//
//  RSTrackHistoryViewController.h
//  Carrier
//
//  Created by QUIKHOP on 10/20/16.
//  Copyright © 2016 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSTrackHistoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,CLLocationManagerDelegate>
{
    NSMutableDictionary *dataArray;
}
@property (strong, nonatomic) IBOutlet UIScrollView *rScrolView;
@property (strong, nonatomic) IBOutlet MKMapView *rMapView;
@property (strong, nonatomic) IBOutlet UITableView *trackingHistoryTableView;
@property (strong, nonatomic) IBOutlet UITableView *documentUploadTableview;

@property(nonatomic, strong)NSString *shipmentId;


@property (nonatomic, retain) MKPolyline *routeLine; //your line
@property (nonatomic, retain) MKPolylineView *routeLineView; //overlay view

@property (nonatomic, readwrite) MKMapItem *source;
@property (nonatomic, readwrite) MKMapItem *destination;



@end
