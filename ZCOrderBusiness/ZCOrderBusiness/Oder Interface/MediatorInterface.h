//
//  MediatorInterface.h
//  ZCOrderBusiness
//
//  Created by jiahui on 2017/6/12.
//  Copyright © 2017年 Jiahui. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class UINavigationController;
@class UIViewController;

@interface MediatorInterface : NSObject

+ (instancetype)sharedInstance;

- (UIViewController *)pushToViewControll:(NSString *)className params:(NSDictionary *)params senderVC:(UIViewController *)sederVC;



@end
