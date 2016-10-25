//
//  CSButtonStyleInfo.m
//  Pods
//
//  Created by Chandra on 3/22/16.
//
//

#import "CSButtonStyleInfo.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kCSButtonBorderWidth                1.5f
#define kCSButtonNoBorderWidth              0.0f
#define kCSButtonCornerRadius               6.0f

// CSButtonTypePrimaryWhite
#define kCSButtonTypePrimaryWhiteBackgroundColor                UIColorFromRGB(0xffffff)
#define kCSButtonTypePrimaryWhiteSelectedBackgroundColor        UIColorFromRGB(0xbfd7e9) 
#define kCSButtonTypePrimaryWhiteTextColor                      UIColorFromRGB(0x333333) 
#define kCSButtonTypePrimaryWhiteSelectedTextColor              UIColorFromRGB(0xffffff)
#define kCSButtonTypePrimaryWhiteBorderColor                    UIColorFromRGB(0xd0d0d0)

// CSButtonTypePrimaryGray
#define kCSButtonTypePrimaryGrayBackgroundColor                 UIColorFromRGB(0xebebeb)
#define kCSButtonTypePrimaryGraySelectedBackgroundColor         UIColorFromRGB(0xbfd7e9) 
#define kCSButtonTypePrimaryGrayTextColor                       UIColorFromRGB(0x333333) 
#define kCSButtonTypePrimaryGraySelectedTextColor               UIColorFromRGB(0xebebeb)
#define kCSButtonTypePrimaryGrayBorderColor                     UIColorFromRGB(0xebebeb)

// CSButtonTypePrimaryEmergency
#define kCSButtonTypePrimaryEmergencyBackgroundColor            UIColorFromRGB(0xe10000)
#define kCSButtonTypePrimaryEmergencySelectedBackgroundColor    UIColorFromRGB(0xbfd7e9) 
#define kCSButtonTypePrimaryEmergencyTextColor                  UIColorFromRGB(0xffffff)
#define kCSButtonTypePrimaryEmergencySelectedTextColor          UIColorFromRGB(0xe10000)
#define kCSButtonTypePrimaryEmergencyBorderColor                UIColorFromRGB(0xe10000)

// CSButtonTypeAlternate
#define kCSButtonTypeAlternateBackgroundColor                   UIColorFromRGB(0x057ac8)
#define kCSButtonTypeAlternateSelectedBackgroundColor           UIColorFromRGB(0xbfd7e9) 
#define kCSButtonTypeAlternateTextColor                         UIColorFromRGB(0xffffff)
#define kCSButtonTypeAlternateSelectedTextColor                 UIColorFromRGB(0x057ac8)
#define kCSButtonTypeAlternateBorderColor                       UIColorFromRGB(0x057ac8)

// CSButtonTypeInactive
#define kCSButtonTypeInactiveBackgroundColor                    UIColorFromRGB(0xebebeb)
#define kCSButtonTypeInactiveSelectedBackgroundColor            UIColorFromRGB(0xebebeb)
#define kCSButtonTypeInactiveTextColor                          UIColorFromRGB(0xb8b8b8)
#define kCSButtonTypeInactiveSelectedTextColor                  UIColorFromRGB(0xebebeb)
#define kCSButtonTypeInactiveBorderColor                        UIColorFromRGB(0xebebeb)

// CSButtonTypeOnSlateInactive
#define kCSButtonTypeInactiveOnSlateBackgroundColor             UIColorFromRGB(0xF1F1F1)
#define kCSButtonTypeInactiveOnSlateSelectedBackgroundColor     UIColorFromRGB(0xF1F1F1)
#define kCSButtonTypeInactiveOnSlateTextColor                   UIColorFromRGB(0xb8b8b8)
#define kCSButtonTypeInactiveOnSlateSelectedTextColor           UIColorFromRGB(0xF1F1F1)
#define kCSButtonTypeInactiveOnSlateBorderColor                 UIColorFromRGB(0xebebeb)

// CSButtonTypeTextOnly. iOS Default Button


@interface CSButtonStyleInfo() {
}
/*!
 @brief Private method. Stylizes the button.
 
 @discussion Stylizes the button with background color, text color and pressed state colors.
 
 @param  (UIColor *)aBackColor
 @param  (UIColor *)aSelectedBackgroundColor
 @param  (UIColor *)aTextColor
 @param  (UIColor *)aSelectedTextColor
 @param  (UIColor *)aBorderColor
 @param  (CGFloat)aBorderWidth
 @param  (CGFloat)aCornerRadius
 @param  (BOOL)enabled
 */
-(instancetype)initWithBackgroundColor:(UIColor *)aBackgroundColor
               selectedBackgroundColor:(UIColor *)aSelectedBackgroundColor
                             textColor:(UIColor *)aTextColor
                     selectedTextColor:(UIColor *)aSelectedTextColor
                           borderColor:(UIColor *)aBorderColor
                           borderWidth:(CGFloat)aBorderWidth
                          cornerRadius:(CGFloat)aCornerRadius
                               enabled:(BOOL)enabled;
@end

@implementation CSButtonStyleInfo
-(id)init {
    self = [super init];
    return self;
}

