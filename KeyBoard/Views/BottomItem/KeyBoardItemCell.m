//
//  KeyBoardItemCell.m
//  eyutong
//
//  Created by YT_lwf on 2018/8/6.
//  Copyright © 2018年 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import "KeyBoardItemCell.h"
#import "KeyBoardBottomItemHeader.h"

@interface KeyBoardItemCell()

@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UIView *lineView;

@end

@implementation KeyBoardItemCell

#pragma mark --- Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifie]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;       
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentLabel];
        [self addSubview:self.lineView];
    }
    return self;
}

#pragma mark --- Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentLabel.frame = CGRectMake(8, 0, CGRectGetWidth(self.frame) - 16 , CGRectGetHeight(self.frame));
    self.lineView.frame = CGRectMake(8, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame) - 16, 0.5);
}

#pragma mark --- Public

- (void)fillData:(NSString *)contentString{
    self.lineView.hidden = NO;
    self.contentLabel.text = contentString;
}

- (void)isHideLine:(BOOL)isHide {
    self.lineView.hidden = isHide;
}

#pragma mark --- Get

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:itemContentTextFont];
        _contentLabel.textColor = UIColorHEX(0x666666, 1);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor =  UIColorHEX(0x999999, 1);
    }
    return _lineView;
}

@end
