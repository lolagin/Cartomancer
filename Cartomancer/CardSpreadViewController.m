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
@property (weak, nonatomic) IBOutlet UIImageView *sigTarot;

@end

@implementation CardSpreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((UIImageView *)obj).image = [UIImage imageNamed:@"kimCrying"];
    }];
    self.sigTarot.image = [UIImage imageNamed:@"kimCrying"];
    // Do any additional setup after loading the view from its nib.
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
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
