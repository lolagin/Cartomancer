//
//  AppDelegate.m
//  Cartomancer
//
//  Created by Massimo Savino on 2015-04-06.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import "AppDelegate.h"
#import "CardSpreadViewController.h"
#import "Card.h"
#import "Prediction.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    CardSpreadViewController *csvc = [[CardSpreadViewController alloc]init];
    UINavigationController *masterNavCon = [[UINavigationController alloc]initWithRootViewController:csvc];
    
    self.window.rootViewController = masterNavCon;
    self.window.backgroundColor = [UIColor greenColor];
    [self.window makeKeyAndVisible];


    NSString *defaultRealmPath = [RLMRealm defaultRealmPath];
    NSString *defaultRealmParentPath = [defaultRealmPath stringByDeletingLastPathComponent];
    NSString *vPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"default.realm"];
    [[NSFileManager defaultManager] removeItemAtPath:defaultRealmPath error:nil];
    [[NSFileManager defaultManager] copyItemAtPath:vPath toPath:defaultRealmPath error:nil];
    
    return YES;
}




@end
