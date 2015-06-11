//
//  LCEChatRoomVC.m
//  LeanChatExample
//
//  Created by lzw on 15/4/7.
//  Copyright (c) 2015年 avoscloud. All rights reserved.
//

#import "LCEChatRoomVC.h"
#import "UProductService.h"
#import "UComUtil.h"
#import "UProductDetailController.h"
#import "UProductDetailViewModel.h"

@interface LCEChatRoomVC ()
{
   UIImageView *sendImgView;
   UProductDetailModel *productInfoModel;
}
@end

@implementation LCEChatRoomVC

- (instancetype)initWithConv:(AVIMConversation *)conv{
    self = [super initWithConv:conv];
    if (self) {
        ;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [NOTIFICATION_CENTER addObserver:self selector:@selector(getProductInfo:) name:LOAD_SINGLE_PRODUCT object:nil];
//    
//    [NOTIFICATION_CENTER addObserver:self selector:@selector(showSingleProductController:) name:SHOW_SINGLEPRODUCT_FROM_MESSAGE object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *_peopleImage = [UIImage imageNamed:@"chat_menu_people"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:_peopleImage style:UIBarButtonItemStyleDone target:self action:@selector(goChatGroupDetail:)];
    self.navigationItem.rightBarButtonItem = item;
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(getProductInfo:) name:LOAD_SINGLE_PRODUCT object:nil];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(showSingleProductController:) name:SHOW_SINGLEPRODUCT_FROM_MESSAGE object:nil];
}

- (void)getProductInfo:(NSNotification *)notification{
    [UProductService getGoodDetailInfo:[[notification userInfo] objectForKey:@"productId"] success:^(UProductDetailModel *detailModel) {
        productInfoModel = detailModel;
        sendImgView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 150, 100, 100)];
                [sendImgView sd_setImageWithURL:[UComUtil imageUrlAppendString:detailModel.major_pic withSize:100] placeholderImage:[UIImage imageNamed:@"chat_menu_people"] options:SDWebImageLowPriority | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [self sendProductImage];
                }];
    } failure:nil];
}

- (void)sendProductImage{
    NSDictionary *productInfo = [NSDictionary dictionaryWithObjectsAndKeys:sendImgView.image,@"productImage",productInfoModel.name,@"productName", nil];
   [NOTIFICATION_CENTER postNotificationName:SEND_PRODUCT_INFO object:self userInfo:productInfo];
}

- (void)showSingleProductController:(NSNotification *)notification{
    UProductDetailViewModel *viewModel = [[UProductDetailViewModel alloc] initWithSummaryProduct:productInfoModel];
    UProductDetailController *detailVC = [[UProductDetailController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)goChatGroupDetail:(id)sender {
    DLog(@"click");
}

- (void)dealloc{
   [NOTIFICATION_CENTER removeObserver:self name:@"singleProduct" object:nil];
   [NOTIFICATION_CENTER removeObserver:self name:SHOW_SINGLEPRODUCT_FROM_MESSAGE object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
