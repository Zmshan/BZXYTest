//
//  MailComposeViewController.m
//  响应
//
//  Created by open-roc on 2019/6/27.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "MailComposeViewController.h"
#import <MessageUI/MessageUI.h>
@interface MailComposeViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation MailComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if ([MFMailComposeViewController canSendMail]) {
        // 用户已设置邮件账户
        // 邮件服务器
        MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
        // 设置邮件代理
        [mailCompose setMailComposeDelegate:self];
        
        // 设置邮件主题
        [mailCompose setSubject:@"我是邮件主题"];
        
        // 设置收件人
        [mailCompose setToRecipients:@[@"1432985893@qq.com"]];
        // 设置抄送人
//        [mailCompose setCcRecipients:@[@"1780575208@qq.com"]];
        // 设置密抄送
//        [mailCompose setBccRecipients:@[@"1780575208@qq.com"]];
        
        /**
         *  设置邮件的正文内容
         */
        NSString *emailContent = @"我是邮件内容";
        // 是否为HTML格式
        [mailCompose setMessageBody:emailContent isHTML:NO];
        // 如使用HTML格式，则为以下代码
        //    [mailCompose setMessageBody:@"<html><body><p>Hello</p><p>World！</p></body></html>" isHTML:YES];
        
        /**
         *  添加附件
         */
//        UIImage *image = [UIImage imageNamed:@"1"];
//        NSData *imageData = UIImagePNGRepresentation(image);
//        [mailCompose addAttachmentData:imageData mimeType:@"" fileName:@"image.png"];
//
//        NSString *file = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"pdf"];
//        NSData *pdf = [NSData dataWithContentsOfFile:file];
//        [mailCompose addAttachmentData:pdf mimeType:@"" fileName:@"file"];
        
        // 弹出邮件发送视图
        [self presentViewController:mailCompose animated:YES completion:nil];
        
    }else{
        [self e];
        NSLog(@"请先设置登录邮箱号");
    }

}


- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)e{
    //创建可变的地址字符串对象：
    NSMutableString *mailUrl = [[NSMutableString alloc] init];
    //添加收件人：
    NSArray *toRecipients = @[@"1432985893@qq.com"];
    // 注意：如有多个收件人，可以使用componentsJoinedByString方法连接，连接符为@","
    [mailUrl appendFormat:@"mailto:%@", toRecipients[0]];
    //添加抄送人：
//    NSArray *ccRecipients = @[@"761197975@qq.com"];
//    [mailUrl appendFormat:@"?cc=%@", ccRecipients[0]];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
