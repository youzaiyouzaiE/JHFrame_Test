//
//  tooles.h
//  huoche
//
//  Created by kan xu on 11-1-22.
//  Copyright 2011 paduu. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface tooles : NSObject {	
	
    CFRunLoopRef currentLoop;//
    NSUInteger index;//me无符号整型
    //MBProgressHUD *HUD;
}
@property (readonly) NSUInteger index;



+(NSUInteger)queryWith:(NSString *)question buttion1:(NSString *)buttion1 buttion2:(NSString *)buttion2;
+(BOOL) ask:(NSString *)question;
+(NSString *)dateStringFromiPhone;//获取当前时间
+(NSDate *)dateForomThatTime;//获取当前时间NSDate

+ (NSString *)intervalSinceNow: (NSString *) theDate;

///////////////////////////////////////////////////////////
+ (NSString *)Date2StrV:(NSDate *)indate;
+ (NSString *)Date2Str:(NSDate *)indate;
+ (void)MsgBox:(NSString *)msg;
+ (NSDateComponents *)DateInfo:(NSDate *)indate;
+ (void)OpenUrl:(NSString *)inUrl;

+ (void)showHUD:(NSString *)msg;
+(void)showAllTextDialog:(NSString *)msg ;
+(void)showAllTextDialog:(NSString *)msg hideAfter:(CGFloat)time;//只是文字的显示框中间显示
+(void)showCustomDialog:(NSString *)msg;//图片加文字的显示框
//+ (void)showNotification:(NSString *)text andView:(UIView *)view andLoading:(BOOL)isLoading andIsBottom:(BOOL)isBottom;//只是底部和顶部的提示显示
+ (void)removeHUD;

+(int)getTextViewHeight:(UITextView *)txtView andUIFont:(UIFont *)font andText:(NSString *)txt;
+(int) getHeightForWidth:(CGFloat)sizeWidth andUifont:(UIFont *)font andText:(NSString *)text;


+ (UIColor *)getBackgroundColor;
+ (UIColor *)getCellBackgroundColor;
+ (UIColor *)getCommentCellBackgroundColor;
+ (UIColor *)getBlackgrayColor;//黑灰色

+ (UIColor *)getReadgrayColoer;//深红色，可点击的



@end
