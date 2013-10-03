//
//  GrGlyphGenerator.m
//  GraphiteKit
//
//  Created by Chris Hubbard on 9/18/13.
//  Copyright (c) 2013 Chris Hubbard. All rights reserved.
//

#import "GrGlyphGenerator.h"
#import "GrFontCatalog.h"
#import "GrFont.h"
#import "GrLine.h"

@implementation GrGlyphGenerator

- (void)generateGlyphsForGlyphStorage:(id <NSGlyphStorage>)glyphStorage
            desiredNumberOfCharacters:(NSUInteger)nChars
                           glyphIndex:(NSUInteger *)glyphIndex
                       characterIndex:(NSUInteger *)charIndex
{
    //[[NSGlyphGenerator sharedGlyphGenerator] generateGlyphsForGlyphStorage:glyphStorage desiredNumberOfCharacters:nChars glyphIndex:glyphIndex characterIndex:charIndex];
    //return;

    NSAttributedString *attrStr = [glyphStorage attributedString];
    
    NSRange maxRange = NSMakeRange(*charIndex, nChars);
    NSRange curRange;
    
    unichar buf[nChars];
    [[attrStr string] getCharacters:buf range:maxRange];
    
    NSDictionary *attributes = [attrStr attributesAtIndex:*charIndex longestEffectiveRange:&curRange inRange:maxRange];

    GrFont *font = [self fontForCharactersWithAttributes:attributes];
    NSLog(@"GrFont: %p", font);
    if (font == nil) {
        [[NSGlyphGenerator sharedGlyphGenerator] generateGlyphsForGlyphStorage:glyphStorage desiredNumberOfCharacters:nChars glyphIndex:glyphIndex characterIndex:charIndex];
        return;
    }
   
    // TODO: support features, bidi
    //?[glyphStorage layoutOptions] & NSWantsBidiLevels
    gr_segment *seg = gr_make_seg([font gr_font], [font gr_face], [self script], 0, gr_utf16, buf, nChars, gr_nobidi);
    
    unsigned int slotCount = gr_seg_n_slots(seg);
    
    NSUInteger i = 0;
    GrLine *line = [[GrLine alloc] initWithCapacity:slotCount];
    NSGlyph glyphs[slotCount];
    [[GrLine class] setLine:line forGlyphStorage:glyphStorage];
    
    for (const gr_slot *s = gr_seg_first_slot(seg); s; s = gr_slot_next_in_segment(s)) {
        GrGlyphInfo *gi = [line glyphInfoAtIndex:i];
        gi->gid = gr_slot_gid(s);
        gi->x = gr_slot_origin_X(s);
        gi->y = gr_slot_origin_Y(s);
        gi->firstChar = gr_slot_before(s);
        gi->lastChar = gr_slot_after(s);
        gi->base = gr_slot_attached_to(s) == NULL || gr_slot_can_insert_before(s) ? YES : NO;
        glyphs[i] = (NSGlyph) gi->gid;
        NSLog(@"glyph[%lu]: gid=%zu, loc=%f,%f, fc=%zu, lc=%zu, base=%d", i, gi->gid, gi->x, gi->y, gi->firstChar, gi->lastChar, gi->base);
        ++i;
    }
    gr_seg_destroy(seg);
    
    
    [glyphStorage insertGlyphs:glyphs length:slotCount forStartingGlyphAtIndex:*glyphIndex characterIndex:*charIndex];
    
}

- (gr_uint32) script
{
    gr_uint32 lang = 0;
    if (self.language) {
        lang = gr_str_to_tag([self.language UTF8String]);
    }
    return lang;
}

- (GrFont *)fontForCharactersWithAttributes: (NSDictionary *)attributes
{
    GrFont *font = nil;
    NSFont *fontAttr = [attributes valueForKey:NSFontAttributeName];
    NSString *name = [fontAttr familyName];
    CGFloat pointSize = [fontAttr pointSize];
    NSLog(@"Font:%@ FamilyName=%@", fontAttr, name);
    
    if (name) {
        GrFontCatalog *userCatalog = [GrFontCatalog userFontCatalog];
        NSURL *fontFile = [userCatalog URLForGraphiteFontByFamilyName:name];
        NSLog(@"Found:%@", fontFile);
        if (fontFile) {
            font = [[GrFont alloc] initWithURl:fontFile pointSize:pointSize];
        }
    }
    
    return font;
}
@end
