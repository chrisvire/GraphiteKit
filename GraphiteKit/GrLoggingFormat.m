//
//  LSLoggingIndent.m
//  GraphiteTest
//
//  Created by Chris Hubbard on 7/15/13.
//  Copyright (c) 2013 SIL International. All rights reserved.
//

#import "GrLoggingFormat.h"

NSString *const kIndentLevel = @"GrLoggingFormatIndentLevel";

@implementation GrLoggingFormat
+ (int)indentLevel
{
    id indent = [[[NSThread currentThread] threadDictionary] valueForKey:kIndentLevel];
    if (indent == nil) {
        return 0;
    }
    return [indent unsignedShortValue];
}
+ (void) setIndentLevel:(int)indent
{
    id indentValue = @(indent);
    [[[NSThread currentThread] threadDictionary] setValue:indentValue forKey:kIndentLevel];
}
+ (int)enterIndentLevel
{
    int indent = [self indentLevel];
    [self setIndentLevel:indent +1];
    return indent;
}
+ (int)leaveIndentLevel
{
    int indent = [self indentLevel];
    if (indent > 0) {
        --indent;
        [self setIndentLevel:indent];
    }
    return indent;
}
+ (NSString *)enterFormat
{
    int indent = [self enterIndentLevel];
    return [NSString stringWithFormat:@">%*s", indent *4, " "];
    //return @"==> ";
}
+ (NSString *)leaveFormat
{
    int indent = [self leaveIndentLevel];
    return [NSString stringWithFormat:@"<%*s", indent * 4, " "];
    //return @"<== ";
}
+ (NSString *)defaultFormat
{
    int indent = [self indentLevel];
    if (indent > 0) {
        //++indent;
    }
    return [NSString stringWithFormat:@" %*s", indent *4, " "];
    //return @"    ";
}
+ (NSString *)lineNumberFormat:(int)lineNumber
{
    int indent = [self indentLevel];
    return [NSString stringWithFormat:@"%*s%.4d", indent *4, " ", lineNumber];
}

@end
