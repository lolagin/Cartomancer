//
//  Prediction.m
//  Cartomancer
//
//  Created by Massimo Savino on 2015-04-08.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import "Prediction.h"

@implementation Prediction

- (NSArray *)RLMResultsToNSArray:(RLMResults *)results {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:results.count];
    for (RLMObject *object in results) {
        [array addObject:object];
    }
    return array;
}

//- (NSMutableArray *)shuffleDeck:(NSArray *)resultsArray {
//    NSMutableArray *shuffledDeck = [resultsArray mutableCopy];
//    for (int i = [shuffledDeck count] - 1; i > 0; i--) {
//        [shuffledDeck exchangeObjectAtIndex:(arc4random() % ([shuffledDeck count] - 1)) withObjectAtIndex:i];
//    }
//    return shuffledDeck;
//}


@end
