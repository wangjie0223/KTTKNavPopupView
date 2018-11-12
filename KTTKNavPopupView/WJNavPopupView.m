//
//  WJNavPopupView.m
//  KTTKNavPopupView
//
//  Created by 王杰 on 2018/11/7.
//  Copyright © 2018 wangjie. All rights reserved.
//
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "WJNavPopupView.h"
@interface WJNavPopupView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *optionsArr;
@property (nonatomic,   copy) void(^selectedBlock)(NSString *);

@end

@implementation WJNavPopupView

- (id)initWithOptionsArray:(NSArray*)optionArray selectedBlock:(void(^)(NSString *))selectedBlock {
    
    if (self = [super init]) {
        _optionsArr = optionArray;
        _selectedBlock = selectedBlock;

      [self craetUI];
    }
    return self;
}


- (void)craetUI{
    self.frame = [UIScreen mainScreen].bounds;
    
    [self addSubview:self.maskView];
    [self addSubview:self.tableView];
}

- (UIView*)maskView {
    if (!_maskView) {
        CGFloat statusHeight;

        if (kDevice_Is_iPhoneX) {
            statusHeight = 44;
        }else{
            statusHeight = 20;
            
        }
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, statusHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = .5;
        _maskView.userInteractionEnabled = YES;
    }
    return _maskView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Navi_Cell"];
    }
    return _tableView;
}

#pragma mark TableViewDel
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.optionsArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Navi_Cell"];
    cell.textLabel.text = self.optionsArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Navi_Cell"];
    cell.textLabel.text = self.optionsArr[indexPath.row];
    if (self.selectedBlock) {
        self.selectedBlock(self.optionsArr[indexPath.row]);
    }
    [self dismiss];
}

- (void)dismiss{
    CGFloat height = self.tableView.contentSize.height;
    [UIView animateWithDuration:.3f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        CGRect rect = self.tableView.frame;
        rect.origin.y -= height;
        self.tableView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self show];
}

- (void)show{
    CGFloat height = self.tableView.contentSize.height;
    self.tableView.frame = CGRectMake(0, - height, SCREEN_WIDTH, height);
    CGFloat statusHeight;
    if (kDevice_Is_iPhoneX) {
        statusHeight = 44;
    }else{
        statusHeight = 20;

    }
    [UIView animateWithDuration:0.3f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];

        CGRect rect = self.tableView.frame;
        rect.origin.y += height + statusHeight;
        self.tableView.frame = rect;
    }];
   
   
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
