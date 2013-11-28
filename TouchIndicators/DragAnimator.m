//
//  DragAnimator.m
//  TouchIndicators
//
//  Created by Andrew Charkin on 11/27/13.
//  Copyright (c) 2013 Charimon. All rights reserved.
//

#import "DragAnimator.h"
#define TRACKS 2

@implementation DragAnimator
+(CGFloat) time { return .5f; }
+(void) animate: (CAShapeLayer *) layer { [self animate:layer from:0 delegate:nil]; }
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate: (id) delegate { [self animate:layer from:0 delegate: delegate direction:CGPointZero]; }
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate: (id) delegate direction:(CGPoint) direction {
    CAKeyframeAnimation * translate = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation"];
    translate.duration = [self time];
    translate.repeatCount = 0;
    translate.fillMode = kCAFillModeForwards;
    translate.removedOnCompletion = NO;
    translate.beginTime = time;
    translate.delegate = delegate;
    translate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    translate.keyTimes = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:.5f]];
    CGPoint fromPoint = [layer frame].origin;
    CGPoint toPoint = CGPointMake(fromPoint.x+direction.x, fromPoint.y+direction.y);
    translate.values = @[[NSValue valueWithCGPoint:fromPoint], [NSValue valueWithCGPoint:toPoint]];
    [layer addAnimation:translate forKey:@"dragAnimation"];
    
    CGFloat x = 0;
    CGFloat y = 0;
    if(direction.x > 0) x = 1;
    else if(direction.x < 0) x = -1;
    if(direction.y > 0) y = 1;
    else if(direction.y < 0) y = -1;
    
    CGFloat trackRatio = ((float)1)/((float)(TRACKS+1));
    for (int i = 1; i <= TRACKS; i++) {
        CGFloat iTrackRatio = ((float)i)/((float)(TRACKS+1));
        CAShapeLayer *circle = [CAShapeLayer layer];
        circle.path = [UIBezierPath bezierPathWithRoundedRect:layer.bounds cornerRadius:MIN(layer.bounds.size.width, layer.bounds.size.height)].CGPath;
        
        CGFloat newWidth = .5* layer.bounds.size.width * i * (trackRatio + iTrackRatio);
        CGFloat newHeight = .5* layer.bounds.size.height * i * (trackRatio + iTrackRatio);
        circle.position = CGPointMake( layer.bounds.size.width/2 - x*newWidth - x*layer.bounds.size.width*iTrackRatio/2 - x*layer.bounds.size.width/2, layer.bounds.size.height/2 - y*newHeight - y*layer.bounds.size.height*iTrackRatio/2 - y*layer.bounds.size.height/2);
        circle.anchorPoint = CGPointMake(.5, .5f);
        circle.bounds = layer.bounds;
        circle.strokeStart = 0.f;
        circle.strokeEnd = 1.f;
        circle.opacity = 0.f;
        circle.fillColor = [UIColor colorWithRed:40.f/255.f green:167.f/255.f blue:246.f/255.f alpha:.8f].CGColor;
        [layer addSublayer:circle];
        
        CAKeyframeAnimation * scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scale.duration = [self time];
        scale.beginTime = time;
        scale.fillMode = kCAFillModeForwards;
        scale.removedOnCompletion = NO;
        scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        scale.keyTimes = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:1.f]];
        scale.values = @[[NSNumber numberWithFloat:1.f], [NSNumber numberWithFloat:.8f*(1.f - iTrackRatio)]];
        
        CAKeyframeAnimation * opacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacity.duration = [self time];
        opacity.beginTime = time;
        opacity.fillMode = kCAFillModeForwards;
        opacity.removedOnCompletion = NO;
        opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        opacity.keyTimes = @[[NSNumber numberWithFloat:(iTrackRatio)*.7], [NSNumber numberWithFloat:.8*iTrackRatio], [NSNumber numberWithFloat:1.f - trackRatio], [NSNumber numberWithFloat:1.f]];
        opacity.values = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:1.f], [NSNumber numberWithFloat:1.f], [NSNumber numberWithFloat:0.f]];

        [circle addAnimation:opacity forKey:@"opacity"];
        [circle addAnimation:scale forKey:@"scale"];
    }
    
}
@end

@implementation DragNorthAnimator
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate:(id)delegate {
    [self animate:layer from:time delegate:delegate direction:CGPointMake(0.f, -90.f)];
}
@end

@implementation DragSouthAnimator
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate:(id)delegate {
    [self animate:layer from:time delegate:delegate direction:CGPointMake(0, 90.f)];
}
@end

@implementation DragEastAnimator
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate:(id)delegate {
    [self animate:layer from:time delegate:delegate direction:CGPointMake(90.f, 0.f)];
}
@end

@implementation DragWestAnimator
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate:(id)delegate {
    [self animate:layer from:time delegate:delegate direction:CGPointMake(-90.f, 0.f)];
}
@end

@implementation DragNorthWestAnimator
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate:(id)delegate {
    [self animate:layer from:time delegate:delegate direction:CGPointMake(-90.f, -90.f)];
}
@end

@implementation DragNorthEastAnimator
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate:(id)delegate {
    [self animate:layer from:time delegate:delegate direction:CGPointMake(90.f, -90.f) ];
}
@end

@implementation DragSouthWestAnimator
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate:(id)delegate {
    [self animate:layer from:time delegate:delegate direction:CGPointMake(-90.f, 90.f)];
}
@end

@implementation DragSouthEastAnimator
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate:(id)delegate {
    [self animate:layer from:time delegate:delegate direction:CGPointMake(90.f, 90.f)];
}
@end