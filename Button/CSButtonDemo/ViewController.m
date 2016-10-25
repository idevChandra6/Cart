//
//  ViewController.m
//  CSButtonDemo
//
//  Created by Chandra on 6/16/16.
//  Copyright © 2016 Chandra. All rights reserved.
//

#import "ViewController.h"
#import "CSButton.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet CSButton *button1;
@property (nonatomic, weak) IBOutlet CSButton *button2;
@property (nonatomic, weak) IBOutlet CSButton *button3;
@property (nonatomic, weak) IBOutlet CSButton *button4;
@property (nonatomic, weak) IBOutlet CSButton *button5;
@property (nonatomic, weak) IBOutlet UILabel  *lblCounter;
@property (atomic)                   int       number;
@property NSArray *array;
@end

@implementation ViewController

#pragma mark - VC LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.number = 6;
    self.lblCounter.text = [NSString stringWithFormat:@"%d", self.number];

    [self.button1 stylizeWithType:CSButtonTypeAlternate];
    [self.button2 stylizeWithType:CSButtonTypePrimaryEmergency];
    [self.button3 stylizeWithType:CSButtonTypePrimaryWhite];
    [self.button4 stylizeWithType:CSButtonTypeAlternate];
    [self.button5 stylizeWithType:CSButtonTypeAlternate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%@", self.array);
}

#pragma mark - Utilities
- (IBAction)up:(id)sender {
    self.lblCounter.text = [NSString stringWithFormat:@"%d", ++self.number];
}

- (IBAction)down:(id)sender {
    self.lblCounter.text = [NSString stringWithFormat:@"%d", --self.number];
}

- (IBAction)buttonOneTapped:(CSButton *)sender {
    [self.button1 stylizeWithType:CSButtonTypeInactive];
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityView setTag:100];
    CGPoint center = self.button1.center;
    center.x += (self.button1.frame.size.width/2) - activityView.frame.size.width;
    activityView.center = center;
    [self.button1.superview insertSubview:activityView aboveSubview:self.button1];
    [activityView startAnimating];
    [self performSelector:@selector(simulateDelay) withObject:self.button1 afterDelay:2.5f];
}

- (void)simulateDelay {
    NSArray *viewArray = [[self.button1 superview] subviews];
    for(UIView *view in viewArray) {
        if(view.tag == 100) {
            [view removeFromSuperview];
            [UIView animateWithDuration:1.5f animations:^{
            [self.button1 stylizeWithType:CSButtonTypeAlternate];
                [self.button1 setTitle:@"Success" forState:UIControlStateNormal];
            } completion:^(BOOL a){
                [self.button1 setTitle:@"Make Another Payment" forState:UIControlStateNormal];
            }];
        }
    }
}
@end
