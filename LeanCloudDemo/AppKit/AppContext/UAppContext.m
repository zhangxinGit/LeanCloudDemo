//
//  UAppContext.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/8.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import "UAppContext.h"
//#import "USessionService.h"
#import "CDIMConfig.h"
#import "CDUserFactory.h"

static NSString * const UAppVersionKey  = @"app_version";

@interface UAppContext ()
@property (nonatomic, assign, readwrite) BOOL firstLaunch;
@property (nonatomic, strong, readwrite) DeviceInfo *deviceInfo;
@property (nonatomic, strong, readwrite) UDefaultsData *defaultsData;
@end

@implementation UAppContext

#pragma mark - Singleton
+ (instancetype)context {
  static dispatch_once_t onceToken;
  static UAppContext *context = nil;
  dispatch_once(&onceToken, ^{
    context = [[self alloc] initContext];
  });
  return context;
}

- (instancetype)init {
  NSAssert(NO, @"Singleton class, use class method context");
  return nil;
}

- (instancetype)initContext {
  if (self = [super init]) {
    self.deviceInfo = [DeviceInfo info];
    [self.deviceInfo gatherDeviceInfomation];
  }
  return self;
}

#pragma mark - Property
- (NSString *)appVersion {
  return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

#pragma mark - Startup Flow
- (void)startupAppLaunchFlow {
  [self configureLeanCloudSDK];
  [self configurationDatabase];
  [self loadDefaults];
  [self checkVersionAndLaunchCount];
  [self checkLoginStatus];
}

//配置即时通讯SDK
- (void)configureLeanCloudSDK{
    //初始化 LeanCloud IM SDK  [AVOSCloud setApplicationId:@"yourAppID" clientKey:@"yourAppKey"];
    //优众海淘设置
    [AVOSCloud setApplicationId:@"zrggiejlzmbwj2xsigj9qm4a2imfyzm9ajzd4oc1x0ct7720" clientKey:@"ys3g1kx8bam13tq6oso01wfnlb9i1ih7m5z5ixe7worrycsi"];
    [CDIMConfig config].userDelegate = [[CDUserFactory alloc] init];
    
     #ifdef DEBUG
    [AVAnalytics setCrashReportEnabled:NO];
    [AVAnalytics setAnalyticsEnabled:NO];
    [AVOSCloud setVerbosePolicy:kAVVerboseShow];
    [AVLogger addLoggerDomain:AVLoggerDomainIM];
    [AVLogger addLoggerDomain:AVLoggerDomainCURL];
    [AVLogger setLoggerLevelMask:AVLoggerLevelAll];
    #endif
}

- (void)configurationDatabase {
  NSURL *momdURL = [[NSBundle mainBundle] URLForResource:@"UZhongHaiTao"withExtension:@"momd"];
  NSURL *appDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  NSURL *storeURL = [appDocumentsDirectory URLByAppendingPathComponent:UDatabaseName];
  [RHDataAgent setupAgentWithMomdFile:momdURL andStoreURL:storeURL];
  ULog(@"AppContext: Doc dir -- %@", NSHomeDirectory());
}

- (void)loadDefaults {
  RHQuery *query = [RHQuery queryWithEntity:UDefaultsData.entityName];
  NSArray *results = query.execute;
  UDefaultsData *appDefaults;
  if (results.count > 0) {
    appDefaults = [results firstObject];
  } else {
    appDefaults = [UDefaultsData createNewObjectIntoContext:DBAgent.mainManagedObjectContext];
    appDefaults.dbVersion = @(1);
  }
  
  appDefaults.launchCount = @([appDefaults.launchCount integerValue]+1);
  [DBAgent commit];
  
  self.defaultsData = appDefaults;
}

- (void)checkVersionAndLaunchCount {
  NSString *currentVersion = self.appVersion;
  NSString *lastVersion = self.defaultsData.appVersion;
  if (!StringEqual(currentVersion, lastVersion)) {
    self.defaultsData.appVersion = currentVersion;
    self.defaultsData.launchCount = @(1);
    [DBAgent commit];
    self.firstLaunch = YES;
  } else {
    self.firstLaunch = NO;
  }
  ULog(@"AppContext: AppVersion--%@ LaunchCount--%@", currentVersion, self.defaultsData.launchCount);
}

- (void)checkLoginStatus {
  if ([self.defaultsData.isLogin boolValue]) {
//    NSString *userName = self.defaultsData.loginName;
//    NSString *pwd = self.defaultsData.password;
//    [USessionService createSessionWithLoginName:userName password:pwd success:^(NSNumber *userId) {
//      ULog(@"AppContext: Login user--%@", userName);
//    } failure:nil];
//  } else {
//    ULog(@"AppContext: No Login User.");
    }
}

- (void)clearLoginDefault {
  self.defaultsData.isLogin = @(NO);
  self.defaultsData.loginName = nil;
  self.defaultsData.password = nil;
  [DBAgent commit];
}

- (void)terminateOpreations {
  //[UserService logOut];
}

@end
