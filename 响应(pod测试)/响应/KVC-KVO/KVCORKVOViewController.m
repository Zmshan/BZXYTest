//
//  KVCORKVOViewController.m
//  响应
//
//  Created by open-roc on 2019/8/6.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "KVCORKVOViewController.h"

@interface KVCORKVOViewController ()
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *iconimage;
@end

@implementation KVCORKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.contentLabel];
    self.contentLabel.frame = CGRectMake(50, 100, 100, 20);
    
    
    
    
//    [self.view addSubview:self.iconimage];
//    self.iconimage.backgroundColor = [UIColor blueColor];
//    self.iconimage.frame = CGRectMake(0, 100, 100, 300);
//    self.iconimage.image = [UIImage imageNamed:@"1"];
//
//    self.iconimage.contentMode = UIViewContentModeScaleAspectFit;
//    self.iconimage.autoresizesSubviews = YES;
//    self.iconimage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
   
    
}




- (void)loadKVO{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld;
    [self.contentLabel addObserver:self forKeyPath:@"text" options:options context:@"age改变了"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.contentLabel.text=@"点击改变我";
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    /*
     * keyPath : 监听的属性
     * object : 监听的哪个对象
     * change : 根据监听的结构体，展示监听的内容
     * context : 监听传入的context
     */
    NSLog(@"keyPath:%@ object:%@ context:%@ change:%@",keyPath,object,context,change);
   
}
- (void)dealloc{
    [self.contentLabel removeObserver:self forKeyPath:@"text"];
}


- (UILabel *)contentLabel {

    
    if (!_contentLabel) {
        _contentLabel =[[UILabel alloc] init];
        _contentLabel.textColor = [UIColor redColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
     
    }
    return _contentLabel;
}
- (UIImageView *)iconimage {
    
    if (!_iconimage) {
        _iconimage =[[UIImageView alloc] init];
        
    }
    return _iconimage;
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
