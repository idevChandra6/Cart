// Generated by Apple Swift version 3.0 (swiftlang-800.0.46.2 clang-800.0.38)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import Foundation;
@import UIKit;
@import CoreGraphics;
#endif

#import <OMCCore/OMCCore.h>

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class User;

SWIFT_CLASS("_TtC7OMCCore14AnalyticsAgent")
@interface AnalyticsAgent : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) AnalyticsAgent * _Nonnull sharedInstance;)
+ (AnalyticsAgent * _Nonnull)sharedInstance;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
- (void)trackSessionStarted;
- (void)trackSessionEnded;
- (void)trackScreenViewStarted:(NSString * _Nonnull)screenName;
- (void)trackScreenViewEnded:(NSString * _Nonnull)screenName;
- (void)trackButtonTapped:(NSString * _Nonnull)screenName buttonName:(NSString * _Nonnull)buttonName;
- (void)trackError:(NSString * _Nonnull)screenName anError:(NSError * _Nonnull)anError;
- (void)trackUserAction:(NSString * _Nonnull)category eventLabel:(NSString * _Nonnull)eventLabel userAction:(NSString * _Nonnull)userAction;
- (void)trackLoginWithAuthenticatedUser:(User * _Nonnull)user;
- (void)trackLogoutWithAuthenticatedUser:(User * _Nonnull)user;
@end

@class NSDictionary;

SWIFT_CLASS("_TtC7OMCCore3App")
@interface App : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nullable appName;)
+ (NSString * _Nullable)appName;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nullable appVersion;)
+ (NSString * _Nullable)appVersion;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nullable appBuildNumber;)
+ (NSString * _Nullable)appBuildNumber;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nullable appVersionAndBuildNumber;)
+ (NSString * _Nullable)appVersionAndBuildNumber;
+ (NSString * _Nonnull)generateNewSessionId;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) NSDictionary * _Nullable culture;)
+ (NSDictionary * _Nullable)culture;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) NSDictionary * _Nullable dateLocaleIdentifier;)
+ (NSDictionary * _Nullable)dateLocaleIdentifier;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class ServiceAgent;

SWIFT_CLASS("_TtC7OMCCore11BaseService")
@interface BaseService : NSObject
- (nonnull instancetype)initWithServiceAgent:(ServiceAgent * _Nonnull)serviceAgent OBJC_DESIGNATED_INITIALIZER;
- (void)sendRequest:(NSString * _Nullable)requestUrl accessToken:(NSString * _Nullable)accessToken errorHandler:(void (^ _Nonnull)(NSError * _Nullable))errorHandler completionHandler:(void (^ _Nonnull)(void))completionHandler;
- (NSData * _Nullable)createPostData;
- (NSData * _Nullable)createPutData;
- (NSError * _Nullable)createParseError:(NSError * _Nonnull)errorType;
- (BOOL)parseResponseDictionary:(NSDictionary * _Nonnull)dictionary error:(NSError * _Nullable * _Nullable)error;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class UIView;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC7OMCCore18BaseViewController")
@interface BaseViewController : UIViewController
@property (nonatomic, strong) UIView * _Null_unspecified progressView;
@property (nonatomic, readonly, copy) NSString * _Nonnull analyticsScreenName;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)displayProgressViewWithText:(NSString * _Nonnull)text inView:(UIView * _Nullable)inView;
- (void)hideProgressView:(UIView * _Nullable)inView;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSArray;

SWIFT_CLASS("_TtC7OMCCore13ConfiguredEnv")
@interface ConfiguredEnv : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) ConfiguredEnv * _Nonnull sharedInstance;)
+ (ConfiguredEnv * _Nonnull)sharedInstance;
@property (nonatomic, readonly, copy) NSString * _Nonnull environmentKey;
@property (nonatomic, copy) NSString * _Nonnull baseurlString;
@property (nonatomic, copy) NSString * _Nonnull apiTokenString;
@property (nonatomic, strong) NSDictionary * _Nullable configEnvDictionary;
@property (nonatomic, copy) NSString * _Nonnull testURL;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@property (nonatomic, copy) NSString * _Nonnull environment;
@property (nonatomic, copy) NSString * _Nonnull baseUrl;
@property (nonatomic, copy) NSString * _Nonnull apiToken;
- (NSString * _Nonnull)getbaseURL;
@property (nonatomic, readonly, copy) NSString * _Nonnull baseApiUrl;
@property (nonatomic, readonly, copy) NSString * _Nonnull baseVerApiUrl;
@property (nonatomic, readonly, copy) NSString * _Nonnull baseVersionedApiUrl;
+ (NSString * _Nullable)stringForKey:(NSString * _Nonnull)key environment:(NSString * _Nonnull)environment;
+ (NSArray * _Nullable)arrayForKey:(NSString * _Nonnull)key environment:(NSString * _Nonnull)environment;
+ (NSString * _Nullable)stringForKeyForAnyEnv:(NSString * _Nonnull)key;
+ (NSString * _Nullable)googleAnalyticsAccount;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly) BOOL canDisplayParsigError;)
+ (BOOL)canDisplayParsigError;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly) BOOL canDisplayServerError;)
+ (BOOL)canDisplayServerError;
@end

