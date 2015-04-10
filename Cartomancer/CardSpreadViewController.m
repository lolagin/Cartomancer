//
//  CardSpreadViewController.m
//  Cartomancer
//
//  Created by Jeffrey C Rosenthal on 4/7/15.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import "CardSpreadViewController.h"
#import "Card.h"
#import "DefListTableViewController.h"
#import "Prediction.h"

@interface CardSpreadViewController ()
@property (nonatomic, strong) IBOutletCollection(UIImageView) NSArray *imageViews;
@property (weak, nonatomic) IBOutlet UIImageView *bigCardImage;



@property (strong, nonatomic) UITapGestureRecognizer *tappy;
@property (strong, nonatomic) UISwipeGestureRecognizer *forwardSwish;
@property (strong, nonatomic) UISwipeGestureRecognizer *backSwish;

@property (weak, nonatomic) IBOutlet UILabel *tarotLore;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) UIButton *deckChangeButton;


@property (nonatomic, assign) NSUInteger incrementer;
@property (nonatomic, assign) NSUInteger deckIncrementer;
@property (nonatomic, assign) CGRect smallerFrame;
@property (nonatomic, strong) NSArray *randomCards;
@property (nonatomic, strong) NSArray *positionStringsArray;
@property (nonatomic, strong) NSString *tarotImagePrefix;



-(void)fades;
-(void)deckSelector;
-(void)refreshImageViews;

@end

@implementation CardSpreadViewController {
    
    
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tarotImagePrefix = @"RW";
    self.tappy = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHappens)];
    self.forwardSwish = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dealForward)];
    self.backSwish = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dealBack)];

    self.tappy.numberOfTapsRequired = 1;
    [self.forwardSwish setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.backSwish setDirection:UISwipeGestureRecognizerDirectionRight];

    [self.view addGestureRecognizer:self.tappy];
    [self.view addGestureRecognizer:self.forwardSwish];
    [self.view addGestureRecognizer:self.backSwish];
    
    
    [self.view addSubview:self.deckChangeButton];
    [self.imageViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((UIImageView *)obj).alpha = 0;
    }];
    // Do any additional setup after loading the view from its nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark -
#pragma mark Actions
-(void)deckSelector {
    
    if (self.deckIncrementer == 0) {
        self.tarotImagePrefix = @"RW";
        [self fades];
        self.deckIncrementer++;
        return;
    }
    
    if (self.deckIncrementer == 1) {
        self.tarotImagePrefix = @"Marseilles_";
        [self fades];
        self.deckIncrementer++;
        return;
    }
}



-(void)refreshImageViews{
    
//    [self.imageViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        ((UIImageView *)obj).image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", self.tarotImagePrefix, ((Card *)self.randomCards[idx]).image]];
//    }];
    [self.randomCards enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (!((Card *)obj).isUpright) {
            
             ((UIImageView *)self.imageViews[idx]).image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", self.tarotImagePrefix, ((Card *)self.randomCards[idx]).image]];
            
            if (!(idx == 1)) {
                return;
            }
            else {
                UIImage *PortraitImage = [[UIImage alloc] initWithCGImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",self.tarotImagePrefix,((Card *)self.randomCards[idx]).image]].CGImage scale:1.0 orientation:UIImageOrientationLeft];
                ((UIImageView *)self.imageViews[idx]).image = PortraitImage;
                return;

            
            }}
            else {
            
            
            UIImage *flippedImage = [[UIImage alloc] initWithCGImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",self.tarotImagePrefix,((Card *)obj).image]].CGImage scale:1.0 orientation:UIImageOrientationDown];
            ((UIImageView  *)self.imageViews[idx]).image = flippedImage;
       
        
        
        if (!(idx == 1)) {
            return;
        }
        else {
            UIImage *PortraitImage = [[UIImage alloc] initWithCGImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",self.tarotImagePrefix,((Card *)self.randomCards[idx]).image]].CGImage scale:1.0 orientation:UIImageOrientationLeft];
            ((UIImageView *)self.imageViews[idx]).image = PortraitImage;
            return;
        }
        }

    }];
//    self.bigCardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",self.tarotImagePrefix,((Card *)self.randomCards[self.incrementer]).image]];
    }






-(void)tapHappens {
    [self dealForward];
}


-(void)fades{
[UIView animateWithDuration:1.1 animations:^{
    self.tarotLore.alpha = 0;
    self.positionLabel.alpha = 0;
    self.bigCardImage.alpha = 0;
} completion:^(BOOL finished) {
    self.bigCardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",self.tarotImagePrefix,((Card *)self.randomCards[self.incrementer]).image]];
    [self refreshImageViews];
    self.tarotLore.text = ((Card *)self.randomCards[self.incrementer]).upDescription;
    self.positionLabel.text = self.positionStringsArray[self.incrementer];
}];
    

    
  //    ((UIImageView *)self.imageViews[self.incrementer]).image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",self.tarotImagePrefix,((Card *)self.randomCards[self.incrementer]).image]];

    
    [UIView animateWithDuration:1.7 delay:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
         ((UIImageView *)self.imageViews[self.incrementer]).alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            self.bigCardImage.alpha = 1;
            self.positionLabel.alpha = 0.8;
            self.tarotLore.alpha = 0.8;
        }];
    }];
    
    
    
}


