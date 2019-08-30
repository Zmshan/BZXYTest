//
//  AppDelegate.m
//  响应
//
//  Created by  open-roc on 2017/10/18.
//  Copyright © 2017年 kuaixun100. All rights reserved.
//

#import "AppDelegate.h"
#define EnCodedString(encodedString)  (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)encodedString,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8))
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self e];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"111" forKey:UserKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    NSSetUncaughtExceptionHandler(&caughtExceptionHandler);
    return YES;
}
void caughtExceptionHandler(NSException *exception){
    /**
     *  获取异常崩溃信息
     */
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\\nname:%@\\nreason:\\n%@\\ncallStackSymbols:\\n%@",name,reason,[callStack componentsJoinedByString:@"\\n"]];
    //把异常崩溃信息发送至开发者邮件
    NSMutableString *mailUrl = [NSMutableString string];
    [mailUrl appendString:@"mailto:1246616383@qq.com"];
    [mailUrl appendString:@"?subject=程序异常崩溃信息，请配合发送异常报告，谢谢合作！"];
    [mailUrl appendFormat:@"&body=%@", content];
   
    [[NSUserDefaults standardUserDefaults]setObject:content forKey:@"exceptionLog"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
  
    // 打开地址
    NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
    
    
   
}
+ (void)writeToFile:(NSString *)str{
    
    //获取设备缓存路径
    NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    //拼接file路径，最终数据存储到words.plist文件中
    NSString *filePath = [cachePatch stringByAppendingPathComponent:@"exception.plist"];
    
    //将words数组中数据写入filePath下
    [str writeToFile:filePath atomically:YES encoding:kCFStringEncodingUTF8 error:nil];
    
}
+ (void)cachePatch{
    //获取需要读取数据plist路径
    NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePatch stringByAppendingPathComponent:@"exception.plist"];
    
    //将plist文件中数据转换成数组形式输出（要预先知道plist中数据类型，否则无法读出）
    NSString *products = [NSString stringWithContentsOfFile:filePath encoding:kCFStringEncodingUTF8 error:nil];
    NSLog(@"products========%@", products);
}
//void uncaughtExceptionHandler(NSException *exception){
//    NSMutableString *exceptionJSON = [[NSMutableString alloc] init];
//    [exceptionJSON appendString:@"{\n"];
//    [exceptionJSON appendFormat:@"\t\"异常时间\":\"%@\",\n",[CatchCrash getCurrentTime]];
//    [exceptionJSON appendFormat:@"\t\"用户名字\":\"%@\",\n",[KKInfoHelper readUserInfo].username];
//    [exceptionJSON appendFormat:@"\t\"设备型号\":\"%@\",\n",[DeviceInfo getDeviceInfo].deviceModel];
//    [exceptionJSON appendFormat:@"\t\"系统名称\":\"%@\",\n",[DeviceInfo getDeviceInfo].systemName];
//    [exceptionJSON appendFormat:@"\t\"设备名称\":\"%@\",\n",[DeviceInfo getDeviceInfo].deviceName];
//    [exceptionJSON appendFormat:@"\t\"系统版本\":\"%@\",\n",[DeviceInfo getDeviceInfo].systemVersion];
//    [exceptionJSON appendFormat:@"\t\"应用版本\":\"%@\",\n",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    [exceptionJSON appendFormat:@"\t\"异常名称\":\"%@\",\n",[exception name]];
//    [exceptionJSON appendFormat:@"\t\"异常原因\":\"%@\",\n",[exception reason]];
//    [exceptionJSON appendString:@"\t\"异常堆栈\":\n\t\""];
//    for (NSString* str in [exception callStackSymbols]) {
//        [exceptionJSON appendFormat:@"[%@]",str];
//    }
//    [exceptionJSON appendString:@"\",\n"];
//    [exceptionJSON appendString:@"}"];
//    [exceptionJSON writeToFile:[NSString stringWithFormat:@"%@/Documents/CrashError.log",NSHomeDirectory()] atomically:YES encoding:NSUTF8StringEncoding error:nil];
//}


#pragma mark === 遍历rootController ====
- (UIViewController *)rootController{
    UIViewController *topRootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
    while (topRootViewController.presentedViewController)
    {
        // 这里固定写法
        topRootViewController = topRootViewController.presentedViewController;
    }
    return topRootViewController;
}

- (void)e{
    //创建可变的地址字符串对象：
    NSMutableString *mailUrl = [[NSMutableString alloc] init];
    //添加收件人：
    NSArray *toRecipients = @[@"1246616383@qq.com"];
    // 注意：如有多个收件人，可以使用componentsJoinedByString方法连接，连接符为@","
    [mailUrl appendFormat:@"mailto:%@", toRecipients[0]];
    //添加抄送人：
    NSArray *ccRecipients = @[@"761197975@qq.com"];
    [mailUrl appendFormat:@"?cc=%@", ccRecipients[0]];
    //    // 添加密送人：
    //    NSArray *bccRecipients = @[@"1780575208@qq.com"];
    //    [mailUrl appendFormat:@"&bcc=%@", bccRecipients[0]];
    //
    //添加邮件主题和邮件内容：
    [mailUrl appendString:@"&subject=my email"];
    [mailUrl appendString:@"&body=<b>Hello</b> World!"];
    
    
    
    
    //打开地址，这里会跳转至邮件发送界面：
    NSString *emailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailPath]];
    
    
    //    openURL发送邮件.jpeg
    //
    //    注意：如果你没添加抄送或密送，主题需要设为 ?subject=my email，不然邮件会没有主题。
    //    邮件发送使用的是mailto的语法，可以自己去查看语法。
    
   

}
// 有外部app通过URL Scheme 的方法打开本应用，就会走本应用的这个方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *test = url.host; // 这就是参数
    NSLog(@"host = %@",test);
    
    NSString *msg = [NSString stringWithFormat:@"%@", test];
    NSString * urlStr = url.absoluteString;
    NSLog(@"url = %@",EnCodedString(urlStr));
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
     
    }];
    
    [alertController addAction:otherAction];
    
    [[self rootController] presentViewController:alertController animated:YES completion:nil];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
