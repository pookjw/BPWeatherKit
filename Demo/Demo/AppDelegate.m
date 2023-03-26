//
//  AppDelegate.m
//  Demo
//
//  Created by Jinwoo Kim on 3/26/23.
//

#import "AppDelegate.h"
#import "SceneDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    UISceneConfiguration *configuration = [[UISceneConfiguration alloc] initWithName:nil sessionRole:connectingSceneSession.role];
    configuration.delegateClass = SceneDelegate.class;
    
    return [configuration autorelease];
}

@end
