//
//  UHttpClient.m
//  UZhongDemo
//
//  Created by Hanran Liu on 14/12/30.
//  Copyright (c) 2014年 ran. All rights reserved.
//

#import "UHttpClient.h"
#import "AFNetworking.h"
#import "SDReachability.h"

#define DefaultTimeoutInterval (10)

static NSString * const HTTP_METHOD_GET     = @"GET";
static NSString * const HTTP_METHOD_POST    = @"POST";
static NSString * const HTTP_METHOD_PUT     = @"PUT";
static NSString * const HTTP_METHOD_DELETE  = @"DELETE";

NSString * UMessageAboutNetworkReachabilityStatus(UNetworkReachabilityStatus status) {
    switch (status) {
        case UNetworkReachabilityStatusNotReachable:
            return @"无网络访问状态";
        case UNetworkReachabilityStatusReachableViaWWAN:
            return @"2g,3g网络状态";
        case UNetworkReachabilityStatusReachableViaWiFi:
            return @"Wifi 网络状态";
        default:
            return @"未知网络状态";
    }
}

NSString * UErrorInfoWithCode(NSInteger errorCode) {
    switch (errorCode) {
        case -1001:
            return @"网络连接超时，请稍后再试";
        case -1009:
            return @"无网络链接，请检查网络后重试";
        default:
            return @"网络连接差，请稍后再试";
    }
}

NSString * UReachabilityStatusChangedNotifcation = @"UReachabilityStatusChangedNotifcation";

@interface UHttpClient ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *httpManager;
@property (nonatomic, strong) SDReachability *reachability;
@end

@implementation UHttpClient

#pragma mark - Singleton
+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    static UHttpClient *client = nil;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] initClient];
    });
    return client;
}

- (instancetype)init {
    return nil;
}

- (instancetype)initClient {
    if (self = [super init]) {
        self.httpManager = [AFHTTPRequestOperationManager manager];
        self.timeoutInterval = DefaultTimeoutInterval;
        self.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
        [self appendContentType:@"application/x-javascript", @"text/html", nil];
        
        self.reachability = [SDReachability reachabilityWithTarget:self action:@selector(reachabilityStatusDidChanged)];
    }
    return self;
}

#pragma mark - Property
- (NSURL *)baseURL {
    return self.httpManager.baseURL;
}

- (void)setBaseURL:(NSURL *)baseURL {
    [self.httpManager setValue:baseURL forKey:@"baseURL"];
}

- (BOOL)allowSSLCertificates {
    return self.httpManager.securityPolicy.allowInvalidCertificates;
}

- (void)setAllowSSLCertificates:(BOOL)allowSSLCertificates {
    self.httpManager.securityPolicy.allowInvalidCertificates = allowSSLCertificates;
}

- (NSSet *)acceptableContentTypes {
    return self.httpManager.responseSerializer.acceptableContentTypes;
}

- (void)appendContentType:(NSString *)contentType, ... {
    va_list args;
    va_start(args, contentType);
    
    NSMutableArray *newTypes = [NSMutableArray array];
    while (contentType) {
        [newTypes addObject:contentType];
        contentType = va_arg(args, NSString *);
    }
    
    va_end(args);
    
    NSMutableSet *contentTypes = [NSMutableSet setWithSet:self.httpManager.responseSerializer.acceptableContentTypes];
    [contentTypes addObjectsFromArray:newTypes];
    self.httpManager.responseSerializer.acceptableContentTypes = contentTypes;
}

#pragma mark - Custom Agent Method
- (void)checkResponse:(id)responseObject hasError:(NSError **)error {
    if ([responseObject isKindOfClass:NSDictionary.class]) {
        NSDictionary *response = responseObject;
        
        if ([response.allKeys containsObject:@"error"]) {
            NSDictionary *errorInfo = response[@"error"];
            *error = [NSError serviceErrorWithInfo:errorInfo];
        }
    }
}

