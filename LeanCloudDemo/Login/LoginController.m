//
//  LoginController.m
//  RCloudDemo
//
//  Created by Mac on 15-6-3.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "LoginController.h"
#import "TextFieldValidate.h"
#import "LCECommon.h"
#import "CDUserFactory.h"
#import "LCEChatListVC.h"
#import "AppDelegate.h"

@interface LoginController ()<UITextFieldDelegate>

@property (nonatomic, assign) CGSize frameSize;

@property (nonatomic, assign) CGFloat borderX;

@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UILabel *passwordLabel;

@property (nonatomic, strong) UILabel *errorMsgLabel;

@property (nonatomic, strong) UITextField *userNameTF;

@property (nonatomic, strong) UITextField *passwordTF;

@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation LoginController
@synthesize frameSize,borderX,bgImgView,userNameLabel,passwordLabel,errorMsgLabel,userNameTF,passwordTF,loginBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *whiteColor = [UIColor whiteColor];
    self.view.backgroundColor = whiteColor;
    
    UIImageView *titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 30)];
    titleImgView.image = [UIImage imageNamed:@"ihaveu_logo"];
    self.navigationItem.titleView = titleImgView;
    
    frameSize = self.view.bounds.size;
    borderX = frameSize.width*12/100;

    bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:bgImgView];
    [bgImgView setImage:[UIImage imageNamed:@"login_background"]];
    
    userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(borderX, 150, 55, 40)];
    [self.view addSubview:userNameLabel];
    [userNameLabel setText:@"账号:"];
    [userNameLabel setTextColor:whiteColor];
    
    passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(borderX, 210, 55, 40)];
    [self.view addSubview:passwordLabel];
    [passwordLabel setText:@"密码:"];
    [passwordLabel setTextColor:whiteColor];
    
    userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(borderX + 55, 145, 200, 50)];
    [self.view addSubview:userNameTF];
    [userNameTF setTextColor:whiteColor];
    [userNameTF setPlaceholder:@"请直接输入AppID登录"];
    [userNameTF setValue:whiteColor forKeyPath:@"_placeholderLabel.textColor"];
    [userNameTF setClearButtonMode:UITextFieldViewModeAlways];
    userNameTF.delegate = self;
    
    UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(borderX, userNameTF.frame.origin.y + 50, frameSize.width - 2*borderX, 1)];
    [self.view addSubview:upLine];
    [upLine setBackgroundColor:whiteColor];
    
    passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(borderX + 55, 205, 200, 50)];
    [self.view addSubview:passwordTF];
    [passwordTF setTextColor:whiteColor];
    passwordTF.delegate = self;
    
    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(borderX, passwordTF.frame.origin.y + 50, frameSize.width - 2*borderX, 1)];
    [self.view addSubview:downLine];
    [downLine setBackgroundColor:whiteColor];
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(borderX, 265, (frameSize.width -  2*borderX), 50);
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:22.0]];
    [loginBtn setBackgroundColor:[UIColor orangeColor]];
    [loginBtn addTarget:self action:@selector(actionLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    errorMsgLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    errorMsgLabel.text = @"";
    errorMsgLabel.font = [UIFont fontWithName:@"Heiti SC" size:12.0];
    errorMsgLabel.translatesAutoresizingMaskIntoConstraints = NO;
    errorMsgLabel.textColor = [UIColor colorWithRed:204.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1];
    [self.view addSubview:errorMsgLabel];
}

- (void)actionLogin:(id)sender{
    NSString *userNameStr = userNameTF.text; // @"425035106@qq.com";
    NSString *passwordStr = @"Leancloud123";// passwordTF.text;
    [self login:userNameStr password:passwordStr];
}

- (void)login:(NSString *)userName password:(NSString *)password{
    NSString *selfId = userName;
    if ([self validateUserName:selfId userPwd:password]) {
        CDIM *im = [CDIM sharedInstance];
        [im openWithClientId:selfId callback: ^(BOOL succeeded, NSError *error) {
            if (error) {
                DLog(@"%@", error);
            }
            else {
                UITabBarController *tabbarController = [[UITabBarController alloc] init];
                LCEChatListVC *chatListVC = [[LCEChatListVC alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatListVC];
                [tabbarController addChildViewController:nav];
                AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
                appDelegate.window.rootViewController = tabbarController;
            }
        }];
    }
}

//验证用户信息格式
- (BOOL)validateUserName:(NSString*)userName
                 userPwd:(NSString*)userPwd
{
    NSString* alertMessage = nil;
    if (userName.length == 0) {
        alertMessage = @"用户名不能为空!";
    }
    else if (userPwd.length == 0) {
        alertMessage = @"密码不能为空!";
    }
    
    if (alertMessage) {
        errorMsgLabel.text = alertMessage;
        return NO;
    }
    
    return YES;
//    [TextFieldValidate validateEmail:userName]
//    && [TextFieldValidate validatePassword:userPwd];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //[userNameTF resignFirstResponder];
    [passwordTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
