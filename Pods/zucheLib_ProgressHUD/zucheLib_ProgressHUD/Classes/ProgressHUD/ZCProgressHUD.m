//
//  EDProgressHUD.m
//  EDOwn
//
//  Created by elijahDou on 16/3/11.
//  Copyright © 2016年 ed. All rights reserved.
//

#import "ZCProgressHUD.h"
#import "MBProgressHUD.h"
#import "Masonry.h"
#import "zucheLib_ProgressIconFont.h"

#define Window ([[[UIApplication sharedApplication]delegate] window])

const static NSTimeInterval kMsgDuration = 1;

@interface ZCProgressHUD ()

@end

@implementation ZCProgressHUD

static  UIView *_hud = nil;
static UIImageView *_loadingImageView = nil;

#pragma mark - HUD
///加载到window 上的都不能响应事件，防止返回时loading状态不会消失在继续加载，显示loading 但不屏蔽 导航返回，请用showOnView:方法
+ (void)show {
    [self showHUDAddedTo:nil userInteractionEnabled:NO];
}

+ (void)showOnView:(UIView *)view {
    [self showHUDAddedTo:view userInteractionEnabled:NO];
}

+ (void)showEnableOnView:(UIView *)view {
    [self showHUDAddedTo:view userInteractionEnabled:YES];
}

+ (void)showEnable {
    [self showHUDAddedTo:nil userInteractionEnabled:YES];
}

+ (void)showClear {
    [self showHUDAddedTo:nil userInteractionEnabled:NO];
}

+ (void)showHUDAddedTo:(UIView *)view {
    [self showHUDAddedTo:view userInteractionEnabled:YES];
}

+ (void)showHUDAddedTo:(UIView *)view userInteractionEnabled:(BOOL)enabled {
    if (!_hud) {
        _hud = [self customViewStartAnimatint];
    }
    _hud.hidden = NO;
    if (!view) {
        view = Window;
    }
    view.userInteractionEnabled = enabled;
    [view addSubview:_hud];
    [_hud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    [self startAnimation];
}

#define CAR_FONT_SIZE   22
+ (UIView *)customViewStartAnimatint {
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UILabel *carImageLabel = [[UILabel alloc]init];
    carImageLabel.font = [zucheLib_ProgressIconFont iconFontWithSize:CAR_FONT_SIZE];
    carImageLabel.textColor = [UIColor whiteColor];
    carImageLabel.text = @"\U0000e616";
    [backgroundView addSubview:carImageLabel];
    [carImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backgroundView.mas_centerX);
        make.centerY.mas_equalTo(backgroundView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(CAR_FONT_SIZE, CAR_FONT_SIZE));
    }];
    CGFloat systemVerison = [[[UIDevice currentDevice]systemVersion]floatValue];
    UIImage *loadingImage;
    if (systemVerison < 8.0f) {
        NSString *string = [bundle pathForResource:@"ProgressLoading@2x" ofType:@"png"];
        loadingImage = [[UIImage alloc]initWithContentsOfFile:string];
    } else {
        loadingImage = [UIImage imageNamed:@"zucheLib_ProgressHUD.bundle/ProgressLoading" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    _loadingImageView = [[UIImageView alloc] initWithImage:loadingImage];
    [backgroundView addSubview:_loadingImageView];
    [_loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backgroundView.mas_centerX);
        make.centerY.mas_equalTo(backgroundView.mas_centerY);
        make.size.mas_equalTo(_loadingImageView.image.size);
    }];
    backgroundView.layer.cornerRadius = 5;
    backgroundView.layer.masksToBounds = YES;
    [backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
       make.size.mas_equalTo(CGSizeMake(78, 78));
    }];
    return backgroundView;
}

+ (void)startAnimation {
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 4.0 * 999];
    rotationAnimation.duration = 999;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = NO;
    [_loadingImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

+ (void)dismiss {
    Window.userInteractionEnabled = YES;
    UIView *supV = _hud.superview;
    if (supV) {
        _hud.superview.userInteractionEnabled = YES;
    }
    [_loadingImageView.layer removeAllAnimations];
    _hud.hidden = YES;
}

#pragma mark - message HUD
+ (void)showMsg:(NSString *)msg {
    [self showMsg:msg onView:nil];
}

+ (void)showMsg:(NSString *)msg onView:(UIView *)view {
    
    // view为空时，显示在当前的window上
    if (!view) view = Window;
    
    //没有消息就不显示
    if((msg == nil) || [msg isEqualToString:@""]) return;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    hud.detailsLabelText = msg;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    double length = msg.length;
    NSTimeInterval duration = length * 0.04 + kMsgDuration;
    [hud hide:YES afterDelay:duration];
}

+ (void)showMessageToView:(UIView *)view message:(NSString *)message autoHideTime:(NSTimeInterval )interval {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.font = [UIFont systemFontOfSize:14.0f];
    contentLabel.numberOfLines = 0;
    [contentLabel setTextAlignment:NSTextAlignmentCenter];
    contentLabel.text = message;
    hud.customView = contentLabel;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:interval];
}


@end
