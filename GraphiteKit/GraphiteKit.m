//
//  GraphiteKit.m
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/17/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import "GraphiteKit.h"
#import "GrGlyphGenerator.h"
#import "GrLayoutManager.h"

@interface GraphiteKit ()

@end

@implementation GraphiteKit
+ (NSGlyphGenerator *)sharedGlyphGenerator
{
    static GrGlyphGenerator *sharedGrGlyphGenerator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"Creating Shared Graphite Glyph Generator");
        sharedGrGlyphGenerator = [GrGlyphGenerator new];
    });
    
    return sharedGrGlyphGenerator;
}

+ (NSLayoutManager *)newLayoutManagerWithZone:(NSZone *)zone
{
    return [[GrLayoutManager allocWithZone:zone] init];
}
@end