-(instancetype)initWithCSButtonType:(CSButtonType)buttonType {
    switch (buttonType) {
        case CSButtonTypePrimaryWhite:
        case CSButtonTypeOffSizeWhite:
            return [self initWithBackgroundColor:kCSButtonTypePrimaryWhiteBackgroundColor
                         selectedBackgroundColor:kCSButtonTypePrimaryWhiteSelectedBackgroundColor
                                       textColor:kCSButtonTypePrimaryWhiteTextColor
                               selectedTextColor:kCSButtonTypePrimaryWhiteSelectedTextColor
                                     borderColor:kCSButtonTypePrimaryWhiteBorderColor
                                     borderWidth:kCSButtonBorderWidth
                                    cornerRadius:kCSButtonCornerRadius
                                         enabled:YES];
            
        case CSButtonTypePrimaryGray:
            return [self initWithBackgroundColor:kCSButtonTypePrimaryGrayBackgroundColor
                         selectedBackgroundColor:kCSButtonTypePrimaryGraySelectedBackgroundColor
                                       textColor:kCSButtonTypePrimaryGrayTextColor
                               selectedTextColor:kCSButtonTypePrimaryGraySelectedTextColor
                                     borderColor:kCSButtonTypePrimaryGrayBorderColor
                                     borderWidth:kCSButtonNoBorderWidth
                                    cornerRadius:kCSButtonCornerRadius
                                         enabled:NO];

        case CSButtonTypePrimaryEmergency:
            return [self initWithBackgroundColor:kCSButtonTypePrimaryEmergencyBackgroundColor
                         selectedBackgroundColor:kCSButtonTypePrimaryEmergencySelectedBackgroundColor
                                       textColor:kCSButtonTypePrimaryEmergencyTextColor
                               selectedTextColor:kCSButtonTypePrimaryEmergencySelectedTextColor
                                     borderColor:kCSButtonTypePrimaryEmergencyBorderColor
                                     borderWidth:kCSButtonBorderWidth
                                    cornerRadius:kCSButtonCornerRadius
                                         enabled:YES];
            
        case CSButtonTypeAlternate:
        case CSButtonTypeOffSizeAlternate:
            return [self initWithBackgroundColor:kCSButtonTypeAlternateBackgroundColor
                         selectedBackgroundColor:kCSButtonTypeAlternateSelectedBackgroundColor
                                       textColor:kCSButtonTypeAlternateTextColor
                               selectedTextColor:kCSButtonTypeAlternateSelectedTextColor
                                     borderColor:kCSButtonTypeAlternateBorderColor
                                     borderWidth:kCSButtonBorderWidth
                                    cornerRadius:kCSButtonCornerRadius
                                         enabled:YES];

        case CSButtonTypeInactive:
            return [self initWithBackgroundColor:kCSButtonTypeInactiveBackgroundColor
                         selectedBackgroundColor:kCSButtonTypeInactiveSelectedBackgroundColor
                                       textColor:kCSButtonTypeInactiveTextColor
                               selectedTextColor:kCSButtonTypeInactiveSelectedTextColor
                                     borderColor:kCSButtonTypeInactiveBorderColor
                                     borderWidth:kCSButtonBorderWidth
                                    cornerRadius:kCSButtonCornerRadius
                                         enabled:NO];
            
        case CSButtonTypeOnSlateInactive:
            return [self initWithBackgroundColor:kCSButtonTypeInactiveOnSlateBackgroundColor
                         selectedBackgroundColor:kCSButtonTypeInactiveOnSlateSelectedBackgroundColor
                                       textColor:kCSButtonTypeInactiveOnSlateTextColor
                               selectedTextColor:kCSButtonTypeInactiveOnSlateSelectedTextColor
                                     borderColor:kCSButtonTypeInactiveOnSlateBorderColor
                                     borderWidth:kCSButtonBorderWidth
                                    cornerRadius:kCSButtonCornerRadius
                                         enabled:NO];
        default:
            // Return Primary Type
            return [self initWithBackgroundColor:kCSButtonTypePrimaryWhiteBackgroundColor
                         selectedBackgroundColor:kCSButtonTypePrimaryWhiteSelectedBackgroundColor
                                       textColor:kCSButtonTypePrimaryWhiteTextColor
                               selectedTextColor:kCSButtonTypePrimaryWhiteSelectedTextColor
                                     borderColor:kCSButtonTypePrimaryWhiteBorderColor
                                     borderWidth:kCSButtonBorderWidth
                                    cornerRadius:kCSButtonCornerRadius
                                         enabled:YES];
    }
    // Return Primary Type
    return [self initWithBackgroundColor:kCSButtonTypePrimaryWhiteBackgroundColor
                 selectedBackgroundColor:kCSButtonTypePrimaryWhiteSelectedBackgroundColor
                               textColor:kCSButtonTypePrimaryWhiteTextColor
                       selectedTextColor:kCSButtonTypePrimaryWhiteSelectedTextColor
                             borderColor:kCSButtonTypePrimaryWhiteBorderColor
                             borderWidth:kCSButtonBorderWidth
                            cornerRadius:kCSButtonCornerRadius
                                 enabled:YES];
}

-(instancetype)initWithBackgroundColor:(UIColor *)aBackColor
               selectedBackgroundColor:(UIColor *)aSelectedBackgroundColor
                             textColor:(UIColor *)aTextColor
                     selectedTextColor:(UIColor *)aSelectedTextColor
                           borderColor:(UIColor *)aBorderColor
                           borderWidth:(CGFloat)aBorderWidth
                          cornerRadius:(CGFloat)aCornerRadius
                               enabled:(BOOL)enabled{
    self = [super init];
    self.backColor               = aBackColor;
    self.selectedBackgroundColor = aSelectedBackgroundColor;
    self.textColor               = aTextColor;
    self.selectedTextColor       = aSelectedTextColor;
    self.borderColor             = aBorderColor;
    self.borderWidth             = aBorderWidth;
    self.cornerRadius            = aCornerRadius;
    self.enabled                 = enabled;
    
    return self;
}

@end
