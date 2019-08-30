//
//  ActivityShareViewController.m
//  响应
//
//  Created by open-roc on 2019/6/11.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "ActivityShareViewController.h"
#import <Social/Social.h>
#import "CustomActivity.h"
@interface ActivityShareViewController ()

@end

@implementation ActivityShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:[self creatBtnWithY:100 Title:@"分享"]];
}
- (void)socialTypeShare{
    // 创建 分享的控制器
    //    NSString *socialType = @"com.tencent.xin.sharetimeline";
    
    
    NSString *const SystemSocialType_WeiXin=@"com.tencent.xin.sharetimeline";
    NSString *socialType = SystemSocialType_WeiXin;
    if (![SLComposeViewController isAvailableForServiceType:socialType])
    {
        NSLog(@"不可用");
        return;
        
    }
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:socialType];
    if (!composeVC) {
        
        //        [self showAlertViewWithMsg:@"您尚未安装软件"];
        
        return;
        
    }
    
    //    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
    //
    ////        [self showAlertViewWithMsg:@"软件未配置登录信息"];
    //
    //        return;
    //
    //    }
    
    //添加分享的文字、图片、链接
    
    [composeVC setInitialText:@"哈罗大家好，这是分享测试的内容哦，如已看请忽略！如有任何疑问可联系1008611查你话费吧！"];
    
    [composeVC addImage:[UIImage imageNamed:@"shareImage.png"]];
    
    [composeVC addURL:[NSURL URLWithString:@"http://blog.csdn.net/Boyqicheng"]];
    //监听用户点击了取消还是发送
    
    composeVC.completionHandler = ^(SLComposeViewControllerResult result){
        
        if (result == SLComposeViewControllerResultCancelled) {
            
            NSLog(@"点击了取消");
            
        } else {
            
            NSLog(@"点击了发送");
            
        }
        
    };
    
    //弹出分享控制器
    
    [self presentViewController:composeVC animated:YES completion:nil];
    
    
    
    
}
- (void)ActivityViewController{
    
    //分享的标题
    NSString *textToShare = @"分享的标题。";
    //分享的图片
    UIImage *imageToShare = [UIImage imageNamed:@"312.jpg"];
    
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    
    //不出现在活动项目activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        
        if (completed) {
            
            NSLog(@"completed");
            
            //分享 成功
            
        } else  {
            
            NSLog(@"cancled");
            
            //分享 取消
            
        }
        
    };
    
    /*
     NSString *shareText = @"分享的标题";
     UIImage *shareImage = [UIImage imageNamed:@"分享的图片"];
     NSURL *shareUrl = [NSURL URLWithString:@"分享的链接"];
     NSArray *activityItemsArray = @[shareText,shareImage,shareUrl];
     CustomActivity *customActivity = [[CustomActivity alloc]initWithTitle: shareText ActivityImage:[UIImage imageNamed:@"custom.png"] URL: shareUrl ActivityType:@"Custom"];
     // 自定义的CustomActivity，继承自UIActivity
     
     NSArray *activityArray = @[customActivity];
     
     UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItemsArray applicationActivities:activityArray];
     activityVC.modalInPopover = YES;
     if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
     // ios8.0 之后用此方法回调
     UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
     NSLog(@"activityType == %@",activityType);
     if (completed == YES) {
     NSLog(@"completed");
     }else{
     NSLog(@"cancel");
     }
     };
     activityVC.completionWithItemsHandler = itemsBlock;
     }else{
     // ios8.0 之前用此方法回调
     UIActivityViewControllerCompletionHandler handlerBlock = ^(UIActivityType __nullable activityType, BOOL completed){
     NSLog(@"activityType == %@",activityType);
     if (completed == YES) {
     NSLog(@"completed");
     }else{
     NSLog(@"cancel");
     }
     };
     activityVC.completionHandler = handlerBlock;
     
     }
     [self presentViewController:activityVC animated:YES completion:nil];
     */
}
- (UIButton *)creatBtnWithY:(CGFloat)Y Title:(NSString *)title{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, Y, [UIScreen mainScreen].bounds.size.width - 20, 40)];
    btn.tag = Y;
    btn.titleLabel.text = title;
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor colorWithRed:0.157 green:0.710 blue:0.914 alpha:1.00];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(activityShare:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)activityShare:(UIButton *)btn{
    
    // 1、设置分享的内容，并将内容添加到数组中
    NSString *shareText = @"分享的标题";
    UIImage *shareImage = [UIImage imageNamed:@"shareImage.png"];
    NSURL *shareUrl = [NSURL URLWithString:@"https://www.jianshu.com/u/15d37d620d5b"];
    NSArray *activityItemsArray = @[shareText,shareImage,shareUrl];
    
    // 自定义的CustomActivity，继承自UIActivity
    CustomActivity *customActivity = [[CustomActivity alloc]initWithTitle:shareText ActivityImage:[UIImage imageNamed:@"custom.png"] URL:shareUrl ActivityType:@"Custom"];
    NSArray *activityArray = @[customActivity];
    
    // 2、初始化控制器，添加分享内容至控制器
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItemsArray applicationActivities:activityArray];
    activityVC.modalInPopover = YES;
    // 3、设置回调
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // ios8.0 之后用此方法回调
        UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
            NSLog(@"activityType == %@",activityType);
            if (completed == YES) {
                NSLog(@"completed");
            }else{
                NSLog(@"cancel");
            }
        };
        activityVC.completionWithItemsHandler = itemsBlock;
    }else{
        // ios8.0 之前用此方法回调
        UIActivityViewControllerCompletionHandler handlerBlock = ^(UIActivityType __nullable activityType, BOOL completed){
            NSLog(@"activityType == %@",activityType);
            if (completed == YES) {
                NSLog(@"completed");
            }else{
                NSLog(@"cancel");
            }
        };
        activityVC.completionHandler = handlerBlock;
    }
    // 4、调用控制器
    [self presentViewController:activityVC animated:YES completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
