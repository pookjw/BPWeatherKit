//
//  SceneDelegate.m
//  Demo
//
//  Created by Jinwoo Kim on 3/26/23.
//

#import "SceneDelegate.h"
#import "ViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    ViewController *viewController = [ViewController new];
    window.rootViewController = viewController;
    [viewController release];
    [window makeKeyAndVisible];
    self.window = window;
    [window release];
}

@end
