//
//  JSAnnotation.h
//  JesseMapView
//
//  Created by Jesse Sahli on 7/15/16.
//  Copyright © 2016 sahlitude. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface JSAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *urlString;

- (instancetype)initWithCoord: (CLLocationCoordinate2D) coord;

@end
