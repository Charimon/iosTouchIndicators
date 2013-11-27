//
//  TouchIndicatorView.h
//  Pods
//
//  Created by Andrew Charkin on 11/26/13.
//
//

#import <UIKit/UIKit.h>
#import "TouchConstants.h"

@interface TouchIndicatorView : UIView
-(void) startAnimation;
-(void) stopAnimation;
-(id) initWithSize: (CGSize) size action: (TouchActionType) action;
@end
