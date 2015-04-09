//
//  AppDelegate.h
//  Cartomancer
//
//  Created by Massimo Savino on 2015-04-06.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class DataLoader;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//- (NSMutableArray *)shuffleDeck:(NSArray *)resultsArray;
- (void)extractPrediction;

@property (strong, nonatomic) UIWindow *window;


@end

