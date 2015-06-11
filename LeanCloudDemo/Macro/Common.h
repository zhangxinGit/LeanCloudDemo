//
//  Common.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/17.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

//#ifndef UZhong_Common_h
//#define UZhong_Common_h

#ifdef DEBUG
#   define ULog(...) NSLog((@"%s [Line %d] %@"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#   define ULog(...)
#endif

typedef void (^UErrorBlock)(NSError *error);

#import "UZFoundationKit.h"
#import "UZUIKit.h"
#import <Toast/UIView+Toast.h>
#import <RHParrotData/RHParrotData.h>
#import <KVOController/FBKVOController.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "EXTScope.h"
#import "EXTKeyPathCoding.h"
#import "UAppContext.h"
#import "UHttpClient.h"
#import "UComUtil.h"

#define LOAD_SINGLE_PRODUCT  @"loadProductInfo"

#define SEND_PRODUCT_INFO   @"sendProductInfo"

#define SHOW_SINGLEPRODUCT_FROM_MESSAGE @"showSingleProductFromMessage"

//#ifdef DEBUG
//#define UMOBILE_URL         @"http://dtouch.ihaveu.com"
//#define USTATION_URL        @"http://dww.ihaveu.com"
//#define USTATION_IMAGE_URL  @"http://i0.ihaveu.com"
//#define UVIDEO_URL          @"http://video.ihaveu.net.cn"
//#define USIMILAR_URL        @"http://devepm.ihaveu.net"
//#else
#define UMOBILE_URL         @"http://touch.ihaveu.com"
#define USTATION_URL        @"http://www.ihaveu.com"
#define USTATION_IMAGE_URL  @"http://i0.ihaveu.com"
#define UVIDEO_URL          @"http://video.ihaveu.net.cn"
#define USIMILAR_URL        @"http://epm.ihaveu.net"
//#endif

#define UDatabaseName             (@"UZhongHaiTao.sqlite")

#define IOS8_OR_LATER             ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)

#define SCREEN_WIDTH              (AppContext.deviceInfo.screenWidth)
#define SCREEN_HEIGHT             (AppContext.deviceInfo.screenHeight)
#define SCREEN_BOUNDS             (AppContext.deviceInfo.screenBounds)

#define TABBAR_HEIGHT             (49.0)
#define NAVIBAR_HEIGHT            (44.0)
#define STATUSBAR_HEIGHT          (20.0)

#define RETINA_SCALE              (2)
#define TOAST_DURATION            (0.5)

#define VIEW_HEIGHT               (SCREEN_HEIGHT-NAVIBAR_HEIGHT-STATUSBAR_HEIGHT)
#define MARGIN_HORIZONTAL         (SCREEN_WIDTH * 0.05)
#define CONTENT_WIDTH             (SCREEN_WIDTH - 2*MARGIN_HORIZONTAL)

#define SHARE_DEFAULTS            [NSUserDefaults standardUserDefaults]
#define SHARE_APPLICATION         [UIApplication sharedApplication]
#define SHARE_WINDOW              SHARE_APPLICATION.keyWindow
#define NOTIFICATION_CENTER       [NSNotificationCenter defaultCenter]

#define COLOR(R, G, B, A)         [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:A]
#define UIColorFromHex(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define InstantiateVCFromStoryboard(storyboardName, VCID)       [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:VCID];

#define HttpClient                [UHttpClient sharedClient]
#define AppContext                [UAppContext context]
#define DBManager                 [UDatabaseManager databaseManager]
#define DBAgent                   [RHDataAgent agent]

#define FILE_DOCUMENT_PATH        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

#define ImageCache(para)          [UIImage imageNamed:(para)]
#define ImageConcat(url)          [NSString stringWithFormat:@"%@%@", USTATION_IMAGE_URL, url]
#define PointToValue(p)           [NSValue valueWithCGPoint:p]
#define ValueToPoint(v)           [v CGPointValue]
#define ClearObj(para)            (para = nil)
#define StringNotEmpty(str)       (str && (((NSString *)str).length > 0))
#define ArrayNotEmpty(arr)        (arr && arr.count > 0)
#define DictNotEmpty(dict)        (dict && dict.allKeys.count > 0)
#define StringEqual(v, para)      [v isEqualToString:para]
#define StringForce(para)         ((para==nil)?@"":para)
#define IntegerString(num)        [NSString stringWithFormat:@"%zd", num]
#define NumberTransformString(num) [NSString stringWithFormat:@"%@",num];

#define StringToDate(str, format)   [UComUtil stod:str format:format]
#define DateToString(date, format)  [UComUtil dtos:date format:format]

#define TIMER_SECONDS_PER_DAY     (24 * 60 * 60)
#define TIMER_SECONDS_PER_HOUR    (60 * 60)
#define TIMER_SECONDS_MIN         (60)

#define HomePageStoryboardID  (@"HomePageController")

#define SeparatorSymbol       (@"&")

//定义返回请求数据的block类型
typedef void (^SuccessValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(BOOL netConnetState);


//#endif
