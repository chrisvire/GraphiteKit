//
//  GrGlyphGenerator.h
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/18/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GrGlyphGenerator : NSGlyphGenerator
@property(nonatomic, copy) NSString *language;
@property(nonatomic, copy) NSDictionary *features;
@end