- (NSError *)localizedError:(NSError *)error {
    ULog(@"HttpClient : error code (%zd)", error.code);
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
    userInfo[NSLocalizedDescriptionKey] = UErrorInfoWithCode(error.code);
    return [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
}

#pragma mark - Request Methods
- (void)requestWithPath:(NSString *)path parameters:(id)para method:(NSString *)method success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    NSParameterAssert(path);
    NSParameterAssert(method);
    
    NSString *checkPath = path;
    NSString *urlStr = nil;
    if (self.httpManager.baseURL) {
        urlStr = [[NSURL URLWithString:checkPath relativeToURL:self.httpManager.baseURL] absoluteString];
    } else {
        urlStr = checkPath;
    }
    
    if ([NSURL URLWithString:urlStr] == nil) {
        urlStr = [checkPath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSError *error = nil;
    NSMutableURLRequest *request = [self.httpManager.requestSerializer requestWithMethod:method URLString:urlStr parameters:para error:&error];
    if (error) {
        ULog(@"HttpClient : request serializer failed! error : %@", error.localizedDescription);
        return;
    }
    request.timeoutInterval = self.timeoutInterval;
    request.cachePolicy = self.requestCachePolicy;
    
    AFHTTPRequestOperation *requestOperation = [self.httpManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        [self checkResponse:responseObject hasError:&error];
        if (error) {
            if (failure) failure(error);
            return;
        }
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure([self localizedError:error]);
        }
    }];
    
    [self.httpManager.operationQueue addOperation:requestOperation];
}

- (void)GETRequestWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestWithPath:path parameters:nil method:HTTP_METHOD_GET success:success failure:failure];
}

- (void)GETRequestWithPath:(NSString *)path parameters:(id)para success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestWithPath:path parameters:para method:HTTP_METHOD_GET success:success failure:failure];
}

- (void)POSTRequestWithPath:(NSString *)path parameters:(id)para success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestWithPath:path parameters:para method:HTTP_METHOD_POST success:success failure:failure];
}

- (void)POSTRequestWithPath:(NSString *)path parameters:(id)para constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    NSParameterAssert(path);
    
    [self.httpManager POST:path parameters:para constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        [self checkResponse:responseObject hasError:&error];
        if (error) {
            if (failure) failure(error);
            return;
        }
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure([self localizedError:error]);
        }
    }];
}

- (void)PUTRequestWithPath:(NSString *)path parameters:(id)para success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestWithPath:path parameters:para method:HTTP_METHOD_PUT success:success failure:failure];
}

- (void)DELETERequestWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestWithPath:path parameters:nil method:HTTP_METHOD_DELETE success:success failure:failure];
}

- (void)DELETERequestWithPath:(NSString *)path parameters:(id)para success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self requestWithPath:path parameters:path method:HTTP_METHOD_DELETE success:success failure:failure];
}

#pragma mark - Reachablity
- (UNetworkReachabilityStatus)currentReachablilityStatus {
    return (UNetworkReachabilityStatus)self.reachability.reachabilityStatus;
}

- (BOOL)isNetworkReachable {
    return self.reachability.reachable;
}

- (void)reachabilityStatusDidChanged {
    [[NSNotificationCenter defaultCenter] postNotificationName:UReachabilityStatusChangedNotifcation object:@(self.currentReachablilityStatus) userInfo:nil];
    if (self.statusChangedBlock) {
        self.statusChangedBlock(self.currentReachablilityStatus);
    }
}

#pragma mark - Helper Method
- (id)serializeJsonString:(NSString *)json {
    if ([json isKindOfClass:NSNull.class]) {
        return nil;
    }
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id ret = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        ULog(@"HttpClient : WARNING! Serialize Json Failed!");
    }
    
    return ret;
}

- (BOOL)checkJson:(id)json withValidator:(id)validatorJson {
    if ([json isKindOfClass:[NSDictionary class]] &&
        [validatorJson isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dict = json;
        NSDictionary * validator = validatorJson;
        BOOL result = YES;
        NSEnumerator * enumerator = [validator keyEnumerator];
        NSString * key;
        while ((key = [enumerator nextObject]) != nil) {
            id value = dict[key];
            id format = validator[key];
            if ([value isKindOfClass:[NSDictionary class]]
                || [value isKindOfClass:[NSArray class]]) {
                return [self checkJson:value withValidator:format];
            } else {
                if ([value isKindOfClass:format] == NO &&
                    [value isKindOfClass:[NSNull class]] == NO) {
                    result = NO;
                    break;
                }
            }
        }
        return result;
    } else if ([json isKindOfClass:[NSArray class]] &&
               [validatorJson isKindOfClass:[NSArray class]]) {
        NSArray * validatorArray = (NSArray *)validatorJson;
        if (validatorArray.count > 0) {
            NSArray * array = json;
            NSDictionary * validator = validatorJson[0];
            for (id item in array) {
                BOOL result = [self checkJson:item withValidator:validator];
                if (!result) {
                    return NO;
                }
            }
        }
        return YES;
    } else if ([json isKindOfClass:validatorJson]) {
        return YES;
    } else {
        return NO;
    }
}

@end
