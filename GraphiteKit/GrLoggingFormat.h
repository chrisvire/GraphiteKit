//
//  LSLoggingIndent.h
//  GraphiteTest
//
//  Created by Chris Hubbard on 7/15/13.
//  Copyright (c) 2013 SIL International. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrLoggingFormat : NSObject
+ (NSString *)enterFormat;
+ (NSString *)leaveFormat;
+ (NSString *)defaultFormat;
+ (NSString *)lineNumberFormat:(int)lineNumber;
@end
