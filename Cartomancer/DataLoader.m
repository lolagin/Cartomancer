//
//  DataLoader.m
//  Cartomancer
//
//  Created by Massimo Savino on 2015-04-07.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import "DataLoader.h"
#import "Card.h"


@implementation DataLoader

- (NSArray *)arrayFromText {
    NSArray *sampleArray = [[NSArray alloc] init];
    return sampleArray;
}

- (void)pullDataFromTextFile {    
    RLMRealm *realm = [RLMRealm defaultRealm];
    // Uncommenting the next line destroys the working Realm database from the Xcode project 
    //[[NSFileManager defaultManager] removeItemAtPath:[RLMRealm defaultRealmPath] error:nil];
    
    NSString *fullPathToFile = [[NSBundle mainBundle] pathForResource:@"seventyEightCardListings4" ofType:@"json"];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:fullPathToFile];
    
    NSError *error = nil;
    NSDictionary *json  = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"Safety check: \n\nShow me the raw file!\n%@", json);
    
    NSArray *tarotRows = [json valueForKey:@"tarotCards"];
    
    [realm beginWriteTransaction];
    
    
    for (NSDictionary *eachCompleteCard in tarotRows) {
        NSLog(@"eachCompleteCard: %@", eachCompleteCard);
        
        // the individual card to parse out
        Card *thisCard = [[Card alloc] init];
        NSLog(@"thisCard stuff is: %@", thisCard);
        thisCard.key = eachCompleteCard[@"key"];
        thisCard.name = eachCompleteCard[@"name"];
        thisCard.upDescription = eachCompleteCard[@"upDescription"];
        thisCard.reversedDescription = eachCompleteCard[@"reversedDescription"];
        thisCard.image = eachCompleteCard[@"image"];
        
        NSLog(@"thisCard.key = %@, name is %@, \nupDescription %@\nreversedDescription %@",
              thisCard.key,
              thisCard.name,
              thisCard.upDescription,
              thisCard.reversedDescription);
        [realm addObject:thisCard];
    }
    [realm commitWriteTransaction];
    NSLog(@"%@", [realm path]);
    //[realm writeCopyToPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:&error];
    //[realm writeCopyToPath:[NSHomeDirectory] error:&error];
    
    
    NSLog(@"these files were written to the Realm DB\n%@", [[Card allObjects] description]);
    //NSLog(@"confirm number of Cards in Deck %d", [[Card allObjects] count]);
    
}

- (NSMutableArray *)shuffleDeck:(NSArray *)resultsArray {
    NSMutableArray *shuffledDeck = [resultsArray mutableCopy];
    for (int i = [shuffledDeck count] - 1; i > 0; i--) {
        [shuffledDeck exchangeObjectAtIndex:(arc4random() % ([shuffledDeck count] - 1)) withObjectAtIndex:i];
    }
    return shuffledDeck;
}



@end
