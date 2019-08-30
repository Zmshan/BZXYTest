//
//  ZCAEmitterCellViewController.m
//  响应
//
//  Created by open-roc on 2019/8/8.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "ZCAEmitterCellViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface ZCAEmitterCellViewController ()

@property (nonatomic,strong) UIBarButtonItem *rightModelItem;
@property (nonatomic ,strong) CAEmitterLayer *emitterLayer;


@property (nonatomic ,strong) CAEmitterLayer *caELayer;

@property (nonatomic ,strong)  UIButton * test1;
@end

@implementation ZCAEmitterCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
   
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"模式1" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn:)];
    self.navigationItem.rightBarButtonItem = item;
    _rightModelItem = item;
    self.view.backgroundColor=[UIColor whiteColor];
    self.caELayer.hidden = YES;
    [self loadCAEmitterCell];
    
   
    
}

- (void)rightBtn:(UIBarButtonItem *)item{
    
    
    
    if ([item.title isEqualToString:@"模式1"]) {
        [_rightModelItem setTitle:@"模式2"];
      
        self.view.backgroundColor=[UIColor blackColor];
        _test1.hidden = YES;
        _caELayer.hidden = NO;
        _emitterLayer.hidden = YES;
        [self initFireworks];
    }else if ([item.title isEqualToString:@"模式2"]){
        [_rightModelItem setTitle:@"模式3"];
        self.view.backgroundColor=[UIColor whiteColor];
        _test1.hidden = NO;
        _caELayer.hidden = YES;
        _emitterLayer.hidden = YES;
        [self loadBtnCAEmitterLayer];
    }else if ([item.title isEqualToString:@"模式3"]){
       [_rightModelItem setTitle:@"模式1"];
        self.view.backgroundColor=[UIColor whiteColor];
        _test1.hidden = YES;
        _caELayer.hidden = YES;
        _emitterLayer.hidden = NO;
        [self loadCAEmitterCell];
    }
        
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_emitterLayer.birthRate==1) {
        _emitterLayer.birthRate = 0;
    }else{
        _emitterLayer.birthRate = 1;
        if (_emitterLayer.emitterShape==kCAEmitterLayerLine) {
            _emitterLayer.emitterShape = kCAEmitterLayerCircle;
        }else{
            _emitterLayer.emitterShape=kCAEmitterLayerLine;
        }
        
        if (_emitterLayer.emitterMode==kCAEmitterLayerOutline) {
            _emitterLayer.emitterMode = kCAEmitterLayerPoints;
        }else{
            _emitterLayer.emitterMode=kCAEmitterLayerOutline;
        }
    }
 
    
}

- (void)loadCAEmitterCell{
    
    if (_emitterLayer) {
       
        return;
    }
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    //展示的图片
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"Body"].CGImage);
    
    //每秒粒子产生个数的乘数因子，会和layer的birthRate相乘，然后确定每秒产生的粒子个数
    cell.birthRate = 2000;
    //每个粒子存活时长
    cell.lifetime = 5.0;
    //粒子生命周期范围
    cell.lifetimeRange = 0.3;
    //粒子透明度变化，设置为－0.4，就是每过一秒透明度就减少0.4，这样就有消失的效果,一般设置为负数。
    cell.alphaSpeed = -0.2;
    cell.alphaRange = 0.5;
    //粒子的速度
    cell.velocity = 40;
    //粒子的速度范围
    cell.velocityRange = 20;
    //周围发射的角度，如果为M_PI*2 就可以从360度任意位置发射
    //cell.emissionRange = M_PI*2;
    //粒子内容的颜色
    cell.color = [[UIColor whiteColor] CGColor];
    
    //设置了颜色变化范围后每次产生的粒子的颜色都是随机的
    cell.redRange = 0.8;
    cell.blueRange = 0.8;
    cell.greenRange = 0.8;
    
    //缩放比例
    cell.scale = 0.2;
    //缩放比例范围
    cell.scaleRange = 0.02;
    
    //粒子的初始发射方向
    cell.emissionLongitude = M_PI;
    //Y方向的加速度
    cell.yAcceleration = 70.0;
    //X方向加速度
    //    cell.xAcceleration = 20.0;
    
    _emitterLayer = [CAEmitterLayer layer];
    
    //发射位置
    _emitterLayer.emitterPosition = CGPointMake(SCREEN_WIDTH/2.0, 0);
    //粒子产生系数，默认为1
    _emitterLayer.birthRate = 1;
    //发射器的尺寸
    _emitterLayer.emitterSize = CGSizeMake(SCREEN_WIDTH, 0);
    //发射的形状
    _emitterLayer.emitterShape = kCAEmitterLayerCircle;
    //发射的模式
    _emitterLayer.emitterMode = kCAEmitterLayerPoints;
    //渲染模式
    _emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    _emitterLayer.masksToBounds = NO;
    //_emitterLayer.zPosition = -1;
    _emitterLayer.emitterCells = @[cell];
    //emitterView是自己创建的一个View
    [self.view.layer addSublayer:_emitterLayer];
}

