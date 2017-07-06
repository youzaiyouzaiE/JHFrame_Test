//
//  zucheLib_NetwokingsListner.m
//  Pods
//
//  Created by zhangyuqing on 2016/12/13.
//
//

#import "zucheLib_NetwokingsListner.h"
#import "Reachability.h"

@interface zucheLib_NetwokingsListner()
@property (assign,nonatomic) BOOL hasNetwking;
@end


@implementation zucheLib_NetwokingsListner

+ (zucheLib_NetwokingsListner *)sharedListner
{
    static zucheLib_NetwokingsListner *sharedListnerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedListnerInstance = [[self alloc] init];
        sharedListnerInstance.hasNetwking = YES;
        [sharedListnerInstance createListner];
    });
    return sharedListnerInstance;
}


- (void)createListner
{
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    __weak typeof(self) weakSelf = self;
    reach.reachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.hasNetwking = YES;
        });
    };
    reach.unreachableBlock = ^(Reachability*reach)
    {
        weakSelf.hasNetwking = NO;
    };
    
    [reach startNotifier];
}

- (BOOL)hasTheNetwok
{
    return self.hasNetwking;
}
@end
