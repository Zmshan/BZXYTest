//
//  SearchTagListView.h
//  响应
//
//  Created by  open-roc on 2017/12/9.
//  Copyright © 2017年 kuaixun100. All rights reserved.
//

#import <UIKit/UIKit.h>

#if defined(__LP64__) && __LP64__
# define CGFLOAT_TYPE double
# define CGFLOAT_IS_DOUBLE 1
# define CGFLOAT_MIN DBL_MIN
# define CGFLOAT_MAX DBL_MAX
#else
# define CGFLOAT_TYPE float
# define CGFLOAT_IS_DOUBLE 0
# define CGFLOAT_MIN FLT_MIN
# define CGFLOAT_MAX FLT_MAX
#endif

#define GCBlockInvoke(block, ...)   \
do {                            \
if (block) {                \
block(__VA_ARGS__);    \
}                           \
} while(0)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define _weak(x)    __weak typeof(x) weak##x = x
#define _strong(x)  typeof(weak##x) x = weak##x
#define _strong_check(x, ...) typeof(weak##x) x = weak##x; if (!weak##x) return __VA_ARGS__;

#define RGB(r, g, b)        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define k_COLOR_E7E7E7          RGB(221, 225, 224)
#define k_COLOR_949494          RGB(142, 151, 146)


typedef void(^TagListViewOnTagClick)(NSUInteger index, NSString *tag);

/// 标签样式风格
typedef NS_ENUM(NSInteger, TagListViewStyle) {
    /// 标准大小
    TagListViewStyleStd,
    /// 大的
    TagListViewStyleBig,
};



@interface SearchTagListView : UIView
+ (CGFloat)heightWithTags:(NSArray<NSString *> *)tags style:(TagListViewStyle)style;

/// 标签整体内容上间隔。默认0
@property (nonatomic, assign) CGFloat contentTopMargin;

/// 标签数据
@property (nonatomic, copy) NSArray<NSString *> *tags;

- (instancetype)initWithStyle:(TagListViewStyle)style;

/// 用户点击了某个标签
- (void)onTagClick:(TagListViewOnTagClick)block;


@end
