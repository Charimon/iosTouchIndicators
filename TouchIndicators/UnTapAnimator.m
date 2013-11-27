//
//  UnTapAnimator.m
//  TouchIndicators
//
//  Created by Andrew Charkin on 11/27/13.
//  Copyright (c) 2013 Charimon. All rights reserved.
//

#import "UnTapAnimator.h"

@implementation UnTapAnimator
+(CGFloat) time { return 1.f; }
+(void) animate: (CAShapeLayer *) layer { [self animate:layer from: 0 delegate:nil]; }
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate:(id)delegate {
    CAKeyframeAnimation * opacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacity.keyTimes = @[[NSNumber numberWithFloat:.5f], [NSNumber numberWithFloat:1.f]];
    opacity.values = @[[NSNumber numberWithFloat:1.f], [NSNumber numberWithFloat:0.f]];
    
    CAKeyframeAnimation * scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scale.keyTimes = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:.5f]];
    scale.values = @[[NSNumber numberWithFloat:1.2f], [NSNumber numberWithFloat:1.f]];
    
    CAKeyframeAnimation * shadowRadius = [CAKeyframeAnimation animationWithKeyPath:@"shadowRadius"];
    shadowRadius.keyTimes = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:.5f]];
    shadowRadius.values = @[[NSNumber numberWithFloat:15.f], [NSNumber numberWithFloat:0.f]];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = [self time];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.beginTime = time;
    group.delegate = delegate;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    group.animations = @[opacity, scale, shadowRadius];
    
    [layer addAnimation:group forKey:@"unTapAnimation"];
}
@end
