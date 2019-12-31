//
//  ViewController.m
//  MasonryTest
//
//  Created by XianCheng Wang on 2019/12/26.
//  Copyright © 2019 XianCheng Wang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()
@property (nonatomic,strong)UIView *redView;
@property (nonatomic,strong)UIView *yellowView;
@property (nonatomic,strong)UIView *blueView;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark 1. 三个View等宽_等高
//    [self demo_one];
    
#pragma mark 2. 使用Masonry时进行动画操作方法)
//    [self demo_tow];
    
#pragma mark 3. 使用Masonry时进行动画操作方法)
    [self demo_three];
}

-(void)demo_three{
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200,200));
        make.center.mas_equalTo(self.view);
    }];
    
    for (int i = 0; i < 4; i++) {
        UIView *yellowView = [[UIView alloc] init];
        [self.view addSubview:yellowView];
        [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(CGRectGetWidth(self.view.frame)/2);
            CGFloat pad = CGRectGetWidth(self.view.frame)/4;
            if (i == 0) {
    
                 make.centerX.mas_equalTo(self.view).offset(pad);
                 make.centerY.mas_equalTo(self.view).offset(pad);
                 yellowView.backgroundColor = [UIColor redColor];

                return ;
            }else if(i == 1){
                make.centerX.mas_equalTo(self.view).offset(-pad);
                make.centerY.mas_equalTo(self.view).offset(pad);
                yellowView.backgroundColor = [UIColor blueColor];

            }else if(i == 2){
                make.centerX.mas_equalTo(self.view).offset(pad);
                make.centerY.mas_equalTo(self.view).offset(-pad);
                yellowView.backgroundColor = [UIColor yellowColor];

            }else if(i == 3){
                make.centerX.mas_equalTo(self.view).offset(-pad);
                make.centerY.mas_equalTo(self.view).offset(-pad);
                yellowView.backgroundColor = [UIColor orangeColor];

            }
        }];
    }
}

#pragma mark 2. 使用Masonry时进行动画操作方法)
-(void)demo_tow{
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10,10));
        make.center.mas_equalTo(self.view);
    }];
    // GCD 延时执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟时间*/ * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //告知需要更改约束
        [self.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:2 animations:^{
            [self.redView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(250, 250));
              }];
           //告知父类控件绘制，不添加注释的这两行的代码无法生效
          [self.redView.superview layoutIfNeeded];
        }];
    });
}

#pragma mark 1. 三个View等宽_等高
-(void)demo_one{
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.view.frame)/3, CGRectGetHeight(self.view.frame)));
    }];
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.mas_equalTo(self.redView);
        make.left.mas_equalTo(self.redView.mas_right);
    }];
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.mas_equalTo(self.redView);
        make.left.mas_equalTo(self.yellowView.mas_right);
    }];
}

-(UIView *)redView{
    if (!_redView) {
        _redView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_redView];
    }return _redView;
}

-(UIView *)yellowView{
    if (!_yellowView) {
        _yellowView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_yellowView];
    }return _yellowView;
}

-(UIView *)blueView{
    if (!_blueView) {
        _blueView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_blueView];
    }return _blueView;
}
@end
