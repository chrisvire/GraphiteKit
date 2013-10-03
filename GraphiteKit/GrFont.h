//
//  GrFont.h
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/20/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrFont : NSObject
-(id) initWithURl:(NSURL *)url pointSize:(CGFloat)size;
@property(nonatomic, readonly) gr_face *gr_face;
@property(nonatomic, readonly) gr_font *gr_font;
@end
