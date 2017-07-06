//
//  tooles.m
//  huoche
//
//  Created by kan xu on 11-1-22.
//  Copyright 2011 paduu. All rights reserved.
//

#import "Tooles.h"
#import "MBProgressHUD.h"
#import "Masonry.h"

#define MsgBox(msg) [self MsgBox:msg]


@implementation tooles
@synthesize index;

 MBProgressHUD *HUD;
///////////////////////////////////////////////////////////////////////////////////////以下是我加的
-(id)initWithRunLoop:(CFRunLoopRef)runloop{
    if (self = [super init]) {
        currentLoop = runloop;
        UIView *view ;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
    return self;
}

-(void) alertView:(UIAlertView *)aView clickedButtonAtIndex:(NSInteger)buttonIndex//回调，选择后调用
{
    index = buttonIndex;
    CFRunLoopStop(currentLoop);
}

//我添加的可选择，返回结果的警告框
+ (NSUInteger)queryWith:(NSString *)question buttion1:(NSString *)buttion1 buttion2:(NSString *)buttion2
{
    CFRunLoopRef currentLoop = CFRunLoopGetCurrent();
    tooles *madelegate = [[tooles alloc] initWithRunLoop:currentLoop];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:question message:nil delegate:madelegate cancelButtonTitle:buttion1 otherButtonTitles:buttion2, nil];
    [alertView show];
    
    CFRunLoopRun();
    
    NSUInteger answer = madelegate.index;
    return answer;
}

+ (BOOL)ask:(NSString *)question
{
    return ([tooles queryWith:question buttion1:@"是的" buttion2:@"取消"] == 0);
}

+(BOOL)confirm:(NSString *)statement
{
    return [tooles queryWith:statement buttion1:@"Cancel" buttion2:@"OK"];
}

//获取当前时间和日期
+(NSString *)dateStringFromiPhone
{
    NSDate *  senddate=[NSDate date];
//    NSLog(@"%@",senddate);
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
//    NSLog(@"当前时间为%@",locationString);
    
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    NSString *  nsDateString= [NSString  stringWithFormat:@"%4d-%d-%d ",year,month,day];
    nsDateString = [nsDateString stringByAppendingString:locationString];
    return nsDateString;
}

+(NSDate *)dateForomThatTime//获取当前时间
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];//28800
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

//////////////////////////////////////////////////////////////////////////////////////////
//程序中使用的，将日期显示成  2011年4月4日 星期一
+ (NSString *) Date2StrV:(NSDate *)indate{

	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]]; //setLocale 方法将其转为中文的日期表达
	dateFormatter.dateFormat = @"yyyy '-' MM '-' dd ' ' EEEE";
	NSString *tempstr = [dateFormatter stringFromDate:indate];
	return tempstr;
}

//程序中使用的，提交日期的格式
+ (NSString *) Date2Str:(NSDate *)indate{
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
	dateFormatter.dateFormat = @"yyyyMMdd";
	NSString *tempstr = [dateFormatter stringFromDate:indate];
	return tempstr;	
}

//提示窗口（只有一个OK，不能选择）
+ (void)MsgBox:(NSString *)msg{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg
												   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}


//获得日期的具体信息，本程序是为获得星期，注意！返回星期是 int 型，但是和中国传统星期有差异
//+ (NSDateComponents *) DateInfo:(NSDate *)indate{
//
//	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
//	NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | 
//	NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//
//	comps = [calendar components:unitFlags fromDate:indate];
//	
//	return comps;
//}

//返回更直观的时间
+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    else if (cha/86400>1&&cha/864000<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    else
    {
        //        timeString = [NSString stringWithFormat:@"%d-%"]
        NSArray *array = [theDate componentsSeparatedByString:@" "];
        //        return [array objectAtIndex:0];
        timeString = [array objectAtIndex:0];
    }
    return timeString;
}





//打开一个网址
+ (void) OpenUrl:(NSString *)inUrl{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:inUrl]];
}


//菊花加载画面
//MBProgressHUD 的使用方式，只对外两个方法，可以随时使用(但会有警告！)，其中窗口的 alpha 值 可以在源程序里修改。
+ (void)showHUD:(NSString *)msg{
	HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
	[[UIApplication sharedApplication].keyWindow addSubview:HUD];
	HUD.labelText = msg;
	[HUD show:YES];	
}

+(void)showAllTextDialog:(NSString *)msg hideAfter:(CGFloat)time{//只是文字的显示框
    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.labelText = msg;
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD show:YES];
    [self performSelector:@selector(removeHUD) withObject:nil afterDelay:time];
}

+(void)showAllTextDialog:(NSString *)msg {//只是文字的显示框
    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.labelText = msg;
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD show:YES];
//    [self performSelector:@selector(removeHUD) withObject:nil afterDelay:time];
}


+(void)showCustomDialog:(NSString *)msg{//图片加文字的显示框
    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.labelText = msg;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    [HUD show:YES];
    [self performSelector:@selector(removeHUD) withObject:nil afterDelay:1];
}

+ (void)removeHUD{
	[HUD hide:YES];
	[HUD removeFromSuperViewOnHide];
    HUD = nil;
}

//+ (void)showNotification:(NSString *)text andView:(UIView *)view andLoading:(BOOL)isLoading andIsBottom:(BOOL)isBottom//只是底部和顶部的提示显示开源中国里用的
//{
//    GCDiscreetNotificationView *notificationView = [[GCDiscreetNotificationView alloc] initWithText:text showActivity:isLoading inPresentationMode:isBottom?GCDiscreetNotificationViewPresentationModeBottom:GCDiscreetNotificationViewPresentationModeTop inView:view];
//    [notificationView show:YES];
//    [notificationView hideAnimatedAfter:2.6];
//}

//获取自适应字的高度？？？
+(int)getTextViewHeight:(UITextView *)txtView andUIFont:(UIFont *)font andText:(NSString *)txt
{
    float fPadding = 16.0;
    CGSize constraint = CGSizeMake(txtView.contentSize.width - 10 - fPadding, CGFLOAT_MAX);
    CGSize size = [txt sizeWithFont:font constrainedToSize:constraint lineBreakMode:0];
    float fHeight = size.height + 16.0;
    return fHeight;
}

//跟据宽度求高度
+(int) getHeightForWidth:(CGFloat)sizeWidth andUifont:(UIFont *)font andText:(NSString *)text{
    float fPadding = 16.0;
    CGSize constraint = CGSizeMake(sizeWidth - 10 - fPadding, CGFLOAT_MAX);
    CGSize size = [text sizeWithFont:font constrainedToSize:constraint lineBreakMode:0];
    float fHeight = size.height + 16.0;
    return fHeight;
}


#pragma mark -
#pragma mark - colors
+ (UIColor *)getBackgroundColor
{
    return [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1.0];
}

+ (UIColor *)getCellBackgroundColor{
//    return [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1.0];
    return [UIColor colorWithRed:216.0/255 green:237.0/255 blue:251.0/255 alpha:1.0];
}

+ (UIColor *)getCommentCellBackgroundColor//标题栏的颜色
{
    return [UIColor colorWithRed:216.0/255 green:227.0/255 blue:249.0/255 alpha:1.0];
}

+(UIColor *)getBlackgrayColor{//黑灰色
    return [UIColor colorWithRed:75.0/225 green:87.0/225 blue:101.0/225 alpha:1.0];
}

+(UIColor *)getReadgrayColoer{//深红色，可点击的
    return [UIColor colorWithRed:111.0/225 green:80.0/225 blue:174.0/225 alpha:1.0];
}

@end
