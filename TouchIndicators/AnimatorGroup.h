//
//  TouchIndicatorGroup.h
//  Pods
//
//  Created by Andrew Charkin on 11/26/13.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface AnimatorGroup : NSObject
@property (strong, nonatomic) NSArray *animators;
-(void) animate: (CAShapeLayer *) layer;
-(void) animate: (CAShapeLayer *) layer repeat: (NSUInteger) repeat;
-(id) initWithAnimators: (NSArray *) animators;
@end
