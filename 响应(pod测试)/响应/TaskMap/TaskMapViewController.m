//
//  TaskMapViewController.m
//  响应
//
//  Created by open-roc on 2019/6/4.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "TaskMapViewController.h"
#import "Masonry.h"
//******适配相关设备参数*********
// 判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define Height_TabBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 83.0 : 49.0)

#define AVIGATIONHeight ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 88.0 : 64.0)

#define NAVIGATIONBAR_H ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 88.0 : 64.0)

#define NAVIGATIONBAR_HEIGHT ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 88.0 : 64.0)

#define statusBarHEIGHT ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 44.0 : 20.0)


#define statusBarH (statusBarHEIGHT ? 44.0 : 0.0)

#define MapsTitleColor UIColorFromRGB(0x009e96)
#define WHITEColor [UIColor whiteColor]
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#define W_Adapter SCREEN_W/375.0
#define H_Adapter statusBarH + SCREEN_H/667.0
@interface TaskMapViewController ()
@property (nonatomic,strong) UIImageView *iconimage;
@property (nonatomic,strong) UIButton *jcBtn;
@property (nonatomic,strong) UIButton *jcBtn1;
@property(nonatomic,strong)NSMutableArray *studyTaskGroupPassListArr;

@property(nonatomic,strong)UIButton *backButton;
@end

@implementation TaskMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.iconimage];
    [self.iconimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.right.equalTo(self.view);
       
        make.bottom.equalTo(self.view.mas_bottom);
        
        
    }];
//    CGRect bounds = [UIScreen mainScreen].bounds;
//    UIImage *image = [self imageCompressForWidthScale:self.iconimage.image targetWidth:bounds.size.width];
//    self.iconimage.image = image;
    self.iconimage.contentMode =  UIViewContentModeScaleAspectFit;
    self.iconimage.backgroundColor = [UIColor redColor];
    [self.iconimage addSubview:self.jcBtn];
    [self.jcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconimage.mas_top).offset(H_Adapter*170);
        make.left.equalTo(self.iconimage.mas_left).offset(W_Adapter*80);
        
//        make.top.equalTo(self.iconimage.mas_top).offset((SCREEN_H/3));
//        make.left.equalTo(self.iconimage.mas_left).offset(W_Adapter*(SCREEN_W/4));
        make.height.equalTo(@50);

    }];
    
    
    [self.iconimage addSubview:self.jcBtn1];
    [self.jcBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.iconimage.mas_top).offset(H_Adapter*330);
