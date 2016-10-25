//
//  CSButton
//
//
//  Created by ChandraSekhar Polepeddi on 4/17/15.
//

#import <UIKit/UIKit.h>
#import "CSButtonStyleInfo.h"

@interface CSButton : UIButton
/*!
 @brief Stylizes the button to defined KP button styles.
 
 @discussion Stylizes the button to defined background color, text color and pressed state colors.
 
 @param  (CSButtonType)
 */
- (void)stylizeWithType:(CSButtonType)buttonType;

// TO be deleted once the TouchID comps change
- (void)stylizeWithColor:(UIColor *)color;
@end
