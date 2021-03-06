//
//  SDDrowNoticeView.m
//  SDDrowNoticeView
//
//  Created by tianNanYiHao on 2017/7/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDDrowNoticeView.h"
#import <AudioToolbox/AudioToolbox.h>


#define selfWith [UIScreen mainScreen].bounds.size.width
#define selfHeight 64.f
#define spaceToParentView 10
@interface SDDrowNoticeView()<UIGestureRecognizerDelegate,UIActionSheetDelegate>{
    
    UIWindow *wd;
}
@end

@implementation SDDrowNoticeView


+ (instancetype)createDrowNoticeView:(NSArray*)stringArray{
    
    SDDrowNoticeView *drowView = [[SDDrowNoticeView alloc] init:stringArray];
    drowView.frame = CGRectMake(0, - selfHeight, selfWith, selfHeight);
    return drowView;
}

- (instancetype)init:(NSArray*)arr{

    if ([super init]) {
        
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selfWith, selfHeight)];
        backGroundView.backgroundColor = [UIColor colorWithRed:23/255.0f green:199/255.0f blue:132/255.0f alpha:1.0f];
        [self addSubview:backGroundView];
        [self buildUI:arr inView:backGroundView];
        
        //遮盖状态栏方法
        wd = [self mainWindow];
        [wd addSubview:self];
        wd.windowLevel = UIWindowLevelAlert;
        
        
        //添加向上的轻扫手势
        UISwipeGestureRecognizer *swipGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipaction:)];
        swipGR.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipGR];
        
        
    }return self;

}

/**
 获取window
 */
- (UIWindow*)mainWindow{
    
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

/**
 轻扫手势(向上)
 */
- (void)swipaction:(UISwipeGestureRecognizer*)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self animationUP:0.15f delay:0.f];
    }
    
}

/**
 向下弹出动画
 */
- (void)animationDrown{
    
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGPoint center = self.center;
        center.y += selfHeight;
        self.center = center;
        SystemSoundID soundId = 1308;
        AudioServicesPlaySystemSound(soundId);
    } completion:^(BOOL finished) {
        //延迟执行,避免过早删除
        [self performSelector:@selector(overs) withObject:nil afterDelay:1.5f];
        
    }];
    
}
- (void)overs{
    [self animationUP:0.3f delay:1.5f];
}

/**
 向上收回动画

 @param duration 动画时间
 @param durationDelay 延迟时间
 */
- (void)animationUP:(CGFloat)duration delay:(CGFloat)durationDelay{
    
    [UIView animateWithDuration:duration delay:durationDelay options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint center = self.center;
        center.y -= selfHeight;
        self.center = center;
    } completion:^(BOOL finished) {
        wd.windowLevel = UIWindowLevelNormal;
        [self removeFromSuperview];
    }];
}




/**
 构建UI

 @param arr 信息数据
 @param view 实例
 */
- (void)buildUI:(NSArray*)arr inView:(UIView*)view{
    //UI相关参数配置
    CGFloat titleSize = 0.f;
    CGFloat detailSize = 0.f;
    

        titleSize = 15;
        detailSize = 11;


    
    UIImage *appIcon;
    appIcon = [UIImage imageNamed:@"AppIcon60x60"];
    if (!appIcon) {
        appIcon = [UIImage imageNamed:@"AppIcon80x80"];
    }
    NSDictionary *infoDictionary = [[NSBundle bundleForClass:[self class]] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if (!appName) {
        appName = [infoDictionary objectForKey:@"CFBundleName"];
    }
    
    
    //1系统icon
    UIImageView *iconImgView = [[UIImageView alloc] initWithImage:appIcon];
    iconImgView.layer.cornerRadius = 5.f;
    iconImgView.layer.masksToBounds = YES;
    [view addSubview:iconImgView];
    
    //2 App名
    UILabel *titleText = [[UILabel alloc] init];
    titleText.textColor = [UIColor whiteColor];
    titleText.text = appName;
    titleText.font = [UIFont systemFontOfSize:titleSize];
    [view addSubview:titleText];
    
    //3 传入的信息
    UILabel *detailText = [[UILabel alloc] init];
    detailText.text = [NSString stringWithFormat:@"%@\n%@",[arr firstObject],[arr lastObject]];
    detailText.font = [UIFont systemFontOfSize:detailSize];
    detailText.textColor = [UIColor whiteColor];
    detailText.numberOfLines = 2;
    [view addSubview:detailText];
    
    //4 now
    UILabel *nowText = [[UILabel alloc] init];
    nowText.font = [UIFont systemFontOfSize:titleSize-2];
    nowText.text = @"现在";
    nowText.textColor = [UIColor whiteColor];
    nowText.textAlignment = NSTextAlignmentLeft;
    [view addSubview:nowText];
    
    //5 下方按钮
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    bottomView.layer.cornerRadius = spaceToParentView/3.f;
    bottomView.layer.masksToBounds = YES;
    bottomView.frame = CGRectMake(0, selfHeight-spaceToParentView, spaceToParentView*3, spaceToParentView/2);
    bottomView.center = CGPointMake(selfWith/2, selfHeight - spaceToParentView/2);
    [view addSubview:bottomView];
    
    
    
    //UI相关frame设置
    iconImgView.frame = CGRectMake(spaceToParentView, spaceToParentView, appIcon.size.width/2, appIcon.size.height/2);
    
    CGFloat titleTextToIconImageView = spaceToParentView + iconImgView.frame.size.width + spaceToParentView;
    CGFloat titleTextHeight = [self heightForString:titleText andWidth:titleSize];
    CGFloat titleTextWidth  = selfWith - 2*titleTextToIconImageView;
    titleText.frame    = CGRectMake(titleTextToIconImageView, spaceToParentView, titleTextWidth, titleTextHeight);
    
    CGFloat detailTextHeight = [self heightForString:detailText andWidth:detailSize];
    CGFloat detailTextX = spaceToParentView + titleTextHeight + 0;
    detailText.frame =  CGRectMake(titleTextToIconImageView,detailTextX , titleTextWidth, detailTextHeight);
    
    nowText.frame = CGRectMake(CGRectGetMaxX(detailText.frame)+spaceToParentView, 0, titleTextToIconImageView, titleTextHeight);
    CGPoint centen = nowText.center;
    centen.y = selfHeight/2;
    nowText.center = centen;
    
    
    
}

/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(UILabel *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}


@end
