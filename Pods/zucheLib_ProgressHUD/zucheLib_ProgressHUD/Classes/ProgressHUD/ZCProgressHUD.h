//
//  EDProgressHUD.h
//  EDOwn
//
//  Created by elijahDou on 16/3/11.
//  Copyright © 2016年 ed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ZCProgressHUD : NSObject

///// 添加到当前widonw上，显示期间不可以响应
////加载到window 不能响应事件，防止返回时loading状态不会消失在继续加载，显示loading 但不屏蔽 导航返回，请用 showOnView:方法
+ (void)show;

//// @param view显示loading的view View不响应事件 导航部分可响应
+ (void)showOnView:(UIView *)view;

////显示loading的view View可响应事件
+ (void)showEnableOnView:(UIView *)view;

////显示loading加载到window 可响应事件，有风险，当正在loading时返回 loading 可能不消失（需自己做处理
+ (void)showEnable;

// 显示loading ,添加到当前widonw上，显示期间不能响应
+ (void)showClear;

/*!
 *  @brief 显示菊花,添加到指定view上
 *  @param view  显示提示信息的view
 */
+ (void)showHUDAddedTo:(nullable UIView *)view;

// 隐藏loading
+ (void)dismiss;

/*!
 *  @brief 显示提示信息，显示在window上
 *
 *  @param Msg 提示信息内容
 */
+ (void)showMsg:(nonnull NSString *)msg;

/*!
 *  @brief 显示提示信息
 *
 *  @param Msg 提示信息内容
 *  @param view    显示提示信息的view
 */
+ (void)showMsg:(nonnull NSString *)msg onView:(nullable UIView *)view;

+ (void)showMessageToView:(nonnull UIView *)view message:(nullable NSString *)message autoHideTime:(NSTimeInterval )interval;
@end
