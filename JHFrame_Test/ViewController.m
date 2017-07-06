//
//  ViewController.m
//  JHFrame_Test
//
//  Created by jiahui on 2017/6/9.
//  Copyright © 2017年 Jiahui. All rights reserved.
//

#import "ViewController.h"
//#import "OrderListViewController.h"
#import "FMDB.h"
#import "MediatorInterface.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushAction:(id)sender {
    [[MediatorInterface sharedInstance] pushToViewControll:@"OrderListViewController" params:@{@"1":@"value"} senderVC:self];
}

@end
