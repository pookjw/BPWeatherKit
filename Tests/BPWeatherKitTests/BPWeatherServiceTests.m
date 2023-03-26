//
//  BPWeatherServiceTests.m
//  
//
//  Created by Jinwoo Kim on 3/26/23.
//

#import "BPWeatherServiceTests.h"
#import <CoreLocation/CoreLocation.h>
@import BPWeatherKit;

@interface BPWeatherServiceTests ()
@property (retain) BPWeatherService *weatherService;
@end

@implementation BPWeatherServiceTests

- (void)dealloc {
    [_weatherService release];
    [super dealloc];
}

- (void)setUp {
    self.weatherService = BPWeatherService.sharedInstance;
    [super setUp];
}

- (void)tearDown {
    self.weatherService = nil;
    [super tearDown];
}

- (void)test_getWeather {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:37.570013917406 longitude:126.9780542555];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:[NSString string]];
    
    [self.weatherService weatherForLocation:location completionHandler:^(BPWeather * _Nullable weather, NSError * _Nullable error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [location release];
    [self waitForExpectations:@[expectation] timeout:10.f];
    [expectation release];
}

@end
