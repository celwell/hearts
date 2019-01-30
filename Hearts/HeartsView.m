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
    NSBezierPath *topLeftArcPath, *topRightArcPath, *rectPath;
    NSRect rect;
    NSSize screenSize;
    NSPoint point;
    // color values (0 - 1)
    float red, green, blue, alpha;
    float edgeLength, radius, sqLen;
    
    screenSize = [self bounds].size;
    edgeLength = SSRandomFloatBetween(screenSize.width / 100.0,
                                            screenSize.width / 10.0);
    rect.size = NSMakeSize(edgeLength, edgeLength);
    // calculate random origin point
    rect.origin = SSRandomPointForSizeWithinRect(rect.size, [self bounds]);
    
    // arc dimensions common to both heart arcs
    sqLen = 1.4142135 * (rect.size.width / 4);
    radius = rect.size.width / 2;
    
    // top-left heart arc
    topLeftArcPath = [NSBezierPath bezierPath];
    // center point of top-left heart arc
    point = NSMakePoint(rect.origin.x - sqLen,
                        rect.origin.y + sqLen );
    [topLeftArcPath appendBezierPathWithArcWithCenter: point
                                     radius: radius
                                 startAngle: 45.0
                                   endAngle: 225.0
                                  clockwise: 0];
    
    // top-right heart arc
    topRightArcPath = [NSBezierPath bezierPath];
    // center point of top-right heart arc
    point = NSMakePoint(rect.origin.x + sqLen,
                        rect.origin.y + sqLen );
    [topRightArcPath appendBezierPathWithArcWithCenter: point
                                     radius: radius
                                 startAngle: 135.0
                                   endAngle: 315.0
                                  clockwise: 1];
    
    // rotated square to create body of heart
    rectPath = [NSBezierPath bezierPathWithRect:rect];
    NSAffineTransform * transform = [NSAffineTransform transform];
    [transform translateXBy: rect.origin.x yBy: rect.origin.y];
    [transform rotateByDegrees:45.0];
    [transform translateXBy: (-1 * rect.origin.x) yBy: (-1 * rect.origin.y)];
    rectPath = [transform transformBezierPath:rectPath];
    // I assume there is some way to add this to the prior transform, anyways...
    transform = [NSAffineTransform transform];
    // not quite -1.414 because we want the anti-aliasing to overlap slightly
    // this could be improved...
    [transform translateXBy: 0 yBy: (-1.411 * radius)];
    rectPath = [transform transformBezierPath:rectPath];
    
    // 50:50 chance of pink or black heart
    if (SSRandomIntBetween( 0, 1 ) == 0) {
        // 50:50 chance of light pink or medium pink heart
        if (SSRandomIntBetween( 0, 1 ) == 0) {
            // light pink
            red = 255.0 / 255.0;
            green = 159.0 / 255.0;
            blue = 243.0 / 255.0;
        } else {
            // medium pink
            red = 243.0 / 255.0;
            green = 104.0 / 255.0;
            blue = 224.0 / 255.0;
        }
    } else {
        // black
        red = green = blue = 0;
    }
    
    // hearts have randomized transparency
    alpha = SSRandomFloatBetween( 160.0, 255.0 ) / 255.0;
    
    // set color of the heart
    [[NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha] set];
    
    // fill all the paths for this heart
    [topLeftArcPath fill];
    [topRightArcPath fill];
    [rectPath fill];
    
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
