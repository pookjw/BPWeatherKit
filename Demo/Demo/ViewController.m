//
//  ViewController.m
//  Demo
//
//  Created by Jinwoo Kim on 3/26/23.
//

#import "ViewController.h"
@import CoreLocation;
@import BPWeatherKit;

@interface ViewController () <CLLocationManagerDelegate>
@property (strong) CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationManager *locationManager = [CLLocationManager new];
    
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    
    self.locationManager = locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.firstObject;
   
    NSArray *queires = @[
        [BPWeatherQuery current],
        [BPWeatherQuery minute],
        [BPWeatherQuery hourly]
    ];
    
    [BPWeatherService.sharedInstance weatherForLocation:location includingQueries:queires completionHandler:^(NSArray * _Nullable results, NSError * _Nullable error) {
        NSLog(@"%@ %@", results, error);
        [results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%d", [obj hash]);
        }];
    }];
    
    [manager stopUpdatingLocation];
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    [manager startUpdatingLocation];
}

@end

