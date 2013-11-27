//
//  Animator.h
//  TouchIndicators
//
//  Created by Andrew Charkin on 11/26/13.
//  Copyright (c) 2013 Charimon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@protocol Animator <NSObject>
+(CGFloat) time;
+(void) animate: (CAShapeLayer *) layer;
+(void) animate: (CAShapeLayer *) layer from: (CGFloat) time delegate: (id) delegate;
@end
