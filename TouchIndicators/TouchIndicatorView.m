//
//  TouchIndicatorView.m
//  Pods
//
//  Created by Andrew Charkin on 11/26/13.
//
//

#import "TouchIndicatorView.h"
#import "AnimatorGroup.h"
#import "TapAnimator.h"
#import "UnTapAnimator.h"
#import "DragAnimator.h"
#import <QuartzCore/QuartzCore.h>

@interface TouchIndicatorView()
@property (nonatomic) TouchActionType action;
@property (nonatomic) CGSize size;
@end

@implementation TouchIndicatorView

-(id) initWithSize: (CGSize) size action: (TouchActionType) action {
    self = [super init];
    if(self){
        self.action = action;
        self.size = size;
    }
    return self;
}

-(void) stopAnimation {
    self.layer.sublayers = nil;
}

-(void) startAnimation {
    Class animator;
    switch(self.action){
        case TouchActionTypeDragNorth: animator = [DragNorthAnimator class]; break;
        case TouchActionTypeDragSouth: animator = [DragSouthAnimator class]; break;
        case TouchActionTypeDragEast: animator = [DragEastAnimator class]; break;
        case TouchActionTypeDragWest: animator = [DragWestAnimator class]; break;
        case TouchActionTypeDragNorthEast: animator = [DragNorthEastAnimator class]; break;
        case TouchActionTypeDragNorthWest: animator = [DragNorthWestAnimator class]; break;
        case TouchActionTypeDragSouthEast: animator = [DragSouthEastAnimator class]; break;
        case TouchActionTypeDragSouthWest: animator = [DragSouthWestAnimator class]; break;
        default: break;
    }
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:MIN(self.size.width/2,self.size.height/2)].CGPath;
    circle.position = CGPointMake(self.size.width/2, self.size.height/2);
    circle.bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    circle.anchorPoint = CGPointMake(.5, .5f);
    circle.strokeStart = 0.f;
    circle.strokeEnd = 1.f;
    circle.opacity = 0.f;
    circle.shadowOffset = CGSizeZero;
    circle.fillColor = [UIColor colorWithRed:40.f/255.f green:167.f/255.f blue:246.f/255.f alpha:.8f].CGColor;
    [self.layer addSublayer:circle];
    
    AnimatorGroup *group = [[AnimatorGroup alloc] initWithAnimators: @[[TapAnimator class], animator, [UnTapAnimator class]]];
    [group animate: circle repeat:3];
}


@end
