//
//  UProductSizeController.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductSizeController.h"
#import <UIImageView+WebCache.h>
#import "UComUtil.h"

#define BORDER_GAP (SCREEN_WIDTH*5/100)

@implementation UProductSizeController
@synthesize sizeViewModel;

- (instancetype)initWithViewModel:(UBaseViewModel *)viewModel {
  
  self = [super initWithViewModel:viewModel];

  if (self) {
    
     self.sizeViewModel = (UProductSizeViewModel *)viewModel;
  
    [self initialUI];
    
  }
  return self;
}

//初始化视图及数据
-(void)initialUI{

  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
  [titleLabel setTextAlignment:NSTextAlignmentCenter];
  [titleLabel setText:@"尺码说明"];
  self.navigationItem.titleView = titleLabel;
  
  UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  leftBarBtn.frame = CGRectMake(0, 0, 25, 25);
  [leftBarBtn setImage:ImageCache(@"nav_back_normal") forState:UIControlStateNormal];
  [leftBarBtn setImage:ImageCache(@"nav_back_highlight") forState:UIControlStateHighlighted];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
  [leftBarBtn addTarget:self action:@selector(backSuperViewController) forControlEvents:UIControlEventTouchUpInside];
  
   contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
  [self.view addSubview:contentView];
   contentView.delegate = self;
  [contentView setBackgroundColor:[UIColor whiteColor]];
  [contentView setShowsVerticalScrollIndicator:YES];
  [contentView setShowsHorizontalScrollIndicator:NO];
  
  UIColor *cellNormalColor = [UIColor colorWithWhite:0.9 alpha:0.90];
  
  //表格属性名称行数组
  NSArray *tablerowTitleArr = sizeViewModel.measure_propertiesArray;
  
  //表格属性值行数组
  NSArray *tablecolTitleArr = sizeViewModel.measureTableArray;
  
  float tableWidth = SCREEN_WIDTH*0.9;
  
  float tableHeight = ([tablecolTitleArr count] + 2)*36.0;
  
  //单元格宽度
  float cellWidth = (tableWidth - ([tablerowTitleArr count] - 1))/[tablerowTitleArr count];
  //单元格高度
  float cellHeight = 36.0;
  //单元格间距
  float cellGap = 1.0;
  
   tableView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - tableWidth)/2, 15, tableWidth, tableHeight)];
  [contentView addSubview:tableView];
  [tableView setBackgroundColor:[UIColor whiteColor]];
  [tableView setHidden:YES];
  
  //参考尺码静态标签
  UILabel *tableTitleLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cellWidth*2 + cellGap, cellHeight)];
  [tableView addSubview:tableTitleLeftLabel];
  [tableTitleLeftLabel setText:@"参考尺码"];
  [tableTitleLeftLabel setTextAlignment:NSTextAlignmentCenter];
  [tableTitleLeftLabel setTextColor:[UIColor whiteColor]];
  [tableTitleLeftLabel setBackgroundColor:[UIColor colorWithWhite:0.6 alpha:0.70]];
  
  //测量静态标签
  UILabel *tableTitleRightLabel = [[UILabel alloc] initWithFrame:CGRectMake((cellWidth + cellGap)*2, 0, (tableWidth - (cellWidth + cellGap)*2), cellHeight)];
  [tableView addSubview:tableTitleRightLabel];
  [tableTitleRightLabel setText:@"测量（cm）"];
  [tableTitleRightLabel setTextAlignment:NSTextAlignmentCenter];
  [tableTitleRightLabel setTextColor:[UIColor whiteColor]];
  [tableTitleRightLabel setBackgroundColor:[UIColor colorWithWhite:0.6 alpha:0.70]];
  
  if ([tablecolTitleArr count]>0) {
    [tableView setHidden:NO];
  }
  
  //布局排列单元格
  for (int i = 0; i < [tablerowTitleArr count]; i++) {
     UILabel *rowTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*(cellWidth + cellGap), cellHeight + cellGap, cellWidth, cellHeight)];
    [tableView addSubview:rowTitleLabel];
    [rowTitleLabel setText:tablerowTitleArr[i]];
    [rowTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [rowTitleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [rowTitleLabel setTextColor:[UIColor blackColor]];
    [rowTitleLabel setBackgroundColor:cellNormalColor];
    
    for (int j = 0; j < [tablecolTitleArr count]; j++) {
      UILabel *colTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*(cellWidth + cellGap), (j + 2)*(cellHeight + cellGap), cellWidth, cellHeight)];
      [tableView addSubview:colTitleLabel];
      [colTitleLabel setTextAlignment:NSTextAlignmentCenter];
      [colTitleLabel setFont:[UIFont systemFontOfSize:12.0]];
      [colTitleLabel setTextColor:[UIColor blackColor]];
      [colTitleLabel setBackgroundColor:cellNormalColor];
      
       NSArray *valueArray = tablecolTitleArr[j];
      [colTitleLabel setText:valueArray[i]];
    }
  }
  
  NSString *imgUrlStr = sizeViewModel.measure_pic;
  
  if (StringNotEmpty(imgUrlStr)) {
    UIImageView *measurePicView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15 + tableHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [contentView addSubview:measurePicView];
    [measurePicView sd_setImageWithURL:[UComUtil imageUrlAppendString:sizeViewModel.measure_pic withSize:SCREEN_WIDTH] placeholderImage:[UIImage imageNamed:@"loading17_black"]];
    //保证图片比例不变，而且全部显示在ImageView中
    [measurePicView setContentMode:UIViewContentModeScaleToFill];
    
    [contentView setContentSize:CGSizeMake(SCREEN_WIDTH, tableHeight + 15 + SCREEN_HEIGHT + 100)];
  } else {
    [contentView setContentSize:CGSizeMake(SCREEN_WIDTH, tableHeight + 15)];
  }
  
}

-(void)backSuperViewController{
  [self.navigationController popViewControllerAnimated:YES];
}

@end