//
//  BottomItemView.m
//  eyutong
//
//  Created by YT_lwf on 2018/8/6.
//  Copyright © 2018年 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import "BottomItemView.h"
#import "ChatKeyBoardMacroDefine.h"
#import "KeyBoardBottomItemHeader.h"
#import "KeyBoardItemCell.h"

@protocol BottomItemButtonDelegate<NSObject>

@optional
- (void)didSelectedItem:(UIView *)sender;

@end

@interface BottomItemButton : UIView

@property(nonatomic, assign) id<BottomItemButtonDelegate> delegate;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation BottomItemButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectedItem:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)didSelectedItem:(UITapGestureRecognizer *)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedItem:)]) {
        UIView *view = tap.view;
        [self.delegate didSelectedItem:view];
    }
}

- (void)fillData:(NSString *)titleString isShowIcon:(BOOL)isShowIcon{
    self.imageView.hidden = isShowIcon;
    self.titleLabel.text = titleString;
    [self.titleLabel sizeToFit];
    CGFloat padding_h = 0;
    CGFloat padding_img_v = (CGRectGetHeight(self.frame) - CGRectGetHeight(self.imageView.frame)) *0.5;
    CGFloat padding_lable_v = (CGRectGetHeight(self.frame) - CGRectGetHeight(self.titleLabel.frame)) *0.5;
    if (!isShowIcon) {
        padding_h = (CGRectGetWidth(self.frame) - CGRectGetWidth(self.imageView.frame) - 4 - CGRectGetWidth(self.titleLabel.frame)) *0.5;
        self.imageView.frame = CGRectMake(padding_h, padding_img_v, CGRectGetWidth(self.imageView.frame), CGRectGetHeight(self.imageView.frame));
        self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 4, padding_lable_v, CGRectGetWidth(self.titleLabel.frame), CGRectGetHeight(self.titleLabel.frame));
    }else{
        padding_h = (CGRectGetWidth(self.frame) - CGRectGetWidth(self.titleLabel.frame)) *0.5;
        self.imageView.frame = CGRectZero;
        self.titleLabel.frame = CGRectMake(padding_h, padding_lable_v, CGRectGetWidth(self.titleLabel.frame), CGRectGetHeight(self.titleLabel.frame));
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 8)];
        _imageView.image = [UIImage imageNamed:@"Tool_menu"];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = UIColorHEX(0x4A4A4A, 1);;
    }
    return _titleLabel;
}

@end

@interface BottomItemView()<BottomItemButtonDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray<BottomItemModel*> *dataArray;
@property (nonatomic, strong) NSArray<BottomSubItemModel*> *subDataArray;

@property (nonatomic, strong) NSMutableArray *visiblePopTipViews;
@property (nonatomic, strong) UIView *currentPopTipViewTarget;

@end

@implementation BottomItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kChatKeyBoardColor;
    }
    return self;
}

#pragma mark --- InitData

#pragma mark --- Layout

#pragma mark --- Public

- (void)loadBottomThemeItems:(NSArray<BottomItemModel *>*)themeItems {
    if (themeItems && themeItems.count > 0) {
        self.dataArray = themeItems;
        [self addItem:themeItems];
    }
}

#pragma mark --- Private

- (void)addItem:(NSArray<BottomItemModel *>*)items {
    int count = items.count;
    CGFloat itemW = (CGRectGetWidth(self.frame))/count;
    CGFloat itemH = 49;
    for (int i = 0; i < count; i++) {
        BottomItemModel *item = [items objectAtIndex:i];
        NSArray<BottomSubItemModel *> *subItemArray = item.subItemModelArray;
        BOOL isShowIcon = YES;
        if (subItemArray && subItemArray.count > 0) {
            isShowIcon = NO;
        }
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(itemW * i, 0, itemW, itemH)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 8, 0.5, itemH - 8 * 2)];
        leftLine.backgroundColor = [UIColor lightGrayColor];
        [backView addSubview:leftLine];
        
        BottomItemButton *itemButton = [[BottomItemButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftLine.frame), 0, itemW - 0.5, itemH)];
        itemButton.delegate = self;
        [itemButton fillData:item.titleString isShowIcon:isShowIcon];
        [backView addSubview:itemButton];
        itemButton.tag = Item_Tag + i;
    }
}

- (void)dismissAllPopTipViews {
    while ([self.visiblePopTipViews count] > 0) {
        CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObjectAtIndex:0];
    }
}

- (CMPopTipView *)createSubItem:(BottomItemModel *)themItem {
    float maxWidth = themItem.maxWidth;
    NSArray * subItemAray = themItem.subItemModelArray;
    self.subDataArray = subItemAray;
    float maxHeight = subItemAray.count * subItemHeight;
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, maxHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.rowHeight = subItemHeight;
    [tableView registerClass:KeyBoardItemCell.class forCellReuseIdentifier:@"KeyBoardItemCell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView reloadData];
    
    CMPopTipView *popTipView =  [[CMPopTipView alloc] initWithCustomView:tableView];
    popTipView.animation = arc4random() % 2;
    popTipView.has3DStyle = NO;
    popTipView.dismissTapAnywhere = YES;
    popTipView.cornerRadius = 4;
    popTipView.hasShadow = NO;
    popTipView.borderWidth = 0.5;
    popTipView.borderColor = [UIColor lightGrayColor];
    popTipView.backgroundColor = [UIColor whiteColor];
    return popTipView;
}

#pragma mark --- BottomItemButtonDelegate

- (void)didSelectedItem:(UIView *)sender {
    [self dismissAllPopTipViews];
    int index = sender.tag - Item_Tag;
    if (index >= self.dataArray.count) {
        return;
    }
    if (sender == self.currentPopTipViewTarget) {
        self.currentPopTipViewTarget = nil;
    }else{
        BottomItemModel *itemModel = [self.dataArray objectAtIndex:index];
        if (itemModel.subItemModelArray && itemModel.subItemModelArray.count > 0) {
            CMPopTipView * popTipView = [self createSubItem:itemModel];
            [popTipView presentPointingAtView:sender inView:self.superview.superview.superview animated:YES];
            [self.visiblePopTipViews addObject:popTipView];
            self.currentPopTipViewTarget = sender;
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectThemeItem:subItem:)]) {
                [self.delegate didSelectThemeItem:index + 1 subItem:0];
            }
        }
    }
}

#pragma mark - CMPopTipViewDelegate

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
}

#pragma mark - UITableViewDataSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BottomSubItemModel *subItem = self.subDataArray[indexPath.row];
    KeyBoardItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"KeyBoardItemCell" forIndexPath:indexPath];
    [cell fillData:subItem.titleString];
    if (indexPath.row == self.subDataArray.count-1) {
        [cell isHideLine:YES];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CMPopTipView * tipView = (CMPopTipView *)tableView.superview;
    [tipView dismissAnimated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectThemeItem:subItem:)]) {
        [self.delegate didSelectThemeItem:self.currentPopTipViewTarget.tag - Item_Tag + 1 subItem:indexPath.row + 1];
    }
}

#pragma mark --- Get

- (NSMutableArray *)visiblePopTipViews{
    if (!_visiblePopTipViews) {
        _visiblePopTipViews = [NSMutableArray array];
    }
    return _visiblePopTipViews;
}

@end
















