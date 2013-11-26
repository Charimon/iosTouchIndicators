//
//  TouchIndicatorView.m
//  Pods
//
//  Created by Andrew Charkin on 11/26/13.
//
//

#import "TouchIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

@interface TouchIndicatorView()
@property (nonatomic) TouchAction action;
@property (nonatomic) CGSize size;
@end

@implementation TouchIndicatorView

-(id) initWithSize: (CGSize) size destination: (TouchAction) action {
    self = [super init];
    if(self){
        self.action = action;
        self.size = size;
    }
    return self;
}

-(void) addCircleTrackPath: (NSUInteger) tracks toLayer:(CALayer *) layer withSize:(CGSize) size withTranslation: (CGPoint) translation duration:(NSUInteger) duration repeatCount:(NSUInteger) repeatCount beginTime:(CGFloat) beginTime{
    for (int i = 0; i < tracks; i++) {
        CGFloat trackRatio = (float)i/(float)tracks;
        CGFloat trackRatioTime = (.95f-.55f)*trackRatio;
        
        CAShapeLayer *circle = [CAShapeLayer layer];
        circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:MIN(size.width/2,size.height/2)].CGPath;
        circle.position = CGPointMake(translation.x*trackRatio + size.width/2, translation.y*trackRatio + size.height/2);
        circle.bounds = CGRectMake(0, 0, size.width, size.height);
        circle.anchorPoint = CGPointMake(.5, .5f);
        circle.strokeStart = 0.f;
        circle.strokeEnd = 1.f;
        circle.opacity = 0.f;
        circle.fillColor = [UIColor colorWithRed:40.f/255.f green:167.f/255.f blue:246.f/255.f alpha:.8f].CGColor;
        [layer addSublayer:circle];
        
        
        NSArray *keyTimes = @[[NSNumber numberWithFloat:0.f],
                              [NSNumber numberWithFloat:.45f + trackRatioTime*.3],
                              [NSNumber numberWithFloat:.45f + trackRatioTime*.3 + .001f],
                              [NSNumber numberWithFloat:.9f],
                              [NSNumber numberWithFloat:.95f],
                              [NSNumber numberWithFloat:1.f]];
        
        CAKeyframeAnimation * circleOpacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        circleOpacity.duration = duration;
        circleOpacity.repeatCount = repeatCount;
        circleOpacity.beginTime = beginTime;
        circleOpacity.fillMode = kCAFillModeForwards;
        circleOpacity.removedOnCompletion = NO;
        circleOpacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        circleOpacity.keyTimes = keyTimes;
        circleOpacity.values = @[[NSNumber numberWithFloat:0.f],
                                 [NSNumber numberWithFloat:0.f],
                                 [NSNumber numberWithFloat:1.f],
                                 [NSNumber numberWithFloat:0.f],
                                 [NSNumber numberWithFloat:0.f],
                                 [NSNumber numberWithFloat:0.f]];
        
        CAKeyframeAnimation * circleScale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        circleScale.duration = duration;
        circleScale.repeatCount = repeatCount;
        circleScale.beginTime = beginTime;
        circleScale.fillMode = kCAFillModeForwards;
        circleScale.removedOnCompletion = NO;
        circleScale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        circleScale.keyTimes = keyTimes;
        circleScale.values = @[[NSNumber numberWithFloat:1.f],
                               [NSNumber numberWithFloat:1.f],
                               [NSNumber numberWithFloat:.75*.9],
                               [NSNumber numberWithFloat:trackRatioTime*.9],
                               [NSNumber numberWithFloat:trackRatioTime*.9],
                               [NSNumber numberWithFloat:0.f]];
        
        [circle addAnimation:circleOpacity forKey:@"circleOpacity"];
        [circle addAnimation:circleScale forKey:@"circleScale"];
        
    }
}

-(void) stopAnimation {
    self.layer.sublayers = nil;
}

