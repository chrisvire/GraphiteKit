//
//  GrFontCatalog.m
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/18/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import "GrFontCatalog.h"
#import "graphite2/Font.h"

@interface GrFontCatalog ()
@property NSMutableDictionary *graphiteFonts;
@property NSMutableDictionary *altNames;
@end

@implementation GrFontCatalog
+(id) userFontCatalog
{
    static GrFontCatalog *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [GrFontCatalog new];
        NSFileManager *fileManager = [NSFileManager new];
        NSError *error = nil;
        
        NSURL *usrLibraryDir = [fileManager URLForDirectory:NSLibraryDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:&error];
        NSURL *usrFontsDir = [usrLibraryDir URLByAppendingPathComponent:@"Fonts"];
        
        NSArray *files = [fileManager contentsOfDirectoryAtURL:usrFontsDir includingPropertiesForKeys:[NSArray array] options:0 error:&error];
        NSPredicate *ttfFilter = [NSPredicate predicateWithFormat:@"pathExtension==[c]'ttf'"];
        NSArray *ttfFiles = [files filteredArrayUsingPredicate:ttfFilter];
        
        for (NSURL *file in ttfFiles) {
            gr_face *face = gr_make_file_face([[file path] UTF8String], gr_face_default);
            NSLog(@"Face:file=%@ face=%p", file, face);
            if (face) {
                NSString *name = [[[file lastPathComponent] stringByDeletingPathExtension] lowercaseString];
                NSLog(@"Cat: name=%@, file=%@", name, file);
                [user.graphiteFonts setValue:file forKey:name];
                gr_face_destroy(face);
            }
        }
    });
   
    return user;
}

-(NSMutableDictionary *)loadAlternateNames
{
    NSFileManager *fileManager = [NSFileManager new];
    NSURL *libraryDir = [fileManager URLForDirectory:NSLibraryDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *appSupportDir = [libraryDir URLByAppendingPathComponent:@"Application Support"];
    NSURL *silDir = [appSupportDir URLByAppendingPathComponent:@"SIL"];
    NSURL *graphiteDir = [silDir URLByAppendingPathComponent:@"Graphite"];
    if ([fileManager createDirectoryAtURL:graphiteDir withIntermediateDirectories:YES attributes:nil error:nil]) {
        NSURL *altNamesFile = [graphiteDir URLByAppendingPathComponent:@"Alternate Names.plist" isDirectory:NO];
        NSMutableDictionary *altNames = nil;
        if ([fileManager fileExistsAtPath:[altNamesFile path]]) {
            altNames = [NSMutableDictionary dictionaryWithContentsOfURL:altNamesFile];
        } else {
            altNames = [NSMutableDictionary dictionaryWithDictionary:
                         @{
                         @"gentium plus" : @"gentiumplus-r",
                         @"padauk book" : @"padauk-book",
                         @"andika" : @"andika-r",
                         @"charis sil" : @"charissil-r",
                         @"doulos sil" : @"doulossil-r",
                         @"sophia nubian" : @"snr",
                         @"abyssinica sil" : @"abyssinicasil-r"
                         }];
            [altNames writeToURL:altNamesFile atomically:YES];
        }
        
        return altNames;
    }

    return [NSMutableDictionary dictionary];
}


-(id) init
{
    self = [super init];
    if (self) {
        _graphiteFonts = [NSMutableDictionary dictionary];
        _altNames = [self loadAlternateNames];
    }
    
    return self;
}

-(NSURL *)URLForGraphiteFontByFamilyName:(NSString *)fontName
{
    NSString *key = [fontName lowercaseString];
    NSURL *path = [self.graphiteFonts objectForKey:key];
    if (path == nil) {
        // Check altername names
        NSString *altKey = [self.altNames valueForKey:key];
        if (altKey) {
            path = [self.graphiteFonts objectForKey:altKey];
        }
    }
    
    return path;
}

@end
