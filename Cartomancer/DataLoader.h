//
//  DataLoader.h
//  Cartomancer
//
//  Created by Massimo Savino on 2015-04-07.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h> 

@class Card;


@interface DataLoader : NSObject

- (void) pullDataFromTextFile;
- (NSArray *)arrayFromText;


- (NSMutableArray *)shuffleDeck:(NSArray *)resultsArray;

@end
