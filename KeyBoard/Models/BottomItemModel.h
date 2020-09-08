//
//  BottomItemModel.h
//  eyutong
//
//  Created by YT_lwf on 2018/8/6.
//  Copyright © 2018年 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BottomSubItemModel : NSObject

@property(nonatomic, copy) NSString *titleString;
@property(nonatomic, strong) NSDictionary *paramDict;

@end

@interface BottomItemModel : NSObject

@property(nonatomic, copy) NSString *titleString;
@property(nonatomic, assign) float maxWidth;
@property(nonatomic, strong) NSDictionary *paramDict;
@property(nonatomic, strong) NSArray<BottomSubItemModel *> *subItemModelArray;

@end
