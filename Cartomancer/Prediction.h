//
//  Prediction.h
//  Cartomancer
//
//  Created by Massimo Savino on 2015-04-08.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Card.h"

@interface Prediction : NSObject

+ (NSArray *)celticCross;

@property (nonatomic, strong) NSArray *testCards;

@end
