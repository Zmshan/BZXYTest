//
//  SearchTagListView.m
//  响应
//
//  Created by  open-roc on 2017/12/9.
//  Copyright © 2017年 kuaixun100. All rights reserved.
//

#import "SearchTagListView.h"
@interface SearchTagListView ()
@property (nonatomic, strong) NSMutableArray<UIButton *> *tagButtonList;

@property (nonatomic, assign) TagListViewStyle style;
@property (nonatomic, copy) TagListViewOnTagClick onTagClickBlock;
@end

static CGFloat const kContentLeftRightMargin = 10;
static CGFloat const kTagHeight_std = 25;
static CGFloat const kTagHeight_big = 30;
static CGFloat const kTagSpacing = 15;
static CGFloat const kButtonTitleLeftRightMargin_std = 10;
static CGFloat const kButtonTitleLeftRightMargin_big = 8;

#define kTagFont_std     [UIFont systemFontOfSize:11]
#define kTagFont_big     [UIFont systemFontOfSize:14]
@implementation SearchTagListView
/**
 *  计算标签视图需要的高度
 *
 *  @param tags          标签列表
 *  @param tagItemHandle 处理回调，通知外面这个Tag的显示信息
 *
 *  @return Tags在UI上的高度。
 */
+ (CGFloat)_heightWithTags:(NSArray<NSString *> *)tags style:(TagListViewStyle)style tagItemHandle:(void(^)(NSUInteger index, NSString *tagName, CGSize tagSize, BOOL needWrap))tagItemHandle {
    
    __block CGFloat tagsHeight = 0;
    if (tags && (tags.count > 0)) {
        UIFont *font = (style == TagListViewStyleStd ? kTagFont_std : kTagFont_big);
        CGFloat titleLeftRightMargin = (style == TagListViewStyleStd ? kButtonTitleLeftRightMargin_std : kButtonTitleLeftRightMargin_big);
        CGFloat tagHeight = (style == TagListViewStyleStd ? kTagHeight_std : kTagHeight_big);
        tagsHeight += tagHeight;
        
        CGFloat tagsContentWdith = SCREEN_WIDTH - kContentLeftRightMargin * 2;
        __block CGFloat currentRowWidth = tagsContentWdith;
        [tags enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat tagWidth = [obj boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size.width + titleLeftRightMargin * 2 + 3;
            BOOL needWrap = NO;
            if (tagWidth > currentRowWidth && currentRowWidth != tagsContentWdith) {
                // 换行
                tagsHeight += kTagSpacing + tagHeight;
                currentRowWidth = tagsContentWdith;
                needWrap = YES;
            }
            GCBlockInvoke(tagItemHandle, idx, obj, CGSizeMake(MIN(tagWidth, tagsContentWdith), tagHeight), needWrap);
            currentRowWidth -= (tagWidth + kTagSpacing);
        }];
    }
    return tagsHeight;
}

+ (CGFloat)heightWithTags:(NSArray<NSString *> *)tags style:(TagListViewStyle)style {
    return [self _heightWithTags:tags style:style tagItemHandle:nil];
}

- (instancetype)init {
    if (self = [super init]) {
        self.contentTopMargin = 0;
        self.tagButtonList = [NSMutableArray array];
        self.style = TagListViewStyleStd;
    }
    return self;
}

- (instancetype)initWithStyle:(TagListViewStyle)style {
    if (self = [super init]) {
        self.contentTopMargin = 0;
        self.tagButtonList = [NSMutableArray array];
        self.style = style;
    }
    return self;
}

#pragma mark - public methods

- (void)setTags:(NSArray<NSString *> *)tags {
    _tags = [tags copy];
    [self _reloadButtonList];
}

- (void)onTagClick:(TagListViewOnTagClick)block {
    self.onTagClickBlock = block;
}

#pragma mark - private methods

- (UIButton *)_createButtonWithTagName:(NSString *)tagName {
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = (self.style == TagListViewStyleStd ? kTagFont_std : kTagFont_big);
    button.backgroundColor = k_COLOR_E7E7E7;
    CGFloat titleLeftRightMargin = (self.style == TagListViewStyleStd ? kButtonTitleLeftRightMargin_std : kButtonTitleLeftRightMargin_big);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, titleLeftRightMargin, 0, titleLeftRightMargin);
    button.layer.cornerRadius = (self.style == TagListViewStyleStd ? kTagHeight_std : kTagHeight_big) * 0.5;
    button.layer.borderWidth = 0;
    [button setTitle:tagName forState:UIControlStateNormal];
    [button setTitleColor:k_COLOR_949494 forState:UIControlStateNormal];
//    _weak(self);
//    [button addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
//
//    }];
//
    [button addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)btnclick:(UIButton *)sender{
//    _strong_check(self);
//    GCBlockInvoke(self.onTagClickBlock, control.tag, [(UIButton *)control titleForState:UIControlStateNormal]);
    
    
}
- (void)_reloadButtonList {
    [self.tagButtonList enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.tagButtonList removeAllObjects];
    
    __block UIView *prevView = nil;
    [SearchTagListView _heightWithTags:self.tags style:self.style tagItemHandle:^(NSUInteger index, NSString *tagName, CGSize tagSize, BOOL needWrap) {
        UIButton *btn = [self _createButtonWithTagName:tagName];
        [self addSubview:btn];
        [self.tagButtonList addObject:btn];
        
        UIButton *button = self.tagButtonList[index];
//        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
//            if (prevView == nil) {
//                make.left.equalTo(self).offset(kContentLeftRightMargin);
//                make.top.equalTo(self).offset(self.contentTopMargin);
//            }
//            else if (needWrap) {
//                make.left.equalTo(self).offset(kContentLeftRightMargin);
//                make.top.equalTo(prevView.mas_bottom).offset(kTagSpacing);
//            }
//            else {
//                make.left.equalTo(prevView.mas_right).offset(kTagSpacing);
//                make.top.equalTo(prevView);
//            }
//            make.size.mas_equalTo(tagSize);
//        }];
        prevView = button;
    }];
}



@end
