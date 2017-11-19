
#ifndef ____Header_h
#define ____Header_h
#endif

#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define LabelAlloc(x, y, w, h)              [[UILabel alloc]initWithFrame:Rect(x, y, w, h)]
#define ViewAlloc(x, y, w, h)               [[UIView alloc]initWithFrame:Rect(x, y, w, h)]
#define ScrollAlloc(x, y, w, h)             [[UIScrollView alloc]initWithFrame:Rect(x, y, w, h)]
#define Bundle                              [NSBundle mainBundle]
#define ViewWidth(v)                        v.frame.size.width

#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewHeight                      self.view.bounds.size.height
#define SelfViewWidth                       self.view.bounds.size.width

#define Size(w, h)                          CGSizeMake(w, h)

#define SCREEN_WIDTH                        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                       ([UIScreen mainScreen].bounds.size.height)



#define DLog(fmt, ...) DDLogVerbose((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DLogError(fmt, ...)   DDLogError((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DLogWarn(fmt, ...)    DDLogWarn((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DLogInfo(fmt, ...)    DDLogInfo((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DLogDebug(fmt, ...)   DDLogDebug((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DLogVerbose(fmt, ...) DDLogVerbose((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define IPHONE_4    SCREEN_HEIGHT == 480.0f
#define IPHONE_5    SCREEN_HEIGHT == 568.0f
#define IPHONE_6    SCREEN_HEIGHT == 667.0f
#define IPHONE_6P   SCREEN_HEIGHT == 736.0f

#define IOS7_Later ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define IOS8_Later ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define IOS9_Later ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)

#define StatusBarHeight (IOS7==YES ? 0 : 20)

#define NavBarHeigth (IOS7_Later ==YES ? 64 : 44)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBWithAlpha(rgbValue,Alpha) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:Alpha]


//用于block运用外部对象
#define WS(weakSelf,self)  __weak __typeof(&*self)weakSelf = self;

#define BASE_URL @"http://nalijie.kay8.com/"
#define SIGNUP      @"accounts/mobile/signup.api"
#define SIGNIN      @"accounts/mobile/signin.api"
#define TOKEN      @"accounts/token.api"

