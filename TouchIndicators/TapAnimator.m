//
//  TapAnimator.m
//  TouchIndicators
//
//  Created by Andrew Charkin on 11/26/13.
//  Copyright (c) 2013 Charimon. All rights reserved.
//

#import "TapAnimator.h"
#import <UIKit/UIKit.h>


@implementation TapAnimator
+(CGFloat) time { return 1.f; }
+(void) animate: (CAShapeLayer *) layer { [self animate:layer from: 0 delegate:nil]; }
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate:(id)delegate {
    CAKeyframeAnimation * opacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacity.keyTimes = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:.5f]];
    opacity.values = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:1.f]];
    
    CAKeyframeAnimation * scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scale.keyTimes = @[[NSNumber numberWithFloat:.5f], [NSNumber numberWithFloat:1.f]];
    scale.values = @[[NSNumber numberWithFloat:1.f], [NSNumber numberWithFloat:1.2f]];
    
    CAKeyframeAnimation * shadowRadius = [CAKeyframeAnimation animationWithKeyPath:@"shadowRadius"];
    shadowRadius.keyTimes = @[[NSNumber numberWithFloat:.5f], [NSNumber numberWithFloat:1.f]];
    shadowRadius.values = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:15.f]];
    
    CAKeyframeAnimation * shadowOpacity = [CAKeyframeAnimation animationWithKeyPath:@"shadowOpacity"];
    shadowOpacity.keyTimes = @[[NSNumber numberWithFloat:0.f]];
    shadowOpacity.values = @[[NSNumber numberWithFloat:1.f]];
    
    CAKeyframeAnimation * shadowColor = [CAKeyframeAnimation animationWithKeyPath:@"shadowColor"];
    shadowColor.keyTimes = @[[NSNumber numberWithFloat:0.f]];
    shadowColor.values = @[(id)[UIColor colorWithRed:40.f/255.f green:167.f/255.f blue:246.f/255.f alpha:1.f].CGColor];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = [self time];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.beginTime = time;
    group.delegate = delegate;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    group.animations = @[opacity, scale, shadowRadius, shadowOpacity, shadowColor];

    [layer addAnimation:group forKey:@"tapAnimation"];
}
@end
