//
//  KeyBoardItemCell.h
//  eyutong
//
//  Created by YT_lwf on 2018/8/6.
//  Copyright © 2018年 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyBoardItemCell : UITableViewCell

- (void)fillData:(NSString *)contentString;
- (void)isHideLine:(BOOL)isHide;

@end
