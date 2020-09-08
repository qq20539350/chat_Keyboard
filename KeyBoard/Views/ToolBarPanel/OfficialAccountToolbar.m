//
//  OfficialAccountToolbar.m
//  KeyboardForChat

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/4/1.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "OfficialAccountToolbar.h"
#import "ChatKeyBoardMacroDefine.h"

@implementation OfficialAccountToolbar
{
    UIButton *_switchBtn;
    BottomItemView *_itemView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kChatKeyBoardColor;
        _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchBtn setImage:[UIImage imageNamed:@"switchUp"] forState:UIControlStateNormal];
        [_switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
        _switchBtn.frame = CGRectMake(0, 0, 44, 49);
        [self addSubview:_switchBtn];
        
        _itemView = [[BottomItemView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_switchBtn.frame), 0, kScreenWidth -CGRectGetMaxX(_switchBtn.frame), 49)];
        _itemView.delegate = self;
        [self addSubview:_itemView];
    }
    return self;
}

#pragma mark --- BottomItemViewDelegate

- (void)didSelectThemeItem:(int)themeIndex subItem:(int)subItem{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectThemeItem:subItem:)]) {
        [self.delegate didSelectThemeItem:themeIndex subItem:subItem];
    }
}

- (void)loadBottomThemeItems:(NSArray<BottomItemModel *>*)themeItems {
    [_itemView loadBottomThemeItems:themeItems];
}

- (void)switchAction:(UIButton *)btn
{
    if (self.switchAction) {
        self.switchAction();
    }
}

@end











