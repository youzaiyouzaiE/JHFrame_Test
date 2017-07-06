//
//  zucheLib_NetwokingsListner.h
//  Pods
//
//  Created by zhangyuqing on 2016/12/13.
//
//

#import <Foundation/Foundation.h>

@interface zucheLib_NetwokingsListner : NSObject
// 网络监听
+ (zucheLib_NetwokingsListner *)sharedListner;
// 是否有网络
- (BOOL)hasTheNetwok;
@end