-(void) startAnimation {
    CGFloat repeatCount = 3.f;
    CGFloat totalDuration = 3.f;
    CGFloat beginTime = CACurrentMediaTime() + 1.f;
    
    CGPoint translationPoint = CGPointZero;
    switch(self.action){
        case TouchActionDragNorth: translationPoint = CGPointMake(0, -90.f); break;
        case TouchActionDragSouth: translationPoint = CGPointMake(0, 90.f); break;
        case TouchActionDragEast: translationPoint = CGPointMake(-90.f, 0); break;
        case TouchActionDragWest: translationPoint = CGPointMake(90.f, 0); break;
        case TouchActionDragNorthEast: translationPoint = CGPointMake(-90.f, -90.f); break;
        case TouchActionDragNorthWest: translationPoint = CGPointMake(90.f, -90.f); break;
        case TouchActionDragSouthEast: translationPoint = CGPointMake(-90.f, 90.f); break;
        case TouchActionDragSouthWest: translationPoint = CGPointMake(90.f, 90.f); break;
        default: break;
    }
    
    NSArray *keyTimes = @[[NSNumber numberWithFloat:0.f],
                          [NSNumber numberWithFloat:.05f],
                          [NSNumber numberWithFloat:.3f],
                          [NSNumber numberWithFloat:.45f],
                          [NSNumber numberWithFloat:.55f],
                          [NSNumber numberWithFloat:.7f],
                          [NSNumber numberWithFloat:.95f],
                          [NSNumber numberWithFloat:1.f]];
    
    CAKeyframeAnimation * shadowGrow = [CAKeyframeAnimation animationWithKeyPath:@"shadowRadius"];
    shadowGrow.keyTimes = keyTimes;
    shadowGrow.values = @[[NSNumber numberWithFloat:0.f],
                          [NSNumber numberWithFloat:0.f],
                          [NSNumber numberWithFloat:0.f],
                          [NSNumber numberWithFloat:15.f],
                          [NSNumber numberWithFloat:15.f],
                          [NSNumber numberWithFloat:0.f],
                          [NSNumber numberWithFloat:0.f],
                          [NSNumber numberWithFloat:0.f]];
    
    
    CAKeyframeAnimation * circleGrow = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    circleGrow.keyTimes = keyTimes;
    circleGrow.values = @[[NSNumber numberWithFloat:1.f],
                          [NSNumber numberWithFloat:1.f],
                          [NSNumber numberWithFloat:1.f],
                          [NSNumber numberWithFloat:1.6f],
                          [NSNumber numberWithFloat:1.6f],
                          [NSNumber numberWithFloat:1.f],
                          [NSNumber numberWithFloat:1.f],
                          [NSNumber numberWithFloat:1.f]];
    
    
    CAKeyframeAnimation * circleOpacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    circleOpacity.keyTimes = keyTimes;
    circleOpacity.values = @[[NSNumber numberWithFloat:0.f],
                             [NSNumber numberWithFloat:1.f],
                             [NSNumber numberWithFloat:1.f],
                             [NSNumber numberWithFloat:1.f],
                             [NSNumber numberWithFloat:1.f],
                             [NSNumber numberWithFloat:1.f],
                             [NSNumber numberWithFloat:1.f],
                             [NSNumber numberWithFloat:0.f]];
    
    
    CAKeyframeAnimation * circleTranslate = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation"];
    circleTranslate.keyTimes = keyTimes;
    circleTranslate.values = @[[NSValue valueWithCGPoint:CGPointZero],
                               [NSValue valueWithCGPoint:CGPointZero],
                               [NSValue valueWithCGPoint:CGPointZero],
                               [NSValue valueWithCGPoint:CGPointZero],
                               [NSValue valueWithCGPoint:translationPoint],
                               [NSValue valueWithCGPoint:translationPoint],
                               [NSValue valueWithCGPoint:translationPoint],
                               [NSValue valueWithCGPoint:translationPoint]];
    
    CAAnimationGroup *circleGroup = [CAAnimationGroup animation];
    circleGroup.duration = totalDuration;
    circleGroup.repeatCount = repeatCount;
    circleGroup.beginTime = beginTime;
    circleGroup.fillMode = kCAFillModeForwards;
    circleGroup.removedOnCompletion = NO;
    circleGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    circleGroup.animations = @[shadowGrow, circleOpacity, circleGrow, circleTranslate];
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:MIN(self.size.width/2,self.size.height/2)].CGPath;
    circle.position = CGPointMake(self.size.width/2, self.size.height/2);
    circle.bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    circle.anchorPoint = CGPointMake(.5, .5f);
    circle.strokeStart = 0.f;
    circle.strokeEnd = 1.f;
    circle.opacity = 0.f;
    circle.fillColor = [UIColor colorWithRed:40.f/255.f green:167.f/255.f blue:246.f/255.f alpha:.8f].CGColor;
    [self.layer addSublayer:circle];
    
    [self addCircleTrackPath:4 toLayer:self.layer withSize:self.size withTranslation:translationPoint duration:totalDuration repeatCount:repeatCount beginTime:beginTime];
    [circle addAnimation:circleGroup forKey:@"circleAnimation"];
    
}


@end
