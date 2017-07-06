//
//  zucheLib_ProgressIconFont.m
//  Pods
//
//  Created by zhangyuqing on 2016/12/12.
//
//

#import "zucheLib_ProgressIconFont.h"
#import <CoreText/CoreText.h>
@implementation zucheLib_ProgressIconFont
+ (UIFont *)iconFontWithSize:(CGFloat)size
{
#ifndef DISABLE_FONTAWESOME_AUTO_REGISTRATION
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *fontUrl = [bundle URLForResource:@"zucheLibProgress" withExtension:@"ttf"];
        [self registerIconFontWithURL:fontUrl];
    });
#endif
    
    UIFont *font = [UIFont fontWithName:@"zucheLibProgress" size:size];
    NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    return font;
}

+ (void)registerIconFontWithURL:(NSURL *)url
{
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:[url path]], @"Font file doesn't exist");
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)url);
    CGFontRef newFont = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CFErrorRef error = NULL;
    CTFontManagerRegisterGraphicsFont(newFont, &error);
    CGFontRelease(newFont);
    
    if (error) {
        CFRelease(error);
    }
}
@end
