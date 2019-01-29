//
//  HeartsView.m
//  Hearts
//
//  Created by Christopher Elwell on 1/28/19.
//  Copyright © 2019 Christopher Elwell. All rights reserved.
//

#import "HeartsView.h"

@implementation HeartsView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/10.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    NSBezierPath *path, *path2, *path3;
    NSRect rect;
    NSSize screenSize;
    NSColor *color;
    float alpha;

    screenSize = [self bounds].size;
    
    float edgeLength = SSRandomFloatBetween(screenSize.width / 100.0,
                                            screenSize.width / 10.0);
    
    rect.size = NSMakeSize(edgeLength, edgeLength);
    // Calculate random origin point
    rect.origin = SSRandomPointForSizeWithinRect( rect.size, [self bounds] );
    
    float startAngle, endAngle, radius;
    NSPoint point;
    
    path = [NSBezierPath bezierPath];
    startAngle = 45.0;
    endAngle = 225.0;
    radius = rect.size.width / 2;
    // Calculate our center point
    
    //a = radius /2
    float sqLen = 1.4142135 * (rect.size.width / 4);
    
    point = NSMakePoint(rect.origin.x - sqLen,
                        rect.origin.y + sqLen );
    [path appendBezierPathWithArcWithCenter: point
                                     radius: radius
                                 startAngle: startAngle
                                   endAngle: endAngle
                                  clockwise: 0];
    
    path2 = [NSBezierPath bezierPath];
    startAngle = 135.0;
    endAngle = 315.0;
    radius = rect.size.width / 2;
    // Calculate our center point
    point = NSMakePoint(rect.origin.x + sqLen,
                        rect.origin.y + sqLen );
    [path2 appendBezierPathWithArcWithCenter: point
                                     radius: radius
                                 startAngle: startAngle
                                   endAngle: endAngle
                                  clockwise: 1];
    
    path3 = [NSBezierPath bezierPathWithRect:rect];
    NSAffineTransform * transform = [NSAffineTransform transform];
    [transform translateXBy: rect.origin.x yBy: rect.origin.y];
    [transform rotateByDegrees:45.0];
    [transform translateXBy: (-1 * rect.origin.x) yBy: (-1 * rect.origin.y)];
    path3 = [transform transformBezierPath:path3];
    transform = [NSAffineTransform transform];
    [transform translateXBy: 0 yBy: (-1.414 * radius)];
    path3 = [transform transformBezierPath:path3];
    
    
    alpha = SSRandomFloatBetween( 160.0, 255.0 ) / 255.0;
    
    if (SSRandomIntBetween( 0, 1 ) == 0)
        if (SSRandomIntBetween( 0, 1 ) == 0)
            color = [NSColor colorWithCalibratedRed:(255.0 / 255.0)
                                              green:(159.0 / 255.0)
                                               blue:(243.0 / 255.0)
                                              alpha:alpha];
        else
            color = [NSColor colorWithCalibratedRed:(243.0 / 255.0)
                                          green:(104.0 / 255.0)
                                           blue:(224.0 / 255.0)
                                          alpha:alpha];
    else
        color = [NSColor colorWithCalibratedRed:0
                                          green:0
                                           blue:0
                                          alpha:alpha];
    
    [color set];
    [path fill];
    [path2 fill];
    [path3 fill];
    
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
