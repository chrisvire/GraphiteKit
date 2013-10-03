//
//  GrLayoutManager.m
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/26/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import "GrLayoutManager.h"
#import "GrLine.h"

@implementation GrLayoutManager
- (NSPoint)locationForGlyphAtIndex:(NSUInteger)glyphIndex
{
    NSPoint point = [super locationForGlyphAtIndex:glyphIndex];
    
    GrLine *line = [[GrLine class] lineForGlyphStorage:self];
    if (line) {
        if (glyphIndex < [line countOfGlyphInfo]) {
            GrGlyphInfo *info = [line glyphInfoAtIndex:glyphIndex];
            NSPoint newPoint = NSMakePoint(info->x, point.y);
            NSLog(@"Update Point[%lu]: old:%f,%f new:%f,%f", glyphIndex, point.x, point.y, newPoint.x, newPoint.y);
            point = newPoint;
        } else {
            NSLog(@"Error: glyphIndex=%lu >= line.countOfGlyphInfo:%lu", (unsigned long)glyphIndex, (unsigned long)[line countOfGlyphInfo]);
        }
        
    }
    
    return point;
}
@end
