//
//  GraphiteKit.h
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/17/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrGlyphGenerator.h"

@interface GraphiteKit : NSObject
+(GrGlyphGenerator *) sharedGlyphGenerator;
+(NSLayoutManager *) newLayoutManagerWithZone:(NSZone *)zone;
@end
