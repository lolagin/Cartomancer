//
//  CardSpreadViewController.m
//  Cartomancer
//
//  Created by Jeffrey C Rosenthal on 4/7/15.
//  Copyright (c) 2015 northtwilight_development. All rights reserved.
//

#import "CardSpreadViewController.h"
#import "Card.h"

@interface CardSpreadViewController ()
@property (nonatomic, strong) IBOutletCollection(UIImageView) NSArray *imageViews;




@property (strong, nonatomic) UITapGestureRecognizer *tappy;
@property (strong, nonatomic) UISwipeGestureRecognizer *forwardSwish;
@property (strong, nonatomic) UISwipeGestureRecognizer *backSwish;
//@property (assign) NSUInteger masterBlaster;
@property (strong, nonatomic) UILabel *TarotLore;



@end

@implementation CardSpreadViewController {
    int i;
    CGRect superFrame;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    i = 0;
    
    superFrame = self.view.superview.frame;
    self.TarotLore = [[UILabel alloc]initWithFrame:self.view.superview.frame];
    self.TarotLore.alpha = 0.2;
    self.TarotLore.backgroundColor = [UIColor purpleColor];
    self.TarotLore.textAlignment = NSTextAlignmentCenter;
    self.TarotLore.layer.borderWidth = 5;
    self.TarotLore.layer.borderColor = [UIColor greenColor].CGColor;
    self.TarotLore.textColor = [UIColor whiteColor];
    
    self.tappy = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHappens)];
    self.forwardSwish = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dealForward)];
    self.backSwish = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dealBack)];
    self.tappy.numberOfTapsRequired = 1;
    [self.forwardSwish setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.backSwish setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:self.tappy];
    [self.view addGestureRecognizer:self.forwardSwish];
    [self.view addGestureRecognizer:self.backSwish];
    [self.view addSubview:self.TarotLore];
    [self.imageViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((UIImageView *)obj).alpha = 0;
    }];
    // Do any additional setup after loading the view from its nib.
    
}
-(void)tapHappens {
    [self dealForward];

}
-(void)dealForward {
    if (i >= 10) {
        i = 9;
        return;
    }
//    else if (i == 1){
//   UIImage *image = cardray[i].image
//        UIImage *PortraitImage = [[UIImage alloc] initWithCGImage: image.CGImage
//                                                             scale: 1.0
//                                                      orientation: UIImageOrientationLeft];
//    DO SOMETHING W IMAGE
//    }

    [UIView animateWithDuration:1.4 animations:^{
        self.TarotLore.alpha = 0;
    }];
    self.TarotLore.text = @"The Four Of Lulz. This card means stuff";
    [UIView animateWithDuration:1.4 animations:^{
    ((UIImageView *)self.imageViews[i]).alpha = 1;
                }];

    [UIView animateWithDuration:2.1 animations:^{
           self.TarotLore.alpha = 0.7;
                    ((UIImageView *)self.imageViews[i]).image = [UIImage imageNamed:@"masterblaster.jpg"];
    }];
    i++;
}

-(void)dealBack {
    
    if (i <= 0 || i >= 10) {
        return;
    }
    [UIView animateWithDuration:0.9 animations:^{
        ((UIImageView *)self.imageViews[i]).alpha = 0;
    }];
    i--;
    
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







@end
