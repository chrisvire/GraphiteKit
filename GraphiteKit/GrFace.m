//
//  GrFace.m
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/23/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import "GrFace.h"

@interface GrFace ()
{
    gr_face *gr_face;
}

@end

@implementation GrFace
-(id) initWithURL:(NSURL *)url
{
    self = [super init];
    if (self)
    {
        self->gr_face = gr_make_file_face([[url path] UTF8String], gr_face_default);
    }
    
    return self;
}

- (void)dealloc
{
    if (self->gr_face != NULL)
    {
        gr_face_destroy(self->gr_face), self->gr_face = NULL;
    }
}

-(gr_face *) gr_face
{
    return self->gr_face;
}

@end
