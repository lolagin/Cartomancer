//
//  AppDelegate.m
//  Cartomancer
//
//  Created by Massimo Savino on 2015-04-06.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import "AppDelegate.h"
#import "CardSpreadViewController.h"
#import <Realm/Realm.h> 
#import "Card.h"
//#import "Prediction.h"
#import "DataLoader.h"

//#import "DataLoader.h"

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
    
    
    // ONLY LOAD THIS DATABASE FROM THE JSON FILE ONCE AND ONCE ONLY
    //DataLoader *test  = [[DataLoader alloc] init];
    //[test pullDataFromTextFile];
    //[test pullPredictionOutOfDeck];
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    NSLog(@"%@", [realm path]);
    //NSLog(@"these files were written to the Realm DB\n%@", [[Card allObjects] description]);
//    Prediction *prediction = [[Prediction alloc] init];
//    NSArray *allCards = [prediction RLMResultsToNSArray:[Card allObjects]];

    //NSMutableArray *randomPrediction = [[NSMutableArray alloc] init];
    
//    NSLog(@"Mutable array : %@", [prediction shuffleDeck:allCards]);

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSMutableArray *)shuffleDeck:(NSArray *)resultsArray {
    NSMutableArray *shuffledDeck = [resultsArray mutableCopy];
    for (int i = [shuffledDeck count] - 1; i > 0; i--) {
        [shuffledDeck exchangeObjectAtIndex:(arc4random() % ([shuffledDeck count] - 1)) withObjectAtIndex:i];
    }
    return shuffledDeck;
}


@end
