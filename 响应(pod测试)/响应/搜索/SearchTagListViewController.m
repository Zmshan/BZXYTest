//
//  SearchTagListViewController.m
//  响应
//
//  Created by  open-roc on 2017/12/9.
//  Copyright © 2017年 kuaixun100. All rights reserved.
//

#import "SearchTagListViewController.h"
#import "SearchTagListView.h"
@interface SearchTagListViewController ()
@property (nonatomic,strong)SearchTagListView *tagListView;
@end

@implementation SearchTagListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"JAVA",@"C",@"C++",@"PHP",@"Object-C",@"Swift",@"JAVAWEB",@"C#",@"MYSQL",@"hgdhsghdsjdhjashdjahkjdhjakhdkjahkdhka",@"1233",@"1233",@"1233",@"1233",@"1233"];
    NSInteger x = 10;
    NSInteger y = 0;
    UIView * view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view1];
     CGSize size1 = [@"JAVA" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
    CGFloat height = size1.height;
    
    for (NSInteger i=0; i<arr.count; i++) {
        NSString *str = [arr objectAtIndex:i];
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
        
        if (x + size.width > self.view.frame.size.width-20) {
            x = 10;
            y = y + size.height+5; //5为两行之间的高度间隔
            height +=size.height+5;
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, size.width, size.height)];
        label.text = str;
        label.font = [UIFont systemFontOfSize:16.0f];
        label.backgroundColor = [UIColor orangeColor];
        label.textColor = [UIColor whiteColor];
    
        label.layer.borderColor =[UIColor redColor].CGColor;
        label.layer.borderWidth = 1;
        label.layer.cornerRadius = 4;
        label.layer.masksToBounds = YES;
        [view1 addSubview:label];
        
        x = x + size.width +10; //10为两个标签之间的宽度间隔
    }
    
    view1.frame = CGRectMake(0, 100, self.view.frame.size.width,height);
    
    
//    CGFloat height=[SearchTagListView heightWithTags:_tagListView.tags style:TagListViewStyleStd];
//
//    [self.view addSubview:_tagListView];
//    [self.hotTagLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.searchView.mas_bottom).offset(-12);
//        make.left.equalTo(self.view);
//        make.width.equalTo(@75);
//        make.height.equalTo(@40);
//
//    }];
}


-(SearchTagListView *)tagListView{
    if (!_tagListView) {
        _weak(self);
        _tagListView=[[SearchTagListView alloc] initWithStyle:TagListViewStyleStd];
        _tagListView.backgroundColor=self.view.backgroundColor;
        
        
        [_tagListView onTagClick:^(NSUInteger index, NSString *tag) {
            _strong_check(self);
//            [self.searchTextField resignFirstResponder];
//            self.keyword=tag;
//
//            [self _loadDataWithIsLatest:YES];
        }];
        
    }
    return _tagListView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
