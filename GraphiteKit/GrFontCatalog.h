//
//  GrFontCatalog.h
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/18/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrFontCatalog : NSObject
+(id) userFontCatalog;
-(NSURL *) URLForGraphiteFontByFamilyName:(NSString *)fontName;
@end
