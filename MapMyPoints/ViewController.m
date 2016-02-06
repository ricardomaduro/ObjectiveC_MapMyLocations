//
//  ViewController.m
//  MapMyPoints
//
//  Created by Ricardo Maduro on 23/01/16.
//  Copyright © 2016 Ricardo Maduro. All rights reserved.
//

#import "ViewController.h"
#import "MapKit/MapKit.h"

@interface ViewController () <MKMapViewDelegate,CLLocationManagerDelegate>;

@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (strong, nonatomic) MKPointAnnotation *AAnno;
@property (strong, nonatomic) MKPointAnnotation *BAnno;
@property (strong, nonatomic) MKPointAnnotation *CAnno;
@property (strong, nonatomic) MKPointAnnotation *CurrentAnno;

@property (weak, nonatomic) IBOutlet UISwitch *switchLocateMe;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL mapIsMoving;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.mapIsMoving = NO;
    [self addAnnotations];
}

- (IBAction)PlaceATapped:(id)sender {
    [self centerMap: self.AAnno];
}
- (IBAction)PlaceBTapped:(id)sender {
    [self centerMap: self.BAnno];
}
- (IBAction)PlaceCTapped:(id)sender {
    [self centerMap: self.CAnno];
}

- (void) centerMap:(MKPointAnnotation*)centerPoint{
    [self.mapview setCenterCoordinate:centerPoint.coordinate animated:YES];
}
- (IBAction)switchLocateMeChanged:(id)sender {
    if (self.switchLocateMe.isOn) {
        self.mapview.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
    }
    else {
        self.mapview.showsUserLocation = NO;
        [self.locationManager stopUpdatingLocation];
    }
}

-(void) locationManager:(CLLocationManager *) manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.CurrentAnno.coordinate = locations.lastObject.coordinate;
    if (self.mapIsMoving == NO) {
        [self centerMap:self.CurrentAnno];
    }
}


- (void) addAnnotations {
    self.AAnno = [[MKPointAnnotation alloc] init];
    self.AAnno.coordinate = CLLocationCoordinate2DMake(38.7437553,-9.1917899);
    self.AAnno.title = @"Lisboa, Portugal";
    
    self.BAnno = [[MKPointAnnotation alloc] init];
    self.BAnno.coordinate = CLLocationCoordinate2DMake(40.4378698,-3.8196197);
    self.BAnno.title = @"Madrid, Espanha";
    
    self.CAnno = [[MKPointAnnotation alloc] init];
    self.CAnno.coordinate = CLLocationCoordinate2DMake(48.8588377,2.2775175);
    self.CAnno.title = @"Paris, França";
    
    self.CurrentAnno = [[MKPointAnnotation alloc] init];
    self.CurrentAnno.coordinate = CLLocationCoordinate2DMake(0.0,0.0);
    self.CurrentAnno.title = @"My location";

    
    [self.mapview addAnnotations:@[self.AAnno,self.BAnno, self.CAnno] ];
}

- (void) mapView:(MKMapView*)mapView regionWillChangeAnimated:(BOOL)animated{
    self.mapIsMoving = YES;
}

- (void) mapView:(MKMapView*)mapView regionDidChangeAnimated:(BOOL)animated{
    self.mapIsMoving = NO;
}


@end
