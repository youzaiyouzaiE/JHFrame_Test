//
//  OrderListViewController.m
//  ZCOrderBusiness
//
//  Created by jiahui on 2017/6/9.
//  Copyright © 2017年 Jiahui. All rights reserved.
//

#import "OrderListViewController.h"
#import "Masonry.h"
#import "PayMentViewController.h"
@interface OrderListViewController ()

@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:button];
    [button setTitle:@"去支付" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view.center);
        make.height.mas_equalTo(50);
    }];
}

- (void)buttonAction:(UIButton *)button {
//    PayCenterViewController *payVC = [[PayCenterViewController alloc] init];
//    [self.navigationController pushViewController:payVC animated:YES];
    
    PayMentViewController *payVC = [[PayMentViewController alloc] init];
    [self.navigationController pushViewController:payVC animated:YES];

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
