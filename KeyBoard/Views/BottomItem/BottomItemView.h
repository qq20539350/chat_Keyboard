//
//  BottomItemView.h
//  eyutong
//
//  Created by YT_lwf on 2018/8/6.
//  Copyright © 2018年 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomItemModel.h"
#import "CMPopTipView.h"

@protocol BottomItemViewDelegate<NSObject>
/**
 * themeIndex>= 1; subItem>= 1; 若为零，即无效值
 */
- (void)didSelectThemeItem:(int)themeIndex subItem:(int)subItem;

@end

@interface BottomItemView : UIView<CMPopTipViewDelegate>

@property(nonatomic, assign) id<BottomItemViewDelegate> delegate;
- (void)loadBottomThemeItems:(NSArray<BottomItemModel *>*)themeItems;

@end
