//
//  GradualView.m
//  sandbao
//
//  Created by tianNanYiHao on 2017/3/14.
//  Copyright © 2017年 sand. All rights reserved.
//

#import "GradualView.h"
@interface GradualView(){
    CAGradientLayer *layerRGB;
}@end
@implementation GradualView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    if (self = [super init]) {
        //4.渐变色
        layerRGB = [CAGradientLayer layer];
        layerRGB.frame = CGRectZero;
        layerRGB.startPoint = CGPointMake(0, 0);
        layerRGB.endPoint = CGPointMake(1, 0);
        layerRGB.colors = @[(__bridge id)[UIColor colorWithRed:51/255.0 green:165/255.0 blue:218/255.0 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:98/255.0 green:27/255.0 blue:226/255.0 alpha:1].CGColor];
        [self.layer addSublayer:layerRGB];

            }
    return self;
}

-(void)setRect:(CGRect)rect{
    _rect = rect;
    layerRGB.frame = _rect;
}

@end
