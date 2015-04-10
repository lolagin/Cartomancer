//
//  Prediction.m
//  Cartomancer
//
//  Created by Massimo Savino on 2015-04-08.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import "Prediction.h"



@interface Prediction ()
//@property (strong, nonatomic)RLMRealm *realm;



- (NSArray *)RLMResultsToNSArray:(RLMResults *)results;
- (NSMutableArray *)shuffleDeck:(NSArray *)resultsArray;
- (NSArray *)pickCelticCrossTen:(NSMutableArray *)shuffledDeck;



@end

@implementation Prediction


// Suggestions for a more generalised version:
//
// • set up a kConstants pair of files 
//
//
//
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.realm = [RLMRealm defaultRealm];
//    }
//    return self;
//}





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
    
    NSMutableArray *celticCrossTen = [[shuffledDeck subarrayWithRange:NSMakeRange(0, 10)]mutableCopy];
    // return these
    return [celticCrossTen copy];
    
}

+ (NSArray *)celticCross {
    
    Prediction *prediction = [[Prediction alloc] init];
    NSArray *allCards = [prediction RLMResultsToNSArray:[Card allObjects]];
    NSArray *randomizedPrediction = [prediction shuffleDeck:allCards];
    NSMutableArray *theBigTenCards = [prediction pickCelticCrossTen:randomizedPrediction];
//    NSLog(@"Mutable array : %@", theBigTenCards);
    
    [theBigTenCards enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        int rand = arc4random_uniform(1);
        if (rand == 1){
        ((Card *)obj).isUpright = YES;
        }
        
    }];
    
    
    return theBigTenCards;
}

@end