@class UIImage;

SWIFT_CLASS("_TtC7OMCCore7Contact")
@interface Contact : NSObject <NSCoding>
@property (nonatomic, copy) NSString * _Nullable uid;
@property (nonatomic, copy) NSString * _Nullable firstName;
@property (nonatomic, copy) NSString * _Nullable lastName;
@property (nonatomic, copy) NSString * _Nullable givenName;
@property (nonatomic, copy) NSString * _Nullable companyName;
@property (nonatomic, copy) NSString * _Nullable companyLogoUrl;
@property (nonatomic, copy) NSString * _Nullable group;
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> * _Nullable phones;
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> * _Nullable emails;
@property (nonatomic, copy) NSString * _Nullable photoImageUrl;
@property (nonatomic, strong) UIImage * _Nullable photo;
@property (nonatomic, copy) NSString * _Nullable packageType;
@property (nonatomic, copy) NSString * _Nullable cardNumber;
@property (nonatomic, copy) NSString * _Nullable rewardPoints;
@property (nonatomic, copy) NSString * _Nullable role;
@property (nonatomic, copy) NSString * _Nullable selectedGift;
- (nonnull instancetype)initWithUserId:(NSString * _Nullable)userId OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic, readonly, copy) NSString * _Nullable displayName;
- (void)encodeWithCoder:(NSCoder * _Nonnull)aCoder;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC7OMCCore6Device")
@interface Device : NSObject
+ (BOOL)isSimulator;
+ (BOOL)isiPhone6Or6S;
+ (BOOL)isiPhone6PlusOr6SPlus;
+ (NSString * _Nonnull)iOSVersion;
+ (NSString * _Nonnull)hardwarePlatform;
+ (BOOL)isiPhone5;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC7OMCCore14NetworkManager")
@interface NetworkManager : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) NetworkManager * _Nonnull sharedInstance;)
+ (NetworkManager * _Nonnull)sharedInstance;
- (BOOL)isConnectedToNetwork;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC7OMCCore14ProgressButton")
@interface ProgressButton : KAProgressButton
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame SWIFT_UNAVAILABLE;
@property (nonatomic) CGFloat downloadPercentage;
@property (nonatomic) BOOL showProgressIndicator;
@end


SWIFT_CLASS("_TtC7OMCCore12ServiceAgent")
@interface ServiceAgent : NSObject <NSURLSessionDelegate>
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface UIButton (SWIFT_EXTENSION(OMCCore))
@end


@interface UIColor (SWIFT_EXTENSION(OMCCore))
@end


@interface UIImage (SWIFT_EXTENSION(OMCCore))
@end


@interface UIImageView (SWIFT_EXTENSION(OMCCore))
@end


@interface UITextField (SWIFT_EXTENSION(OMCCore))
@end


@interface UIView (SWIFT_EXTENSION(OMCCore))
@end


@interface UIView (SWIFT_EXTENSION(OMCCore))
@end


@interface UIWindow (SWIFT_EXTENSION(OMCCore))
@property (nonatomic, readonly, strong) UIViewController * _Nullable visibleViewController;
+ (UIViewController * _Nullable)getVisibleViewControllerFrom:(UIViewController * _Nullable)vc;
@end


SWIFT_CLASS("_TtC7OMCCore4User")
@interface User : Contact
@property (nonatomic, copy) NSString * _Nullable accessToken;
- (nonnull instancetype)initWithUserId:(NSString * _Nonnull)userId accessToken:(NSString * _Nonnull)accessToken OBJC_DESIGNATED_INITIALIZER;
- (void)createTransmissionBeacon:(NSString * _Nonnull)proximityUUD major:(NSInteger)major minor:(NSInteger)minor;
- (void)Save;
+ (User * _Nullable)retrieveLastUser;
+ (void)removeLastUser;
- (void)encodeWithCoder:(NSCoder * _Nonnull)aCoder;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithUserId:(NSString * _Nullable)userId SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC7OMCCore15UserPreferences")
@interface UserPreferences : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) UserPreferences * _Nonnull sharedInstance;)
+ (UserPreferences * _Nonnull)sharedInstance;
@property (nonatomic) BOOL isFirstAppSession;
@property (nonatomic, copy) NSString * _Nullable environment;
- (void)incrementSessionCount;
- (id _Nullable)loadForKey:(NSString * _Nonnull)key;
- (void)removeForKey:(NSString * _Nonnull)key;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
