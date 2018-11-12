//
//  ViewController.m
//  KTTKNavPopupView
//
//  Created by 王杰 on 2018/11/7.
//  Copyright © 2018 wangjie. All rights reserved.
//

#import "ViewController.h"
#import "WJNavPopupView.h"

@interface ViewController ()
@property (nonatomic,strong)UIButton * titleButton;
@property (nonatomic,strong)WJNavPopupView * optionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * imgeView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:imgeView];
    imgeView.image = [UIImage imageNamed:@"IMG_0383"];
    self.titleButton = [[UIButton alloc]init];
    [self.titleButton setTitle:@"选择专业" forState:UIControlStateNormal];
    [self.titleButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.titleButton addTarget:self action:@selector(popUp:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.titleButton;
    
    
    
}



- (void)popUp:(UIButton *)button{
    
    NSArray * arr = @[@"1",@"2",@"3",@"4"];
    _optionView = [[WJNavPopupView alloc]initWithOptionsArray:arr selectedBlock:^(NSString * title) {
        NSLog(@"我点击了%@",title);
        [self.titleButton setTitle:title forState:UIControlStateNormal];

    }];

    UIWindow * window = [UIApplication sharedApplication].windows.lastObject;
    
    [window addSubview:_optionView];
    
}




@end
