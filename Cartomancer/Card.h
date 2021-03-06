//
//  Card.h
//  Cartomancer
//
//  Created by Massimo Savino on 2015-04-06.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

@interface Card : RLMObject

@property NSString *key;
@property NSString *name;
@property NSString *upDescription;
@property NSString *reversedDescription;
@property BOOL isUpright;
@property NSString *image;
//@property NSString *suitArcana;

@end
RLM_ARRAY_TYPE(Card)  // defined the RLMArray (Card)


