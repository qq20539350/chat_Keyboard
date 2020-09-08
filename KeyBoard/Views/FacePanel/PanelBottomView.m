//
//  PanelBottomView.m
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/31.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "PanelBottomView.h"
#import "FaceThemeModel.h"
#import "ChatKeyBoardMacroDefine.h"

@implementation PanelBottomView
{
    UIButton        *_addBtn;
    UIScrollView    *_facePickerView;
    UIButton        *_sendBtn;
    UIButton        *_setBtn;
    UIView *_selectedBgView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightTextColor];
        _selectedBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kFacePanelBottomToolBarHeight, kFacePanelBottomToolBarHeight)];
        _selectedBgView.backgroundColor = UIColorHEX(0x007AFF,1);

        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
//    _addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    _addBtn.frame = CGRectMake(0, 0, kFacePanelBottomToolBarHeight, kFacePanelBottomToolBarHeight);
//    [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
//    [_addBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
//    [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_addBtn];
    
    _facePickerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-2*kFacePanelBottomToolBarHeight, kFacePanelBottomToolBarHeight)];
    [self addSubview:_facePickerView];
    [_facePickerView addSubview:_selectedBgView];

    _sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _sendBtn.frame = CGRectMake(kScreenWidth-kFacePanelBottomToolBarHeight, 0, kFacePanelBottomToolBarHeight, kFacePanelBottomToolBarHeight);
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    //[_sendBtn setTitleColor:HEX(0x076ed5) forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendBtn];
    
    
//    _setBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    _setBtn.frame = _sendBtn.frame;
//    [_setBtn setTitle:@"设置" forState:UIControlStateNormal];
//    [_setBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
//    _setBtn.hidden = YES;
//    [_setBtn addTarget:self action:@selector(setBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_setBtn];
}

- (void)loadfaceThemePickerSource:(NSArray *)pickerSource
{
    for (int i = 0; i<pickerSource.count; i++) {
        FaceThemeModel *themeM = pickerSource[i];
        FaceModel *fm = [themeM.faceModels firstObject];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = i+100;
        [btn setTitle:fm.faceIcon forState:UIControlStateNormal];
        [btn setTitle:fm.faceIcon forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
        [btn addTarget:self action:@selector(subjectPicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(i*kFacePanelBottomToolBarHeight, 0, kFacePanelBottomToolBarHeight, kFacePanelBottomToolBarHeight);
        [_facePickerView addSubview:btn];
        
        if (i == pickerSource.count - 1) {
             NSInteger pages = CGRectGetMaxX(btn.frame) / CGRectGetWidth(_facePickerView.frame) + 1;
            _facePickerView.contentSize = CGSizeMake(pages*CGRectGetWidth(_facePickerView.frame), 0);
        }
    }
}

- (void)normalSelected:(NSInteger)selectedInde{
    for (UIView * sView in _facePickerView.subviews) {
        if ([sView isKindOfClass:[UIButton class]] && sView.tag == selectedInde + 100) {
            UIButton * btn = (UIButton * )sView;
            _selectedBgView.left = btn.left;
        }
    }
}

- (void)changeFaceSubjectIndex:(NSInteger)subjectIndex
{
//    [_facePickerView setContentOffset:CGPointMake(subjectIndex*kFacePanelBottomToolBarHeight, 0) animated:YES];
    for (UIView *sub in _facePickerView.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)sub;
            if (btn.tag == subjectIndex) {
                _selectedBgView.left = btn.left;
            }
        }
    }
}

#pragma mark -- 点击事件

- (void)addBtnClick:(UIButton *)sender
{
    if (self.addAction) {
        self.addAction();
    }
}

- (void)sendBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(panelBottomViewSendAction:)]) {
        [self.delegate panelBottomViewSendAction:self];
    }
}

- (void)setBtnClick:(UIButton *)sender
{
    if (self.setAction) {
        self.setAction();
    }
}

- (void)subjectPicBtnClick:(UIButton *)sender
{
    for (UIView *sub in _facePickerView.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)sub;
            if (sender == btn) {
                _selectedBgView.left = btn.left;
            }
        }
    }
    
//    if (sender.tag-100 > 0) {
//        _setBtn.hidden = NO;
//        _sendBtn.hidden = YES;
//    }else {
//        _setBtn.hidden = YES;
//        _sendBtn.hidden = NO;
//    }
    _setBtn.hidden = YES;
    _sendBtn.hidden = NO;
    if ([self.delegate respondsToSelector:@selector(panelBottomView:didPickerFaceSubjectIndex:)]) {
        [self.delegate panelBottomView:self didPickerFaceSubjectIndex:sender.tag-100];
    }
}


@end
