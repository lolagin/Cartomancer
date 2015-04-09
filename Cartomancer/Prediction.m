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

- (NSMutableArray *)shuffleDeck:(NSArray *)resultsArray {
    NSMutableArray *shuffledDeck = [resultsArray mutableCopy];
    for (int i = [shuffledDeck count] - 1; i > 0; i--) {
        [shuffledDeck exchangeObjectAtIndex:(arc4random() % ([shuffledDeck count] - 1)) withObjectAtIndex:i];
    }
    return shuffledDeck;
}

- (NSArray *)pickCelticCrossTen:(NSMutableArray *)shuffledDeck {
    // load the shuffled Deck (78 cards), strip to the first 10
    
    NSArray *celticCrossTen = [shuffledDeck subarrayWithRange:NSMakeRange(0, 9)];
    // return these
    return celticCrossTen;
    
}

//- (NSString*)findInString:(NSString*)string
//        replaceWithString:(NSString*)stringToReplaceWith
//{
//    return [input stringByReplacingOccurrencesOfString:string
//                                            withString:stringToReplaceWith];
//}

@end
