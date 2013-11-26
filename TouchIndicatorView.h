//
//  TouchIndicatorView.h
//  Pods
//
//  Created by Andrew Charkin on 11/26/13.
//
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, TouchAction) {
    TouchActionNone,
    TouchActionDragNorth,
    TouchActionDragSouth,
    TouchActionDragEast,
    TouchActionDragWest,
    TouchActionDragNorthEast,
    TouchActionDragNorthWest,
    TouchActionDragSouthEast,
    TouchActionDragSouthWest,
    TouchActionTap,
    TouchActionDoubleTap
};


@interface TouchIndicatorView : UIView
-(void) startAnimation;
-(void) stopAnimation;
-(id) initWithSize: (CGSize) size destination: (TouchAction) action;
@end
