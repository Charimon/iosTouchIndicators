//
//  DragAnimator.h
//  TouchIndicators
//
//  Created by Andrew Charkin on 11/27/13.
//  Copyright (c) 2013 Charimon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animator.h"

@interface DragAnimator: NSObject<Animator> @end
@interface DragNorthAnimator: DragAnimator @end
@interface DragSouthAnimator: DragAnimator @end
@interface DragEastAnimator: DragAnimator @end
@interface DragWestAnimator: DragAnimator @end
@interface DragNorthWestAnimator: DragAnimator @end
@interface DragNorthEastAnimator: DragAnimator @end
@interface DragSouthWestAnimator: DragAnimator @end
@interface DragSouthEastAnimator: DragAnimator @end