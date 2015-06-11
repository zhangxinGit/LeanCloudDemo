//
//  UHttpClient.h
//  UZhongDemo
//
//  Created by Hanran Liu on 14/12/30.
//  Copyright (c) 2014年 ran. All rights reserved.
//  网络请求服务类

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UNetworkReachabilityStatus) {
    UNetworkReachabilityStatusNotReachable = 0,
    UNetworkReachabilityStatusReachableViaWiFi = 1,
    UNetworkReachabilityStatusReachableViaWWAN = 2
};

typedef void (^HttpSuccessBlock)(id responseObject);
typedef void (^HttpFailureBlock)(NSError *error);
typedef void (^HttpStatusChangedBlock)(UNetworkReachabilityStatus status);

typedef HttpFailureBlock FailDefautUIBlock;

@protocol AFMultipartFormData;

FOUNDATION_EXTERN NSString * UMessageAboutNetworkReachabilityStatus(UNetworkReachabilityStatus status);
FOUNDATION_EXTERN NSString * UErrorInfoWithCode(NSInteger errorCode);
FOUNDATION_EXPORT NSString * UReachabilityStatusChangedNotifcation;

@interface UHttpClient : NSObject

@property (nonatomic, strong) NSURL *baseURL;                       // default http://dwww.ihaveu.com

@property (nonatomic, assign) NSUInteger timeoutInterval;           // default 10s
@property (nonatomic, assign) NSURLRequestCachePolicy requestCachePolicy;
@property (nonatomic, assign) BOOL allowSSLCertificates;            // default to NO

@property (nonatomic, strong, readonly) NSSet *acceptableContentTypes;

@property (nonatomic, copy) FailDefautUIBlock defaultFailUIBlock;
@property (nonatomic, copy) HttpStatusChangedBlock statusChangedBlock;

@property (nonatomic, assign, readonly, getter = isNetworkReachable) BOOL networkReachable;
@property (nonatomic, assign, readonly) UNetworkReachabilityStatus currentReachablilityStatus;

+ (instancetype)sharedClient;

- (id)serializeJsonString:(NSString *)json;
- (BOOL)checkJson:(id)json withValidator:(id)validatorJson;

- (void)appendContentType:(NSString *)contentType, ... NS_REQUIRES_NIL_TERMINATION;

- (void)GETRequestWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
- (void)GETRequestWithPath:(NSString *)path parameters:(id)para success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

- (void)POSTRequestWithPath:(NSString *)path parameters:(id)para success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
- (void)POSTRequestWithPath:(NSString *)path parameters:(id)para constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

- (void)PUTRequestWithPath:(NSString *)path parameters:(id)para success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

- (void)DELETERequestWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
- (void)DELETERequestWithPath:(NSString *)path parameters:(id)para success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

@end
