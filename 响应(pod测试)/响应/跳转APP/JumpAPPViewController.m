//
//  JumpAPPViewController.m
//  响应
//
//  Created by open-roc on 2019/6/6.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "JumpAPPViewController.h"
#define iOSSystemVersion [UIDevice currentDevice].systemVersion.floatValue
//#define EnCodedString(encodedString)  (NSString *)CFBridgingRelease((__bridge CFTypeRef _Nullable)([[encodedString description] stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"] invertedSet]]))

//#define EnCodedString(encodedString)(NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)encodedString, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]"))



#define EnCodedString(encodedString)  (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)encodedString,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8))


@interface JumpAPPViewController ()

@end

@implementation JumpAPPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testBtn1];
   
}
- (void)testBtn1{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(100, 200, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 4;
    exemptionBtn.backgroundColor = [UIColor blueColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"jumpApp" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(jumpAppClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
   
    
}
- (void)jumpAppClicked:(UIButton *)sender{
    
    
    NSString *url = @"tpzlk://loginfreepassword?token=6be20dd0b916474510b027cc3b60c80b&loginSource=benchi";
//    NSString *url = @"https://intest.life.cntaiping.com/mobile/download";
    

//    (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)url,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8));
    
    
    
    if([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:EnCodedString(url)]])
        
    {
//        if (@available(iOS 10.0, *)) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:EnCodedString(url)] options:@{} completionHandler:^(BOOL success) {
//                exit(0);
//            }];
//        } else if (@available(iOS 8.0, *))  {
//            // Fallback on earlier versions
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:EnCodedString(url)]];
//            exit(0);
//
//        }
        if (iOSSystemVersion>=10.0) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:EnCodedString(url)] options:@{} completionHandler:^(BOOL success) {
//                exit(0);
            }];
            
        }else if (iOSSystemVersion>=8.0){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:EnCodedString(url)]];
//            exit(0);
        }
    }
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
