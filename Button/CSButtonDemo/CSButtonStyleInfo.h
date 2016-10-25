//
//  CSButtonStyleInfo.h
//  Pods
//
//  Created by Chandra on 3/22/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, CSButtonType) {
    CSButtonTypePrimaryWhite,
    CSButtonTypePrimaryGray,
    CSButtonTypePrimaryEmergency,
    CSButtonTypeAlternate,
    CSButtonTypeOffSizeWhite,
    CSButtonTypeOffSizeAlternate,
    CSButtonTypeInactive,
    CSButtonTypeOnSlateInactive, //Inactive button other grayscale backgrounds
    CSButtonTypeTextOnly,
};

@interface CSButtonStyleInfo : NSObject
@property UIColor *backColor;
@property UIColor *selectedBackgroundColor;
@property UIColor *textColor;
@property UIColor *selectedTextColor;
@property UIColor *borderColor;
@property CGFloat borderWidth;
@property CGFloat cornerRadius;
@property BOOL    enabled;
-(instancetype)initWithCSButtonType:(CSButtonType)buttonType;
@end
