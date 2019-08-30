//
//  UIViewController+Test.m
//  响应
//
//  Created by open-roc on 2018/12/7.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import "UIViewController+Test.h"



static char imageURLKey;
@implementation UIViewController (Test)

- (void)testLog{
    NSLog(@"我是分类拓展方法");
}


//这个函数先根据对象地址在 AssociationsHashMap 中查找其对应的 ObjectAssociationMap 对象，如果能找到则进一步根据 key 在 ObjectAssociationMap 对象中查找这个 key 所对应的关联结构 ObjcAssociation ，如果能找到则返回 ObjcAssociation 对象的 value 值，否则返回 nil;
//objc_getAssociatedObject有两个参数，第一个参数为从该object中获取关联对象，第二个参数为想要获取关联对象的key;

- (void)setUrl:(NSString *)url
{
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)url
{
    return objc_getAssociatedObject(self, &imageURLKey);
}

@end
