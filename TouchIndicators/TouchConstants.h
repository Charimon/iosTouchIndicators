//
//  TouchConstants.h
//  Pods
//
//  Created by Andrew Charkin on 11/26/13.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TouchActionType) {
    TouchActionTypeNone,
    TouchActionTypeDragNorth,
    TouchActionTypeDragSouth,
    TouchActionTypeDragEast,
    TouchActionTypeDragWest,
    TouchActionTypeDragNorthEast,
    TouchActionTypeDragNorthWest,
    TouchActionTypeDragSouthEast,
    TouchActionTypeDragSouthWest,
    TouchActionTypeTap,
    TouchActionTypeDoubleTap
};