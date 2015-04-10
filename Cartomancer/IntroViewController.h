//
//  IntroViewController.h
//  Cartomancer
//
//  Created by Massimo Savino on 2015-04-09.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *tarotSplashImageView;
@property (nonatomic, weak) IBOutlet UITextField *introQuestionInput;
@property (nonatomic, strong) UILabel *introQuestionLabel;

@end