//        make.left.equalTo(self.iconimage.mas_left).offset(W_Adapter*140);
//
        make.top.equalTo(self.iconimage.mas_top).offset(H_Adapter*290);
        make.left.equalTo(self.iconimage.mas_left).offset(W_Adapter*140);
        make.height.equalTo(@50);
        
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc]init];
        _backButton.backgroundColor = [UIColor clearColor];
        [_backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(void)backClick:(UIButton *)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
//指定宽度按比例缩放
-(UIImage *)imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImageView *)iconimage {
    if (!_iconimage) {
        _iconimage  =[[UIImageView alloc] init];
        //        UIImage *imageP = [self launchImageWithType:@"Portrait"];
        //        [self launchImageWithType:<#(NSString *)#>]
        _iconimage.image = [UIImage imageNamed:[self loadBgImageName]];
        _iconimage.userInteractionEnabled = YES;
        
    }
    return _iconimage;
}
/*
-(void)loadMissionBtn
{
    UIButton *lastBtn = nil;
    for (int i=0; i<self.studyTaskGroupPassListArr.count; i++) {
        CourseMapListModel *model = self.studyTaskGroupPassListArr[i];
        UIButton *btn  = [self missionBtnIsLock:model.isLock];
        
        btn.tag = i;
        [btn setTitle:model.taskName forState:UIControlStateNormal];
        
        [self.iconimage addSubview:btn];
        [self.missionBtnArr addObject:btn];
        if (i ==0) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.iconimage.mas_bottom).offset(-SIZEWIDTH_X(82.5, SCREEN_WIDTH));
                make.right.equalTo(self.iconimage.mas_right).offset(-SIZEWIDTH_X(54, SCREEN_WIDTH));
                make.width.mas_equalTo(SIZEWIDTH_X(135, SCREEN_WIDTH));
                make.height.mas_equalTo(SIZEWIDTH_X(49, SCREEN_WIDTH));
            }];
        }
        else if (i ==1)
        {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.iconimage.mas_bottom).offset(-SIZEWIDTH_X(121, SCREEN_WIDTH));
                make.left.equalTo(self.iconimage.mas_left).offset(SIZEWIDTH_X(21, SCREEN_WIDTH)); make.right.equalTo(lastBtn.mas_left).offset(-SIZEWIDTH_X(30, SCREEN_WIDTH));
                make.width.mas_equalTo(SIZEWIDTH_X(135, SCREEN_WIDTH));
                make.height.mas_equalTo(SIZEWIDTH_X(49, SCREEN_WIDTH));
            }];
        }
        else if (i == 2)
        {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(lastBtn.mas_top).offset(-SIZEWIDTH_X(24.5, SCREEN_WIDTH));
                make.left.equalTo(self.iconimage.mas_left).offset(SIZEWIDTH_X(214, SCREEN_WIDTH)); make.right.equalTo(self.iconimage.mas_right).offset(-SIZEWIDTH_X(26, SCREEN_WIDTH));
                make.width.mas_equalTo(SIZEWIDTH_X(135, SCREEN_WIDTH));
                make.height.mas_equalTo(SIZEWIDTH_X(49, SCREEN_WIDTH));
            }];
        }
        else if (i == 3)
        {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(lastBtn.mas_top).offset(-SIZEWIDTH_X(52, SCREEN_WIDTH));
                make.left.equalTo(self.iconimage.mas_left).offset(SIZEWIDTH_X(75, SCREEN_WIDTH)); make.right.equalTo(lastBtn.mas_left).offset(-SIZEWIDTH_X(4.5, SCREEN_WIDTH));
                make.width.mas_equalTo(SIZEWIDTH_X(135, SCREEN_WIDTH));
                make.height.mas_equalTo(SIZEWIDTH_X(49, SCREEN_WIDTH));
            }];
        }
        else if (i == 4)
        {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                //                make.bottom.equalTo(lastBtn.mas_top).offset(SIZEWIDTH_X(75, SCREEN_WIDTH));
                make.left.equalTo(self.iconimage.mas_left).offset(SIZEWIDTH_X(22, SCREEN_WIDTH)); make.top.equalTo(self.iconimage.mas_top).offset(SIZEWIDTH_X(201, SCREEN_WIDTH));
                make.width.mas_equalTo(SIZEWIDTH_X(135, SCREEN_WIDTH));
                make.height.mas_equalTo(SIZEWIDTH_X(49, SCREEN_WIDTH));
            }];
        }
        else if (i == 5)
        {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(lastBtn.mas_right).offset(SIZEWIDTH_X(47, SCREEN_WIDTH)); make.top.equalTo(self.iconimage.mas_top).offset(SIZEWIDTH_X(234, SCREEN_WIDTH));
                make.right.equalTo(self.iconimage.mas_right).offset(-SIZEWIDTH_X(36, SCREEN_WIDTH));
                make.width.mas_equalTo(SIZEWIDTH_X(135, SCREEN_WIDTH));
                make.height.mas_equalTo(SIZEWIDTH_X(49, SCREEN_WIDTH));
            }];
        }
        lastBtn = btn;
    }
    
}
- (UIButton *)missionBtnIsLock:(NSInteger)isLock{
    
    //    if (!_missionBtn) {
    UIButton *missionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    missionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    isLock    解锁状态    Y    0：1=已解锁：未解锁
    if (isLock ==0) {
        [missionBtn setBackgroundImage:[UIImage imageNamed:@"map_frame_green"] forState:UIControlStateNormal];
        [missionBtn setImage:[UIImage imageNamed:@"icon_unlock"] forState:UIControlStateNormal];
        missionBtn.titleLabel.font = [UIFont systemFontOfSize:SIZEWIDTH_X(16, SCREEN_WIDTH)];
        [missionBtn setTitleColor:MapsTitleColor forState:UIControlStateNormal];
    }
    else
    {
        [missionBtn setBackgroundImage:[UIImage imageNamed:@"map_frame_gray"] forState:UIControlStateNormal];
        [missionBtn setImage:[UIImage imageNamed:@"icon_lock"] forState:UIControlStateNormal];
        missionBtn.titleLabel.font = [UIFont systemFontOfSize:SIZEWIDTH_X(16, SCREEN_WIDTH)];
        [missionBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    }
    [missionBtn  addTarget:self action:@selector(missionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    CGSize titleLabelSize = [missionBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:missionBtn.titleLabel.font}];
    CGFloat imageWith = missionBtn.imageView.image.size.width;
    missionBtn.imageEdgeInsets = UIEdgeInsetsMake(SIZEWIDTH_X(8, SCREEN_WIDTH), SIZEWIDTH_X(135, SCREEN_WIDTH)-imageWith-SIZEWIDTH_X(16, SCREEN_WIDTH), SIZEWIDTH_X(21, SCREEN_WIDTH), SIZEWIDTH_X(8, SCREEN_WIDTH));
    
    missionBtn.titleEdgeInsets = UIEdgeInsetsMake(SIZEWIDTH_X(12, SCREEN_WIDTH),-imageWith-SIZEWIDTH_X(12, SCREEN_WIDTH), SIZEWIDTH_X(21, SCREEN_WIDTH), SIZEWIDTH_X(8, SCREEN_WIDTH));
    //    }
    return missionBtn;
}

- (void)missionBtnClicked:(UIButton *)sender{
    CourseMapListModel *model = self.studyTaskGroupPassListArr[sender.tag];
    if (model.isLock == 0) {
        TXTMissionMapsDetailsViewController *mapsDetailVc = [[TXTMissionMapsDetailsViewController alloc]init];
        mapsDetailVc.navigationItem.title = sender.currentTitle;
        mapsDetailVc.taskId = model.taskId;
        mapsDetailVc.studytaskGroupId = self.studytaskGroupId;
        [self.navigationController pushViewController:mapsDetailVc animated:YES];
    }
    else
    {
        
    }
    
}
 */
