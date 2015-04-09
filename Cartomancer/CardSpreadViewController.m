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




@property (strong, nonatomic) UITapGestureRecognizer *tappy;
@property (strong, nonatomic) UISwipeGestureRecognizer *forwardSwish;
@property (strong, nonatomic) UISwipeGestureRecognizer *backSwish;
@property (strong, nonatomic) UILabel *tarotLore;
@property (nonatomic, assign) NSUInteger incrementer;
@property (nonatomic, assign) CGRect smallerFrame;
@property (nonatomic, strong) NSArray *randomCards;
//@property (nonatomic, strong) NSArray *cardDefs;
@property (nonatomic, strong) UIButton *detailButton;
@end

@implementation CardSpreadViewController {
    
    
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tappy = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHappens)];
    self.forwardSwish = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dealForward)];
    self.backSwish = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dealBack)];

    self.tappy.numberOfTapsRequired = 1;
    [self.forwardSwish setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.backSwish setDirection:UISwipeGestureRecognizerDirectionRight];

    [self.view addGestureRecognizer:self.tappy];
    [self.view addGestureRecognizer:self.forwardSwish];
    [self.view addGestureRecognizer:self.backSwish];
    [self.view addSubview:self.tarotLore];
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

-(void)tapHappens {
    [self dealForward];
}

-(void)dealForward {
    if (self.incrementer >= 10) {
//        self.view add subview/elementwhatever ,a button that pushes modal tableview controller
        return;
    }
    [UIView animateWithDuration:1.4 animations:^{
        self.tarotLore.alpha = 0;
    }];
    self.tarotLore.text = ((Card *)self.randomCards[self.incrementer]).upDescription;
    [UIView animateWithDuration:1.4 animations:^{
        ((UIImageView *)self.imageViews[self.incrementer]).alpha = 1;
    }];
    [UIView animateWithDuration:2.1 animations:^{
        self.tarotLore.alpha = 0.7;
        ((UIImageView *)self.imageViews[self.incrementer]).image = [UIImage imageNamed:[NSString stringWithFormat:@"RW%@",((Card *)self.randomCards[self.incrementer]).image]];
    }];
    

    if (self.incrementer == 1){
        UIImage *PortraitImage = [[UIImage alloc] initWithCGImage:[UIImage imageNamed:[NSString stringWithFormat:@"RW%@",((Card *)self.randomCards[self.incrementer]).image]].CGImage scale:1.0 orientation:UIImageOrientationRight];
        ((UIImageView *)self.imageViews[self.incrementer]).image = PortraitImage;
    }
    if (self.incrementer == 9) {
        [self.view addSubview:self.detailButton];
    }
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
    [UIView animateWithDuration:0.9 animations:^{
        ((UIImageView *)self.imageViews[self.incrementer]).alpha = 0;
    }];
    self.incrementer--;
}


