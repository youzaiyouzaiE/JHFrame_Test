//
//  PayMentViewController.m
//  ZCPublicLibrary
//
//  Created by jiahui on 2017/6/11.
//  Copyright © 2017年 Jiahui. All rights reserved.
//

#import "PayMentViewController.h"

@interface PayMentViewController ()

@end

@implementation PayMentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 80, 110, 40)];
    label.text = @"Public 支付中心";
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
