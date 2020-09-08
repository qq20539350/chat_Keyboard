//
//  OfficialAccountToolbar.h
//  KeyboardForChat

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/4/1.
//  Copyright © 2016年 ruofei. All rights reserved.
//


/**
 *  可以完全定制，控件只是为了演示效果
 */

#import <UIKit/UIKit.h>
#import "BottomItemModel.h"
#import "BottomItemView.h"

typedef void (^SWITCHACTION) (void);

@protocol OfficialAccountToolbarDelegate<NSObject>

/**
 * themeIndex>= 1; subItem>= 1; 若为零，即无效值
 */
- (void)didSelectThemeItem:(int)themeIndex subItem:(int)subItem;

@end

@interface OfficialAccountToolbar : UIView<BottomItemViewDelegate>

@property(nonatomic, assign) id<OfficialAccountToolbarDelegate> delegate;
@property (nonatomic, copy) SWITCHACTION switchAction;
- (void)loadBottomThemeItems:(NSArray<BottomItemModel *>*)themeItems;

@end