- (NSString *)loadBgImageName{
    NSString *imageName =  @"";
    if (kiPhone4) {
        imageName =  @"bg_newemployee640x960";
    }else if (kiPhone5){
        imageName =  @"bg_newemployee640x1136";
    }else if (kiPhone6){
        imageName =  @"bg_newemployee750x1334";
    }else if (kiPhone6Plus){
        imageName =  @"bg_newemployee1242x2208";
    }else if (IS_IPHONE_X){
        imageName =  @"bg_newemployee1125x2436";
    }else if (IS_IPHONE_Xr){
        imageName =  @"bg_newemployee828x1927";
    }else if (IS_IPHONE_Xs){
        imageName =  @"bg_newemployee1125x2436";
    }else if (IS_IPHONE_Xs_Max){
        imageName =  @"bg_newemployee1242x2688";
    }
    return imageName;
}

-(NSMutableArray *)studyTaskGroupPassListArr
{    if (!_studyTaskGroupPassListArr) {
    _studyTaskGroupPassListArr = [NSMutableArray array];
}
    return _studyTaskGroupPassListArr;
}
- (UIButton *)jcBtn{
    
    
    if (!_jcBtn) {
        _jcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _jcBtn.frame = CGRectMake(100, 100, 100, 50);
        _jcBtn.layer.masksToBounds = YES;
        _jcBtn.layer.cornerRadius = 4;
        _jcBtn.backgroundColor = [UIColor whiteColor];
        _jcBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        [_jcBtn setTitleColor:TitleColore9 forState:UIControlStateNormal];
//        [_jcBtn setTitleColor:HRTitleColor forState:UIControlStateSelected];
//        [_jcBtn setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
//        [_jcBtn setImage:[UIImage imageNamed:@"icon_Fabulous_p"] forState:UIControlStateSelected];
        [_jcBtn setTitle:@"职业素养篇" forState:UIControlStateNormal];
        [_jcBtn  addTarget:self action:@selector(jcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jcBtn;
}

- (void)jcBtnClicked:(UIButton *)sender{
    NSLog(@"jcBtn");
}
- (UIButton *)jcBtn1{
    
    
    if (!_jcBtn1) {
        _jcBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        //        _jcBtn.frame = CGRectMake(100, 100, 100, 50);
        _jcBtn1.layer.masksToBounds = YES;
        _jcBtn1.layer.cornerRadius = 4;
        _jcBtn1.backgroundColor = [UIColor whiteColor];
        _jcBtn1.titleLabel.font = [UIFont systemFontOfSize:12];
        //        [_jcBtn setTitleColor:TitleColore9 forState:UIControlStateNormal];
        //        [_jcBtn setTitleColor:HRTitleColor forState:UIControlStateSelected];
        //        [_jcBtn setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
        //        [_jcBtn setImage:[UIImage imageNamed:@"icon_Fabulous_p"] forState:UIControlStateSelected];
        [_jcBtn1 setTitle:@"职业素养篇" forState:UIControlStateNormal];
        [_jcBtn1  addTarget:self action:@selector(jcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jcBtn1;
}

- (void)jcBtn1Clicked:(UIButton *)sender{
    NSLog(@"jcBtn");
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
