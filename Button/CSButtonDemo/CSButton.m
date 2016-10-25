//
//  CSButton
//
//
//  Created by ChandraSekhar Polepeddi on 4/17/15.
//

#import "CSButton.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kControlAnimationDuration       0.2f

#define buttonLayerWidth                1.5f    // To be deleted once TouchID comps change
#define buttonCornerRadius              6.0f    // To be deleted once TouchID comps change

@interface CSButton ()
@property UIColor *iColor;
@property CSButtonStyleInfo *buttonStyleInfo;
@end

@implementation CSButton


#pragma mark - Initalization
- (id)initWithFrame:(CGRect)frame //code
{
    self = [super initWithFrame:frame];
    return self;
}

- (void)stylizeWithType:(CSButtonType)buttonType
{
    self.buttonStyleInfo = [[CSButtonStyleInfo alloc] initWithCSButtonType:buttonType];

    self.layer.borderWidth    = self.buttonStyleInfo.borderWidth;
    self.layer.cornerRadius   = self.buttonStyleInfo.cornerRadius;
    self.layer.borderColor    = self.buttonStyleInfo.borderColor.CGColor;
    self.enabled              = self.buttonStyleInfo.enabled;
    
    self.layer.masksToBounds  = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    
    [self setBackgroundColor:self.buttonStyleInfo.backColor];
    [self setTitleColor:self.buttonStyleInfo.textColor forState:UIControlStateNormal];
    [self setTitleColor:self.buttonStyleInfo.selectedTextColor forState:UIControlStateSelected];
    [self setTitleColor:self.buttonStyleInfo.selectedTextColor forState:UIControlStateHighlighted];
    
    
    [self addTarget:self
             action:@selector(aButtonPressed:)
   forControlEvents:UIControlEventTouchDown];
    [self addTarget:self
             action:@selector(aButtonDragged:)
   forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self
             action:@selector(clearButton:)
   forControlEvents:UIControlEventTouchUpInside];

}

-(void)aButtonPressed: (UIButton *)sender
{
    [UIView animateWithDuration:kControlAnimationDuration
                     animations:^{
                         sender.backgroundColor = self.buttonStyleInfo.textColor;
                     }];
}

-(void)aButtonDragged: (UIButton *)sender
{
    [UIView animateWithDuration:kControlAnimationDuration
                     animations:^{
                         sender.backgroundColor = self.buttonStyleInfo.backColor;
                        }];
}

-(void)clearButton: (UIButton *)sender
{
    [self aButtonDragged:sender];
}

// This method gets removed soon once the comps for TouchID changes.
// The new button designs are not applied to the TouchID screen buttons yet.
- (void)stylizeWithColor:(UIColor *)color
{
    self.iColor = color;
    //    self.titleLabel.font      = [UIFont fontWithName:@"Roboto-Medium"
    //                                                size:14.0f];
    self.layer.borderWidth    = buttonLayerWidth;
    self.layer.cornerRadius   = buttonCornerRadius;
    self.layer.borderColor    = [UIColor clearColor].CGColor;
    self.layer.masksToBounds  = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setBackgroundColor:color];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateSelected];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    [self addTarget:self
             action:@selector(aButtonPressed:)
   forControlEvents:UIControlEventTouchDown];
    [self addTarget:self
             action:@selector(aButtonDragged:)
   forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self
             action:@selector(clearButton:)
   forControlEvents:UIControlEventTouchUpInside];
    
}

@end
