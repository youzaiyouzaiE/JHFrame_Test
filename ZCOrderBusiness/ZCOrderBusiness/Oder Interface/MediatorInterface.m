//
//  MediatorInterface.m
//  ZCOrderBusiness
//
//  Created by jiahui on 2017/6/12.
//  Copyright © 2017年 Jiahui. All rights reserved.
//

#import "MediatorInterface.h"
#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface MediatorInterface  () {
    
}

@end

@implementation MediatorInterface

+ (instancetype)sharedInstance {
    static MediatorInterface *shareInstance = nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[MediatorInterface alloc] init];
    });
    return shareInstance;
}

- (UIViewController *)transformToViewController:(NSString *)className transformStyle:(NSString *)style params:(NSDictionary *)params senderVC:(UIViewController *)sender {
    Class targetClassName = NSClassFromString(className);
    if (!targetClassName) {
        NSLog(@"未找到相关类");
        return nil;
    } else {
        BaseViewController *targetVC = [[targetClassName alloc] init];
        targetVC.dicParams = params;
        if ([style isEqualToString:@"present"]) {
            UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:targetVC];
            [sender presentViewController:navigationVC animated:YES completion:^{
            }];
        } else {
            [sender.navigationController pushViewController:targetVC animated:YES];
        }
        return targetVC;
    }
}

- (UIViewController *)pushToViewControll:(NSString *)className params:(NSDictionary *)params senderVC:(UIViewController *)sender {
    return [self transformToViewController:className transformStyle:@"push" params:params senderVC:sender];
}

- (UIViewController *)pushToViewControll:(NSString *)className senderVC:(UIViewController *)sender {
    return [self pushToViewControll:className params:nil senderVC:sender];
}

- (UIViewController *)presentToViewControll:(NSString *)className params:(NSDictionary *)params senderVC:(UIViewController *)sender {
    return [self transformToViewController:className transformStyle:@"present" params:params senderVC:sender];
}



@end
