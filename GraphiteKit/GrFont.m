//
//  GrFont.m
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/20/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import "GrFont.h"
#import "GrFace.h"

@interface GrFont ()
{
    gr_font *_font;
}
@property(nonatomic, strong) GrFace* face;
@end

@implementation GrFont

- (gr_font *) gr_font
{
    return self->_font;
}
- (gr_face *) gr_face
{
    return [self.face gr_face];
}

- (void)dealloc
{
    if (self->_font != NULL) {
        gr_font_destroy(self->_font), self->_font = NULL;
    }
}

+(NSCache *) faceCache
{
    static NSCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    
    return cache;
}

+(GrFace *)faceWithURL:(NSURL *)url
{
    NSCache *cache = [self faceCache];
    GrFace *face = [cache objectForKey:[url path]];
    if (!face) {
        face = [[GrFace alloc] initWithURL:url];
        [cache setObject:face forKey:[url path]];
    }
    
    return face;
}

-(id) initWithURl:(NSURL *)url pointSize:(CGFloat)size
{
    CGFloat dpi = 72.0;
    float ppm = size * dpi / 72.0;
    if(self = [super init]) {
        _face = [[self class] faceWithURL:url];
        _font = gr_make_font(ppm, [_face gr_face]);
    }
    
    return self;
}
@end
