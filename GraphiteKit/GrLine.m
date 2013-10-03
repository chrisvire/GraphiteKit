//
//  GrLine.m
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/25/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import "GrLine.h"
#import <objc/runtime.h>

static char LINE_KEY;

@implementation GrLine
{
    GrGlyphInfo *glyphs;
    NSUInteger glyphCount;
}

+ (void)setLine:(GrLine *)line forGlyphStorage:(id<NSGlyphStorage>)glyphStorage
{
    objc_setAssociatedObject(glyphStorage, &LINE_KEY, line, OBJC_ASSOCIATION_RETAIN);
}

+ (GrLine *)lineForGlyphStorage:(id<NSGlyphStorage>)glyphStorage
{
    return (GrLine *)objc_getAssociatedObject(glyphStorage, &LINE_KEY);
}


- (id)initWithCapacity:(NSUInteger)numItems
{
    if (self = [super init]) {
        // TODO: safe allocation!!!
        glyphs = (GrGlyphInfo *)malloc(sizeof(GrGlyphInfo)*numItems);
        glyphCount = numItems;
    }
    
    return self;
}


- (GrGlyphInfo *)glyphInfoAtIndex:(NSUInteger)index
{
    if (index >= glyphCount) {
        [NSException raise:NSInvalidArgumentException format:@"index should be less than count"];
    }
    return &glyphs[index];
}

- (NSUInteger)countOfGlyphInfo
{
    return glyphCount;
}
@end