- (void)initFireworks{
    
    if (_caELayer) {
        
        return;
    }
    
    self.caELayer                   = [CAEmitterLayer layer];
    // 发射源
    self.caELayer.emitterPosition   = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 50);
    // 发射源尺寸大小
    self.caELayer.emitterSize       = CGSizeMake(50, 0);
    // 发射源模式
    self.caELayer.emitterMode       = kCAEmitterLayerOutline;
    // 发射源的形状
    self.caELayer.emitterShape      = kCAEmitterLayerLine;
    // 渲染模式
    self.caELayer.renderMode        = kCAEmitterLayerAdditive;
    // 发射方向
    self.caELayer.velocity          = 1;
    // 随机产生粒子
    self.caELayer.seed              = (arc4random() % 100) + 1;
    
    // cell
    CAEmitterCell *cell             = [CAEmitterCell emitterCell];
    // 速率
    cell.birthRate                  = 1.0;
    // 发射的角度
    cell.emissionRange              = 0.11 * M_PI;
    // 速度
    cell.velocity                   = 300;
    // 范围
    cell.velocityRange              = 150;
    // Y轴 加速度分量
    cell.yAcceleration              = 75;
    // 声明周期
    cell.lifetime                   = 2.04;
    //是个CGImageRef的对象,既粒子要展现的图片
    cell.contents                   = (id)
    [[UIImage imageNamed:@"Body"] CGImage];
    // 缩放比例
    cell.scale                      = 0.2;
    // 粒子的颜色
    cell.color                      = [[UIColor colorWithRed:0.6
                                                       green:0.6
                                                        blue:0.6
                                                       alpha:1.0] CGColor];
    // 一个粒子的颜色green 能改变的范围
    cell.greenRange                 = 1.0;
    // 一个粒子的颜色red 能改变的范围
    cell.redRange                   = 1.0;
    // 一个粒子的颜色blue 能改变的范围
    cell.blueRange                  = 1.0;
    // 子旋转角度范围
    cell.spinRange                  = M_PI;
    
    // 爆炸
    CAEmitterCell *burst            = [CAEmitterCell emitterCell];
    // 粒子产生系数
    burst.birthRate                 = 1.0;
    // 速度
    burst.velocity                  = 0;
    // 缩放比例
    burst.scale                     = 2.5;
    // shifting粒子red在生命周期内的改变速度
    burst.redSpeed                  = -1.5;
    // shifting粒子blue在生命周期内的改变速度
    burst.blueSpeed                 = +1.5;
    // shifting粒子green在生命周期内的改变速度
    burst.greenSpeed                = +1.0;
    //生命周期
    burst.lifetime                  = 0.35;
    
    
    // 火花 and finally, the sparks
    CAEmitterCell *spark            = [CAEmitterCell emitterCell];
    //粒子产生系数，默认为1.0
    spark.birthRate                 = 400;
    //速度
    spark.velocity                  = 125;
    // 360 deg//周围发射角度
    spark.emissionRange             = 2 * M_PI;
    // gravity//y方向上的加速度分量
    spark.yAcceleration             = 75;
    //粒子生命周期
    spark.lifetime                  = 3;
    //是个CGImageRef的对象,既粒子要展现的图片
    spark.contents                  = (id)
    [[UIImage imageNamed:@"FFTspark"] CGImage];
    //缩放比例速度
    spark.scaleSpeed                = -0.2;
    //粒子green在生命周期内的改变速度
    spark.greenSpeed                = -0.1;
    //粒子red在生命周期内的改变速度
    spark.redSpeed                  = 0.4;
    //粒子blue在生命周期内的改变速度
    spark.blueSpeed                 = -0.1;
    //粒子透明度在生命周期内的改变速度
    spark.alphaSpeed                = -0.25;
    //子旋转角度
    spark.spin                      = 2* M_PI;
    //子旋转角度范围
    spark.spinRange                 = 2* M_PI;
    
    self.caELayer.emitterCells = [NSArray arrayWithObject:cell];
    cell.emitterCells = [NSArray arrayWithObjects:burst, nil];
    burst.emitterCells = [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:self.caELayer];
}



