#CSButton
Yet another button control for iOS. :)
![Preivew](https://github.com/idevChandra6/CSButton/blob/master/CSButtonDemo.gif)

#How to use
Simple! Just use it as a regular UIButton, but add this line to your code.

`[yourButton stylizeWithType:<CSButtonType>];`


#Sample
`[buttonA stylizeWithType:CSButtonTypeAlternate];`

`[buttonB stylizeWithType:CSButtonTypeEmergency];`

`[buttonC stylizeWithType:CSButtonTypeInactive];`

#Create your own CSButton styles
` // CSButtonTypePrimaryWhite`

` #define kCSButtonTypePrimaryWhiteBackgroundColor                UIColorFromRGB(0xffffff)`

` #define kCSButtonTypePrimaryWhiteSelectedBackgroundColor        UIColorFromRGB(0xbfd7e9) `

` #define kCSButtonTypePrimaryWhiteTextColor                      UIColorFromRGB(0x333333) `

` #define kCSButtonTypePrimaryWhiteSelectedTextColor              UIColorFromRGB(0xffffff)`

` #define kCSButtonTypePrimaryWhiteBorderColor                    UIColorFromRGB(0xd0d0d0)`

