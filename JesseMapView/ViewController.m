//
//  ViewController.m
//  JesseMapView
//
//  Created by Jesse Sahli on 7/14/16.
//  Copyright © 2016 sahlitude. All rights reserved.
//

#import "ViewController.h"
#import "JSAnnotation.h"

#define TTT_LATITUDE 40.741445;
#define TTT_LONGITUDE -73.989966;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.searchBar.delegate = self;
    [self prefersStatusBarHidden];
    [NSTimer timerWithTimeInterval:3.0 target:self.mapView selector:@selector(setStartLocation) userInfo:nil repeats:NO];
    [self setStartLocation];
    [self hardCodePins];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



- (void)setStartLocation {
    
    CLLocationCoordinate2D turnToTech;
    turnToTech.longitude = TTT_LONGITUDE;
    turnToTech.latitude = TTT_LATITUDE;
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.longitudeDelta = 0.01;
    span.latitudeDelta = 0.01;
    region.center = turnToTech;
    region.span = span;
    [self.mapView setRegion:region animated:YES];
}



- (void)hardCodePins {
    
    CLLocationCoordinate2D turnToTech;
    turnToTech.longitude = TTT_LONGITUDE;
    turnToTech.latitude = TTT_LATITUDE;
    JSAnnotation *ann = [[JSAnnotation alloc]initWithCoord:turnToTech];
    ann.title = @"TurnToTech";
    ann.subtitle = @"Mobile Development Bootcamp";
    ann.urlString = @"http://www.turntotech.io";
  
    CLLocationCoordinate2D chopt;
    chopt.longitude = -73.988193;
    chopt.latitude = 40.740721;
    JSAnnotation *ann1 = [[JSAnnotation alloc]initWithCoord:chopt];
    ann1.title = @"chopT";
    ann1.subtitle = @"Creative Salad Company";
    ann1.urlString = @"www.http://choptsalad.com/";

    CLLocationCoordinate2D hillCountry;
    hillCountry.longitude = -73.990459;
    hillCountry.latitude = 40.744292;
    JSAnnotation *ann2 = [[JSAnnotation alloc]initWithCoord:hillCountry];
    ann2.title = @"Hill Country BBQ";
    ann2.subtitle = @"NYC renowned Texas Style BBQ";
    ann2.urlString = @"http://www.hillcountry.com/";
    
    NSArray *anns = [[NSArray alloc]initWithObjects:ann,ann1,ann2, nil];
    [self.mapView addAnnotations:anns];
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    [searchRequest setNaturalLanguageQuery:searchBar.text];
    [searchRequest setRegion:self.mapView.region];
    
    if (!self.annArray) {
        self.annArray = [[NSMutableArray alloc]init];
    } else {
        [self.mapView removeAnnotations:self.annArray];
        [self.annArray removeAllObjects];
    }
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            for (MKMapItem *mapItem in [response mapItems]) {
                CLLocationCoordinate2D searhCoord = [[[mapItem placemark] location] coordinate];
                JSAnnotation *ann = [[JSAnnotation alloc]initWithCoord:searhCoord];
                ann.title = [mapItem name];
                ann.subtitle = [searchRequest naturalLanguageQuery];
                ann.urlString = @"http://www.google.com";
                [self.annArray addObject:ann];
            }
        } else {
            NSLog(@"Search Request Error: %@", [error localizedDescription]);
        }
         [self.mapView addAnnotations:self.annArray];
    }];
    [self.view endEditing:YES];
}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKPinAnnotationView *view = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
    view.pinTintColor = [UIColor redColor];
    view.enabled = YES;
    view.animatesDrop = YES;
    view.canShowCallout = YES;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mobileDevIcon.png"]];
    view.leftCalloutAccessoryView = imageView;
    view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return view;
}



-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    JSAnnotation *ann = (JSAnnotation *)view.annotation;
    [self.mapView deselectAnnotation:ann animated:YES];
    self.webVC = [[WebViewController alloc]init];
    self.webVC.annUrl = ann.urlString;
    [self presentViewController:self.webVC animated:YES completion:nil];
}



- (IBAction)mapType:(id)sender {
    
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
            
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
            
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(BOOL)prefersStatusBarHidden{
    return YES;
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc]init];
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager setDelegate:self];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    return self;
}



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _locationManager = [[CLLocationManager alloc]init];
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager setDelegate:self];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    return self;
}

@end
