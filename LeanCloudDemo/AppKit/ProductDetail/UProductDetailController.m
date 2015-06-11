//
//  UProductDetailController.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductDetailController.h"
#import "UProductBannerView.h"
#import "UProductBuyBar.h"
#import "UProductContentView.h"
#import "UProductContentBuilder.h"
#import "UProductSizeViewModel.h"
#import "UProductSizeController.h"
//#import "UShopCartController.h"

#define REFER_NORMAL_HEIGHT (130)

typedef NS_ENUM(NSInteger, ProductState) {
  ProductStateSummary = 1,
  ProductStateComplete
};

@interface UProductDetailController () {
  UProductBannerView      *_bannerView;
  UProductBuyBar          *_buyBar;
  UProductContentView     *_contentView;
  UProductContentBuilder  *_contentBuilder;
}
@property (nonatomic, strong) UProductDetailViewModel *detailViewModel;
@end

@implementation UProductDetailController
@synthesize detailViewModel;

- (instancetype)initWithViewModel:(UBaseViewModel *)viewModel {
  self = [super initWithViewModel:viewModel];
  if (self) {
    self.detailViewModel = (UProductDetailViewModel *)viewModel;
    [self hideTabbar];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"商品详情";
  //初始化界面
  [self initialUI];
  //绑定View与ViewModel
  [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)initialUI {
  //设置navi
  [self configNavigation];
  //图片浏览视图
  [self setupImageBrowser];
  //商品详情滚动视图
  [self setupProductContent];
  //购买价格栏
  [self setupBuyBar];
}

- (void)configNavigation {
  UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  shareBtn.frame = CGRectMake(0, 0, 25, 25);
  [shareBtn setImage:ImageCache(@"nav_share_normal") forState:UIControlStateNormal];
  [shareBtn setImage:ImageCache(@"nav_share_highlight") forState:UIControlStateHighlighted];
  
  UIButton *favorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  favorBtn.frame = CGRectMake(0, 0, 25, 25);
  [favorBtn setImage:ImageCache(@"nav_favor_normal") forState:UIControlStateNormal];
  
  UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
  UIBarButtonItem *favorItem = [[UIBarButtonItem alloc] initWithCustomView:favorBtn];
  self.navigationItem.rightBarButtonItems = @[shareItem, favorItem];
  
  [shareBtn addOnClickEventHandler:^(id sender) {
    ULog(@"分享");
  }];
  
//  [favorBtn addOnClickEventHandler:^(id sender) {
//    if (self.detailViewModel.isFavorite) {
//      [self.detailViewModel cancelFavoriteCurrentProductWithSuccess:^{
//        [self.view makeToast:@"取消收藏成功" duration:.3 position:@"center"];
//      } failure:^(NSError *error) {
//        ULog(@"%@",error);
//        [self.view makeToast:@"取消收藏失败" duration:.3 position:@"center"];
//      }];
//    } else {
//      if (UserService.login) {
//        [self.detailViewModel favoriteCurrentProductWithSuccess:^{
//          [self.view makeToast:@"收藏成功" duration:.3 position:@"center"];
//        } failure:^(NSError *error) {
//          [self.view makeToast:@"收藏失败" duration:.3 position:@"center"];
//        }];
//      } else {
//        [PageManager showLoginController];
//      }
//    }
//  }];
  
  [self.KVOController observe:self.detailViewModel
                      keyPath:@keypath(self.detailViewModel, isFavorite)
                      options:NSKeyValueObservingOptionNew
                        block:^(id observer, id object, NSDictionary *change) {
                          BOOL isFavor = [change[NSKeyValueChangeNewKey] boolValue];
                          if (isFavor) {
                            [favorBtn setImage:ImageCache(@"nav_favor_highlight") forState:UIControlStateNormal];
                          } else {
                            [favorBtn setImage:ImageCache(@"nav_favor_normal") forState:UIControlStateNormal];
                          }
                        }];
  
  [self showNaviBackButton];
}

//商品视频图片轮换区域
- (void)setupImageBrowser {
  _bannerView = [[UProductBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT - BUY_BAR_HEIGHT - REFER_NORMAL_HEIGHT)];
  [self.view addSubview:_bannerView];
  
  [self registerConflictGestureScroll:_bannerView->imgScrollView];
}

- (void)setupProductContent {  
  _contentView = [[UProductContentView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-BUY_BAR_HEIGHT-REFER_NORMAL_HEIGHT, SCREEN_WIDTH, REFER_NORMAL_HEIGHT)];
  [self.view addSubview:_contentView];
  
  _contentBuilder = [[UProductContentBuilder alloc] init];
  _contentBuilder.contentView = _contentView;
  _contentBuilder.viewModel = detailViewModel;

  [_contentView frameShouldChangeCallback:^{
    [UIView animateWithDuration:0.3 animations:^{
      switch (_contentView.state) {
        case ContentStateCard:
          _contentView.frame = CGRectMake(0, VIEW_HEIGHT-BUY_BAR_HEIGHT-_contentView.expectHeight, SCREEN_WIDTH, _contentView.frame.size.height);
          break;
        case ContentStateAllowInteraction:
          _contentView.frame = CGRectMake(0, VIEW_HEIGHT-BUY_BAR_HEIGHT-REFER_NORMAL_HEIGHT, _contentView.frame.size.width, _contentView.frame.size.height);
          break;
        case ContentStateWholePage:
          _contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _contentView.frame.size.height);
          break;
        default:
          break;
       }
    }];
  }];
  
  //尺码说明回调
  [_contentView shouldShowSizePageCallback:^{
    UProductSizeViewModel *sizeViewModel = [[UProductSizeViewModel alloc] initWithDetailProduct:detailViewModel.detailProduct];
    UProductSizeController *sizeVC = [[UProductSizeController alloc] initWithViewModel:sizeViewModel];
    [self.naviController pushViewController:sizeVC animated:YES];
  }];
  
  [_contentView.contentScroll.similarView didSelectItemCallback:^(UProductSummaryModel *product) {
    ULog(@"选择了这个商品 %@", product);
  }];
  
  [_contentView.cardView didSelectColorModelCallback:^(id colorProduct) {
    ULog(@"切换到这个颜色模型:%@", colorProduct);
  }];
  
  [_contentView.cardView didSelectSizeCallback:^(NSString *sizeText) {
    self.detailViewModel.detailProduct.select_measure = sizeText;
    _buyBar.barState = BuyBarStateBuy;
  }];
  
  [self registerConflictGestureScroll:_contentView.contentScroll];
}

- (void)setupBuyBar {
  _buyBar = [UProductBuyBar buyBar];
  _buyBar.frame = CGRectMake(0, SCREEN_HEIGHT - BUY_BAR_HEIGHT, SCREEN_WIDTH, BUY_BAR_HEIGHT);
  [self.view addSubview:_buyBar];
  
  @weakify(self);
  [_buyBar setPurchaseClickCallback:^{
    @strongify(self);
//    if (!UserService.login) {
//      [PageManager showLoginController];
//      return;
//    }
    
    if (self->_buyBar.barState == BuyBarStateBuy) {
      NSString *errorMsg = nil;
      self->_buyBar.purchaseButton.enabled = NO;
      [self.detailViewModel submitToCartWithSuccess:^{
        [self.view makeToast:@"成功添加到购物车" duration:TOAST_DURATION position:@"center"];
        self->_buyBar.barState = BuyBarStateClear;
        self->_buyBar.purchaseButton.enabled = YES;
      } failure:^(NSError *error) {
        if (errorMsg) {
          [self.view makeToast:errorMsg duration:TOAST_DURATION position:@"center"];
          self->_buyBar.purchaseButton.enabled = YES;
        }
      } failureMessage:&errorMsg];
      
      if (errorMsg) {
        [self.view makeToast:errorMsg duration:TOAST_DURATION position:@"center"];
        self->_buyBar.purchaseButton.enabled = YES;
      }
    } else {
//      UShopCartViewModel *cartViewModel = [[UShopCartViewModel alloc] initWithCartSource:CartSourceProductDetail];
//      UShopCartController *cartVC = [[UShopCartController alloc] initWithViewModel:cartViewModel];
//      UBaseNavigationController *navi = [[UBaseNavigationController alloc] initWithRootViewController:cartVC];
//      [self presentViewController:navi animated:YES completion:^{
//        self->_buyBar.barState = BuyBarStateBuy;
//      }];
    }
  }];
}

- (void)bindViewModel {
  [self showProductInfomationWithState:ProductStateSummary];
  
  [self.detailViewModel fetchCompleteProductInfomationWithSuccess:^{
    [self showProductInfomationWithState:ProductStateComplete];
    _contentView.state = ContentStateAllowInteraction;
  } failure:^{
    
  }];
}

- (void)showProductInfomationWithState:(ProductState)state {
  //购买栏区域设置数据
  _buyBar.priceLabel.text = detailViewModel.priceText;
  if (detailViewModel.discountText != nil) {
    _buyBar.discountLabel.text = detailViewModel.discountText;
  } else {
    _buyBar.discountLabel.text = detailViewModel.brandName;
  }
  
  switch (state) {
    case ProductStateSummary: {
      //内容视图设置
      [_contentBuilder buildSummary];
      break;
    }
    case ProductStateComplete: {
      //轮换区域设置数据
      _bannerView.productImagesArray = detailViewModel.productImages;
      _bannerView.productVideoArray = detailViewModel.productVideo;
      if(detailViewModel.productImages){
        [_bannerView setBannerData];
      }
      
      //内容视图设置
      [_contentBuilder buildComplete];
      break;
    }
    default:
      break;
  }
}

@end