- (void)loadBtnCAEmitterLayer{
    if (!_test1) {
        UIButton * test = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        test.layer.cornerRadius = 40;
        test.center = self.view.center;
        test.backgroundColor = [UIColor purpleColor];
        [test addTarget:self action:@selector(animation2:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:test];
        _test1 = test;
    }
    
}

- (void)animation2:(UIButton *)btn{
    
    
    //粒子发射器
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    snowEmitter.emitterPosition = CGPointMake(btn.bounds.size.width/2.0, btn.bounds.size.height/2.0);
    snowEmitter.emitterSize        = btn.bounds.size;
    snowEmitter.emitterMode        = kCAEmitterLayerOutline;
    snowEmitter.emitterShape    = kCAEmitterLayerRectangle;
    snowEmitter.seed              = (arc4random() % 100) + 1;
    
    
    CAEmitterCell * spark = [CAEmitterCell emitterCell];
    spark.birthRate            = 30;
    spark.velocity            = 80;
    spark.emissionRange        = 2* M_PI;// 360 度
    spark.lifetime            = 1.0;
    spark.contents            = (id) [[UIImage imageNamed:@"Eye-doe"] CGImage];
    spark.scaleSpeed        = -0.8;
    spark.alphaSpeed        = -.9;
    spark.spin                = M_PI_2;
    spark.spinRange            = M_PI_2;
    
    //粒子发射器
    CAEmitterLayer *snowEmitter1 = [CAEmitterLayer layer];
    snowEmitter1.emitterPosition = CGPointMake(btn.bounds.size.width/2.0, btn.bounds.size.height/2.0);
    snowEmitter1.emitterSize        = btn.bounds.size;
    snowEmitter1.emitterMode        = kCAEmitterLayerOutline;
    snowEmitter1.emitterShape    = kCAEmitterLayerRectangle;
    snowEmitter1.seed              = (arc4random() % 100) + 1;
    
    
    CAEmitterCell * spark1 = [CAEmitterCell emitterCell];
    spark1.birthRate            = 30;
    spark1.velocity            = 100;
    spark1.emissionRange        = 2* M_PI;    // 360 度
    spark1.lifetime            = 1.0;
    spark1.contents            = (id) [[UIImage imageNamed:@"Eye"] CGImage];
    spark1.scaleSpeed        = -0.8;
    spark1.alphaSpeed        = -.9;
    spark1.spin                = M_PI_2;
    spark1.spinRange            = M_PI_2;
    
    // 将粒子添加到粒子发射器上
    snowEmitter.emitterCells = [NSArray arrayWithObject:spark];
    snowEmitter1.emitterCells = [NSArray arrayWithObject:spark1];
    
    [btn.layer addSublayer:snowEmitter];
    [btn.layer addSublayer:snowEmitter1];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC));
    
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    
    __weak typeof(snowEmitter) weakselEmitter = snowEmitter;
    __weak typeof(snowEmitter1) weakselEmitter1 = snowEmitter1;
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        __strong typeof(weakselEmitter) strongEmitter = weakselEmitter;
        __strong typeof(weakselEmitter1) strongEmitter1 = weakselEmitter1;
        strongEmitter.birthRate = 0;
        strongEmitter1.birthRate = 0;
    });
    
    dispatch_after(popTime2, dispatch_get_main_queue(), ^{
        __strong typeof(weakselEmitter) strongEmitter = weakselEmitter;
        __strong typeof(weakselEmitter1) strongEmitter1 = weakselEmitter1;
        [strongEmitter removeFromSuperlayer];
        [strongEmitter1 removeFromSuperlayer];
    });
}

