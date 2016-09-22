//
//  JSAnnotation.m
//  JesseMapView
//
//  Created by Jesse Sahli on 7/15/16.
//  Copyright © 2016 sahlitude. All rights reserved.
//

#import "JSAnnotation.h"

@implementation JSAnnotation

- (instancetype)initWithCoord: (CLLocationCoordinate2D) coord
{
    self = [super init];
    if (self) {
        _coordinate = coord;
    }
    return self;
}

@end
