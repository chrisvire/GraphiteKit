//
//  GrLine.h
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/25/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct GrGlyphInfo
{
    size_t gid;
    CGFloat x;
    CGFloat y;
    size_t firstChar;
    size_t lastChar;
    BOOL base;
} GrGlyphInfo;

@interface GrLine : NSObject
+ (void)setLine:(GrLine *)line forGlyphStorage:(id<NSGlyphStorage>)glyphStorage;
+ (GrLine *)lineForGlyphStorage:(id<NSGlyphStorage>)glyphStorage;
- (id)initWithCapacity:(NSUInteger)numItems;
- (GrGlyphInfo *)glyphInfoAtIndex:(NSUInteger)index;
- (NSUInteger)countOfGlyphInfo;
@end