-(void)dealForward {
    if (!(self.incrementer < 10)) {
        return;
    }
    if (self.incrementer == 9) {
        [self fades];
        [self.view addSubview:self.detailButton];
        return;
    }
        [self fades];
    self.incrementer++;
}

-(void)buttonAction{
    [self.navigationController presentViewController:[DefListTableViewController preLoadedView:self.randomCards] animated:YES completion:nil];
}



-(void)dealBack {
    
//    THIS SHOULD JUST RESET THE LABEL TEXT WITH ANIMATION
    if (self.incrementer == 0) {
        return;
    }
    if (self.incrementer == 9) {
        [self.detailButton removeFromSuperview];
    }
    self.incrementer--;
    [self fades];

}


#pragma mark -
#pragma mark Lazy Accessors
-(NSArray *)randomCards{
    if (!_randomCards){
        _randomCards = [NSArray array];
        _randomCards = [[Prediction celticCross] copy];

    }
    return _randomCards;
}


-(CGRect)smallerFrame {
    CGRect superFrame = self.view.superview.frame;
    _smallerFrame = CGRectMake((superFrame.size.width / 10), (superFrame.size.height / 10), (superFrame.size.width * 0.8), (superFrame.size.height *0.8));
    return _smallerFrame;
}

-(NSUInteger)incrementer {
    if (!_incrementer) {
        _incrementer = 0;
    }
    else if (_incrementer>=10){
        _incrementer = 9;
    }
    return _incrementer;
}


-(NSUInteger)deckIncrementer {
    if (!_deckIncrementer) {
        _deckIncrementer = 0;
        return _deckIncrementer;
    }
    if (_deckIncrementer>=2){
        _deckIncrementer = 0;
        return _deckIncrementer;
    }
    return _deckIncrementer;
}

-(UIButton *)detailButton {
    if (!_detailButton){
        _detailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _detailButton.frame = CGRectMake((self.view.frame.size.width * 0.8), (self.view.frame.size.height * 0.85), (self.view.frame.size.width * 0.2), (self.view.frame.size.height * 0.08));
        UIImage *PortraitImage = [[UIImage alloc] initWithCGImage:[UIImage imageNamed:@"tarot"].CGImage scale:1.0 orientation:UIImageOrientationLeft];
        [_detailButton setBackgroundImage:PortraitImage forState:UIControlStateNormal];
        [_detailButton setTitle:@"Summary" forState:UIControlStateNormal];
        _detailButton.tintColor = [UIColor whiteColor];
        _detailButton.titleLabel.textColor = [UIColor whiteColor];
        [_detailButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailButton;
}

-(UIButton *)deckChangeButton {
    if (!_deckChangeButton){
        _deckChangeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _deckChangeButton.frame = CGRectMake(10, (self.view.frame.size.height * 0.85), (self.view.frame.size.width * 0.2), (self.view.frame.size.height * 0.08));
        UIImage *PortraitImage = [[UIImage alloc] initWithCGImage:[UIImage imageNamed:@"tarot"].CGImage scale:1.0 orientation:UIImageOrientationLeft];
        _deckChangeButton.tintColor = [UIColor whiteColor];
        [_deckChangeButton setBackgroundImage:PortraitImage forState:UIControlStateNormal];
        [_deckChangeButton setTitle:@"Switch Decks" forState:UIControlStateNormal];

//        UIImageView *bgcard = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tarot"]];
//        bgcard.frame = _deckChangeButton.frame;
//        [_deckChangeButton addSubview:bgcard];
        
        [_deckChangeButton addTarget:self action:@selector(deckSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deckChangeButton;
}



-(NSArray *)positionStringsArray {
    if (!_positionStringsArray){
        NSMutableArray *celticSpread = [NSMutableArray array];
        [celticSpread addObject:@"The first card represents the general atmosphere that surrounds the question asked and the influences at work around it."];
        [celticSpread addObject:@"This card should be laid across the first; it is always read right side up, and shows what the opposing forces may be for good or evil."];
        [celticSpread addObject:@"The basis of the matter—something that has already become part of the subject’s experience in the past."];
        [celticSpread addObject:@"This shows the influence that is just passing away."];
        [celticSpread addObject:@"Represents something that may happen in the future."];
        [celticSpread addObject:@"Things that will come to pass in the near future—e.g., a meeting, an affair, a person, an influence."];
        [celticSpread addObject:@"The negative feelings he has about the question asked."];
        [celticSpread addObject:@"Represents Querent’s environment, the opinions and influence of family and friends on the matter."];
        [celticSpread addObject:@"Represents the Querent’s own hopes and ideals in the matter.”"];
        [celticSpread addObject:@"This tenth and last card tells what the final outcome will be. It should include all that has been divined from the other cards on the table."];
        _positionStringsArray = celticSpread;
    }
    return _positionStringsArray;
    }



@end