#pragma mark -
#pragma mark Lazy Accessors
-(NSArray *)randomCards{
    if (!_randomCards){

        _randomCards = [[Prediction celticCross] copy];
        
//        NSMutableArray *secx = [NSMutableArray array];
//        for (int inc = 0; inc < 10;inc++) {
//            int lul = arc4random_uniform(78);
//            UIImage *wut = [UIImage imageNamed:[NSString stringWithFormat:@"tarot%d.jpg",lul]];
//            [secx addObject:wut];
//        }
//        _randomCards= [secx copy];
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

-(UILabel *)tarotLore {
    if (!_tarotLore){
        CGRect aFrame = CGRectMake((self.view.frame.size.width / 10), (self.view.frame.size.height / 3), (self.view.frame.size.width * 0.9), (self.view.frame.size.height / 3));
        self.tarotLore = [[UILabel alloc]initWithFrame:aFrame];
        self.tarotLore.alpha = 0.0;
        self.tarotLore.backgroundColor = [UIColor blackColor];
        self.tarotLore.textAlignment = NSTextAlignmentCenter;
        self.tarotLore.layer.borderWidth = 5;
        self.tarotLore.layer.borderColor = [UIColor whiteColor].CGColor;
        self.tarotLore.textColor = [UIColor whiteColor];
        self.tarotLore.numberOfLines = 10;
    }
    return _tarotLore;
}


-(UIButton *)detailButton {
    if (!_detailButton){
        self.detailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.detailButton setBackgroundColor:[UIColor greenColor]];
        self.detailButton.frame = CGRectMake((self.view.frame.size.width * 0.8), (self.view.frame.size.height * 0.8), (self.view.frame.size.width * 0.1), (self.view.frame.size.height * 0.1));
        self.detailButton.titleLabel.text = @"Summary";
        [self.detailButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailButton;
}

//
//-(NSArray *)cardDefs{
//    if (!_cardDefs){
//        _cardDefs = [NSArray arrayWithObjects:
//                     @"Your own mindset is a critical factor when the Devil card appears. If you think darkness has won, it has. If you are willing to let others exploit and restrain you, then they can and they will. But no one has power over you unless you give it away. If you are willing to release yourself from the chains of ignorance, you can do so, and you can step into the light. Turn all that negative energy into positive energy and see how much you can accomplish when you believe you can. Take a good long look at yourself and try to see what you could not see before. Always remember, that shadow cannot exist without light, and that there is no Devil except the one you create.",
//                     @"When the Hanged Man appears, know that greater wisdom and happiness is at hand, but only if you are prepared to sacrifice something for that wisdom. Sometimes it is something physical you must be deprived of, but in most cases it is a perspective or a viewpoint that must be left behind. For example, a fantasy that you can never fulfill, or a crush on someone who's out of your reach. Inevitably, sacrificing something you value will always lead you to something even more valuable. In the wake of an unattainable dream you will find something else within your reach. Forgetting about one love will allow your heart to open to someone else.",
//                     @"Dangerous as it may seem to assume the personality of the Knight of Swords, sometimes it is necessary and even preferable to do so. Whenever you feel afraid or indecisive, call on the Knight of Swords to give you a shot of confidence and clarity. His impartiality is very desirable when making hard choices, though you have to be careful not to act too hastily, or else the effort is wasted. His refusal to back down from fear makes him a pillar of strength. All of his negative qualities - and there are quite a few - must be carefully monitored; otherwise they will start to rage out of control, and that's definitely not what you want.",
//                     @"A Queen of Cups lies within each of us, and in some it is closer to the surface than in others. When she appears in reference to an aspect of your own personality, the Queen of Cups should be taken as a suggestion to think carefully about how you use the vast stores of spiritual wisdom you have access to all the time. She can be a sign that you should use you intuition to guide you - or she can be a warning that you are thinking too much with your heart and not with your head. This can cause your dreams to grow out of control... and out of reach. Like all of the Cups court cards, the Queen encourages a moderate approach to intuition and wisdom. The heart may see farther, but sometimes you will have to look at things with your eyes.",
//                     @"It is rare that the Nine of Cups refers to a sense of spiritual bliss, since the cards of the spirit are the Swords. But with the Swords suit so full of strife and danger, the Nine of Cups would look out of place anywhere else but in the Cups suit. And if you think about it this makes sense, because when the pleasure and contentment of the physical plane is transferred to the spiritual level, it becomes inner peace and harmony with the Universe. The Universe is, after all, the source of all the love and pleasure that flows through the Nine of Cups into our lives. It only makes sense that we can sometimes follow that river to its source.",
//                     @"yKnow also that the perfectly abundant world of the Empress is always free for you to enjoy. Even if you know that you have to go back to the real world eventually, a vacation from the hectic and artificial life that most people live these days will certainly be welcome. Spend some time outdoors, in the fresh air, enjoying every aspect of creation. And then, when you go back to where you were, the Empress' creative power and beauty will remain to inspire you and give you power. Strengthen your innate connection with the Earth's creativity and you will, by association, strengthen your own creative power. Cultivate your creativity and plants the seeds of a bountiful harvest.",
//                     @"The implementation of new ideas is a central theme of the Wands and the Five can show times where this implementation is halted or blocked in some way. This card may also appear when your ideas meet tough challenges by skeptics or opponents around you. At times like this, the best offense is a good defense. Hold fast to your resolve and let nothing deter you from your objectives. You will always succeed if you can tap the fiery energy of the Wands and, instead of using it for destructive purposes like fighting and quarelling, use it for constructive purposes. Compromise if you must, but refuse to lose your cool, even while standing on the hottest coals.",
//                     @"If you can start seeing pain as an opportunity to expand and learn, life will suddenly become a whole lot less painful. The challenges remain but once they are no longer perceived as negative and evil, they lose a lot of their impact and their potency. When the Three of Swords appears and it is not in reference to an event, it is likely telling you that you have the ability to conquer any pain that comes your way. And here's how: see if the pain can help you grow. If someone has betrayed you and you don't think you can ever love again, challenge that belief wholeheartedly. Don't be surprised when your heart emerges from darkness, even more capable of loving than before.",
//                     @"The artist is perhaps the one who can have ultimate freedom of expression through his work, because each masterpiece is really a piece of the master who created it. The Three of Pentacles is a sign that anyone, not just the sculptors and painters, can express themselves through their career, and it is an indication that you should certainly try. This does not mean that you can neglect the more serious aspects of your job in order to amuse yourself, howeer. The balance of work and pleasre found on the Two can be integrated, but that balance cannot be lost or thrown away. To do so is to defeat the purpose of this card.",
//                     @"Sometimes you also have to remember that change never happens just for the sake of change. There is always a reason for the disturbance, an imbalance that must be eliminated or a wrong that must be righted. In these cases, even a disastrous change can be beneficial. A relationship without love is bound to fall apart anyway, so it may be better that it fails sooner than later. The Five of Cups tells you to be thankful for what is left, don't worry about what cannot be changed, and turn a setback into a step forward. Never let your tears stop you from seeing what is left over.", nil];
//    }
//    return _cardDefs;
//}



@end