- (void)animation1{
    // Cells spawn in the bottom, moving up
    //分为3种粒子，子弹粒子，爆炸粒子，散开粒子
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = self.view.layer.bounds;
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    fireworksEmitter.emitterSize    = CGSizeMake(200, 200);
    fireworksEmitter.emitterMode    = kCAEmitterLayerPoints;
    fireworksEmitter.emitterShape    = kCAEmitterLayerPoint;
    fireworksEmitter.renderMode        = kCAEmitterLayerBackToFront;
    fireworksEmitter.seed = (arc4random()%100)+1;
    
    // Create the rocket
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    
    rocket.birthRate        = 1.0;
    rocket.emissionRange    = 0.25 * M_PI;  // some variation in angle
    rocket.velocity            = 380;
    rocket.velocityRange    = 100;
    rocket.yAcceleration    = 75;
    rocket.lifetime            = 1.02;    // we cannot set the birthrate < 1.0 for the burst
    
    //星星图片
    rocket.contents            = (id)[[UIImage imageNamed:@"Eye-doe"] CGImage];
    rocket.scale            = 0.2;
    rocket.color            = [[UIColor redColor] CGColor];
    rocket.greenRange        = 1.0;        // different colors
    rocket.redRange            = 1.0;
    rocket.blueRange        = 1.0;
    rocket.spinRange        = M_PI;        // slow spin
    
    // the burst object cannot be seen, but will spawn the sparks
    // we change the color here, since the sparks inherit its value
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    
    burst.birthRate            = 1.0;        // at the end of travel
    burst.velocity            = 0;        //速度为0
    burst.scale                = 2.5;      //大小
    burst.redSpeed            =-1.5;        // shifting
    burst.blueSpeed            =+1.5;        // shifting
    burst.greenSpeed        =+1.0;        // shifting
    burst.lifetime            = 0.35;     //存在时间
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate            = 400;
    spark.velocity            = 125;
    spark.emissionRange        = 2* M_PI;    // 360 度
    spark.yAcceleration        = 75;        // gravity
    spark.lifetime            = 3;
    //星星图片
    spark.contents            = (id) [[UIImage imageNamed:@"Eye"] CGImage];
    spark.scaleSpeed        =-0.2;
    spark.greenSpeed        =-0.1;
    spark.redSpeed            = 0.4;
    spark.blueSpeed            =-0.1;
    spark.alphaSpeed        =-0.25;
    spark.spin                = 2* M_PI;
    spark.spinRange            = 2* M_PI;
    
    // 3种粒子组合，可以根据顺序，依次烟花弹－烟花弹粒子爆炸－爆炸散开粒子
    fireworksEmitter.emitterCells    = [NSArray arrayWithObject:rocket];
    rocket.emitterCells                = [NSArray arrayWithObject:burst];
    burst.emitterCells                = [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:fireworksEmitter];
}



/*
{
    CAEmitterCell粒子单元
    contents   一般放一张图片，是我们粒子要展示的内容
    birthRate  每秒粒子产生个数的乘数因子，会和layer的birthRate相乘, 然后确定每秒产生的粒子个数
    lifetimeRange 所有的range属性都是你设置的属性值加减它后得到一个范围，例如cell.lifetime=5.0, cell.lifetimeRange = 1.0; 那么粒子的存活时间就是[4.0,6.0];
    color 粒子内容的颜色,更改后粒子会变色
    redRange，blueRange，greenRange 设置了颜色变化范围后会产生随机的颜色，这样粒子就会是五颜六色的了
    scale 粒子缩放比例，我们看到的烟花粒子就是缩放比例很小得到的，你可以用任意图，然后缩放比例设置很小，就可以得到很小的粒子
    
    
    CAEmitterLayer发射器
    emitterCells 粒子单元数组，你可以创建两个单元，负责不同的效果。
    emitterPosition 发射位置
    birthRate 粒子产生系数，默认为1，想关掉就设为0，这样就没有粒子产生了，demo中的暂停效果就是这么实现的。
    emitterSize 发射器的尺寸
    emitterShape 发射的形状，有6种值，分别是点、线、矩形、立方体、圆形、球形，具体的实现效果自己可以体验下。
    
    CA_EXTERN NSString * const kCAEmitterLayerPoint//点
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerLine//线
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerRectangle//矩形
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerCuboid//立方体
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerCircle//圆形
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerSphere//球形
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    
    emitterMode 发射的模式，有4种值，分别是
    CA_EXTERN NSString * const kCAEmitterLayerPoints//从发射器中
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerOutline//边缘
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerSurface//表面
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerVolume//中点
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    
    renderMode 渲染模式,有5种取值，分别是(我更改体验了下，暂没找出啥不同😄)
    CA_EXTERN NSString * const kCAEmitterLayerUnordered//粒子是无序出现的，多个发射源将混合
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerOldestFirst//声明久的粒子会被渲染在最上层
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerOldestLast//年轻的粒子会被渲染在最上层
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerBackToFront//粒子的渲染按照Z轴的前后顺序进行
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
    CA_EXTERN NSString * const kCAEmitterLayerAdditive//进行粒子混合
    CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 
    链接：https://www.jianshu.com/p/8a2f1b2224a4
 
}
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
