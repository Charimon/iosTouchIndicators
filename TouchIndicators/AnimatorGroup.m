//
//  TouchIndicatorGroup.m
//  Pods
//
//  Created by Andrew Charkin on 11/26/13.
//
//

#import "AnimatorGroup.h"
#import "Animator.h"
#import "TapAnimator.h"

@interface AnimatorGroup()
@property (strong, nonatomic) CAShapeLayer *animatingLayer;
@property (nonatomic) NSUInteger repeatCount;
@end

@implementation AnimatorGroup
-(id) initWithAnimators: (NSArray *) animators {
    self = [super init];
    if(self){
        self.animators = animators;
    }
    return self;
}

-(void) animate: (CAShapeLayer *) layer { [self animate:layer repeat:0]; }
-(void) animate: (CAShapeLayer *) layer repeat: (NSUInteger) repeatCount {
    CGFloat beginTime = CACurrentMediaTime();
    NSUInteger index = 0;
    NSUInteger count = self.animators.count;
    self.repeatCount = repeatCount;
    self.animatingLayer = layer;
    for( id<Animator> animator in self.animators) {
        if(index+1 == count) [animator animate: layer from: beginTime delegate: self];
        else [animator animate: layer from: beginTime delegate: nil];
        beginTime += [animator time];
        index += 1;
    }
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    if(flag){
        [self.animatingLayer removeAllAnimations];
        self.animatingLayer.sublayers = nil;
        if(self.repeatCount > 0) [self animate:self.animatingLayer repeat:self.repeatCount-1];
        else self.animatingLayer = nil;
    }
}

@end
