//
//  PayCenterViewController.m
//  JHFrame_Test
//
//  Created by jiahui on 2017/6/11.
//  Copyright © 2017年 Jiahui. All rights reserved.
//

#import "PayCenterViewController.h"

@interface PayCenterViewController ()

@end

@implementation PayCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 80, 110, 40)];
    label.text = @"支付中心";
    [self.view addSubview:label];
    
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
