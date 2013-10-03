//
//  LSLayoutManagerStub.m
//  GraphiteTest
//
//  Created by Chris Hubbard on 7/10/13.
//  Copyright (c) 2013 SIL International. All rights reserved.
//

#import "GrLayoutManagerStub.h"
#import "graphite2/Segment.h"
#import <objc/runtime.h>

@implementation GrLayoutManagerDelegateStub

// This is sent whenever layout or glyphs become invalidated in a layout manager which previously had all layout complete.
- (void)layoutManagerDidInvalidateLayout:(NSLayoutManager *)sender
{
    DLogEnter(@"sender:%@", sender);
    DLogLeave();
}

// This is sent whenever a container has been filled.  This method can be useful for paginating.  The textContainer might be nil if we have completed all layout and not all of it fit into the existing containers.  The atEnd flag indicates whether all layout is complete.
- (void)layoutManager:(NSLayoutManager *)layoutManager didCompleteLayoutForTextContainer:(NSTextContainer *)textContainer atEnd:(BOOL)layoutFinishedFlag
{
    DLogEnter(@"container:%@ atEnd:%d", textContainer, layoutFinishedFlag);
    DLogLeave();
}

// This is sent right before layoutManager invalidates the layout due to textContainer changing geometry.  The receiver of this method can react to the geometry change and perform adjustments such as recreate the exclusion path.
- (void)layoutManager:(NSLayoutManager *)layoutManager textContainer:textContainer didChangeGeometryFromSize:(CGSize)oldSize
{
    DLogEnter(@"container:%@ oldSize:" FMT_SIZE, textContainer, PARAM_SIZE(oldSize));
    DLogLeave();
}


@end

@implementation GrLayoutManagerStub

// MARK: Helper objects

- (NSTextStorage *)textStorage
{
    DLogEnter();
    NSTextStorage *ts = [super textStorage];
    DLogLeave(@"%@", ts);
    return ts;
    
}

- (void)setTextStorage:(NSTextStorage *)textStorage
{
    DLogEnter("%@", textStorage);
    [super setTextStorage:textStorage];
    DLogLeave();
    
}
// The set method generally should not be called directly, but you may wish to override it.  Used to get and set the text storage.  The set method is called by NSTextStorage's addLayoutManager:/removeLayoutManager: methods.

- (NSAttributedString *)attributedString
{
    DLogEnter();
    NSAttributedString *as = [super attributedString];
    DLogLeave(@"%@", as);
    return as;
}
// Part of the NSGlyphStorage protocol, for use by the glyph generator.  For NSLayoutManager the attributed string is equivalent to the text storage.

- (void)replaceTextStorage:(NSTextStorage *)newTextStorage
{
    DLogEnter(@"%@", newTextStorage);
    [super replaceTextStorage:newTextStorage];
    DLogLeave();
}
// This method should be used instead of the primitive -setTextStorage: if you need to replace a NSLayoutManager's NSTextStorage with a new one, leaving all related objects intact.  This method deals with all the work of making sure the NSLayoutManager doesn't get deallocated and transferring all the NSLayoutManagers on the old NSTextStorage to the new one.

- (NSGlyphGenerator *)glyphGenerator
{
    DLogEnter();
    NSGlyphGenerator *gg = [super glyphGenerator];
    DLogLeave(@"%@", gg);
    return gg;
}

- (void)setGlyphGenerator:(NSGlyphGenerator *)glyphGenerator
{
    DLogEnter(@"%@", glyphGenerator);
    [super setGlyphGenerator:glyphGenerator];
    DLogLeave();
}
// By default an NSLayoutManager uses the shared default glyph generator.  Setting the glyph generator invalidates all glyphs and layout in the NSLayoutManager.

- (NSTypesetter *)typesetter
{
    DLogEnter();
    NSTypesetter *ts = [super typesetter];
    DLogLeave(@"%", ts);
    return ts;
}

- (void)setTypesetter:(NSTypesetter *)typesetter
{
    DLogEnter(@"%@", typesetter);
    [super setTypesetter:typesetter];
    DLogLeave();
}
// By default an NSLayoutManager uses the shared default typesetter.  Setting the typesetter invalidates all glyphs in the NSLayoutManager.  It can't just invalidate layout because the typesetter may have contributed to the actual glyphs as well (e.g. hyphenation).

- (id <NSLayoutManagerDelegate>)delegate
{
    DLogEnter();
    id<NSLayoutManagerDelegate> d = [super delegate];
    DLogLeave(@"%@", d);
    return d;
}

- (void)setDelegate:(id <NSLayoutManagerDelegate>)delegate
{
    DLogEnter(@"%@", delegate);
    [super setDelegate:delegate];
    DLogLeave();
}

// MARK: Text container

- (NSArray *)textContainers
{
    DLogEnter();
    NSArray *tc = [super textContainers];
    DLogLeave(@"%@", tc);
    return tc;
}

- (void)addTextContainer:(NSTextContainer *)container
{
    DLogEnter(@"%@", container);
    [super addTextContainer:container];
    DLogLeave();
}
// Add a container to the end of the array.  Must invalidate layout of all glyphs after the previous last container (i.e., glyphs that were not previously laid out because they would not fit anywhere).
- (void)insertTextContainer:(NSTextContainer *)container atIndex:(NSUInteger)index
{
    DLogEnter(@"container:%@ atIndex:%d", container, index);
    [super insertTextContainer:container atIndex:index];
    DLogLeave();
}
// Insert a container into the array before the container at index.  Must invalidate layout of all glyphs in the containers from the one previously at index to the last container.
- (void)removeTextContainerAtIndex:(NSUInteger)index
{
    DLogEnter(@"%d", index);
    [super removeTextContainerAtIndex:index];
    DLogLeave();
}
// Removes the container at index from the array.  Must invalidate layout of all glyphs in the container being removed and any containers which come after it.

- (void)textContainerChangedGeometry:(NSTextContainer *)container
{
    DLogEnter(@"%@", container);
    [super textContainerChangedGeometry:container];
    DLogLeave();
}
// Called by NSTextContainer whenever it changes size or shape.  Invalidates layout of all glyphs in container and all subsequent containers.

- (void)textContainerChangedTextView:(NSTextContainer *)container
{
    DLogEnter(@"%@", container);
    [super textContainerChangedTextView:container];
    DLogLeave();
}
// Called by NSTextContainer whenever its textView changes.  Used to keep notifications in sync.

// MARK: Global layout options
- (void)setBackgroundLayoutEnabled:(BOOL)flag
{
    DLogEnter(@"%d", flag);
    [super setBackgroundLayoutEnabled:flag];
    DLogLeave();
}
- (BOOL)backgroundLayoutEnabled
{
    DLogEnter();
    BOOL b = [super backgroundLayoutEnabled];
    DLogLeave(@"%d", b);
    return b;
}
// These methods allow you to set/query whether the NSLayoutManager will lay out text in the background, i.e. on the main thread when it is idle.  The default is YES, but this should be set to NO whenever the layout manager is being accessed from other threads.

- (void)setUsesScreenFonts:(BOOL)flag
{
    DLogEnter(@"%d", flag);
    [super setUsesScreenFonts:flag];
    DLogLeave();
}
- (BOOL)usesScreenFonts
{
    DLogEnter();
    BOOL b = [super usesScreenFonts];
    DLogLeave(@"%d", b);
}
// Sets whether this layoutManager will use screen fonts when it is possible to do so.  The default is YES, but this should be set to NO if the layout manager will be used to draw scaled or rotated text.



- (BOOL)showsInvisibleCharacters
{
    DLogEnter();
    BOOL b = [super showsInvisibleCharacters];
    DLogLeave(@"%d", b);
    return b;
}

- (void)setShowsInvisibleCharacters:(BOOL)showsInvisibleCharacters
{
    DLogEnter(@"%d", showsInvisibleCharacters);
    [super setShowsInvisibleCharacters:showsInvisibleCharacters];
    DLogLeave();
}

- (BOOL)showsControlCharacters
{
    DLogEnter();
    BOOL b = [super showsControlCharacters];
    DLogLeave(@"%d", b);
    return b;
}

- (void)setShowsControlCharacters:(BOOL)showsControlCharacters
{
    DLogEnter(@"%d", showsControlCharacters);
    [super setShowsControlCharacters:showsControlCharacters];
    DLogLeave();
}

- (CGFloat) hyphenationFactor
{
    DLogEnter();
    CGFloat f = [super hyphenationFactor];
    DLogLeave(@"%f", f);
    return f;
}

- (void)setHyphenationFactor:(CGFloat)hyphenationFactor
{
    DLogEnter(@"%f", hyphenationFactor);
    [super setHyphenationFactor:hyphenationFactor];
    DLogLeave();
}

- (void)setDefaultAttachmentScaling:(NSImageScaling)scaling
{
    DLogEnter(@"%d", scaling);
    [super setDefaultAttachmentScaling:scaling];
    DLogLeave();
}
- (NSImageScaling)defaultAttachmentScaling
{
    DLogEnter();
    NSImageScaling is = [super defaultAttachmentScaling];
    DLogLeave(@"%d", is);
    return is;
}
// Specifies the default behavior desired if an attachment image is too large to fit in a text container.  Note that attachment cells control their own size and drawing, so this setting can only be advisory for them, but kit-supplied attachment cells will respect it.  The default is NSImageScaleNone, meaning that images will clip rather than scaling.

- (void)setTypesetterBehavior:(NSTypesetterBehavior)theBehavior
{
    DLogEnter(@"%d", theBehavior);
    [super setTypesetterBehavior:theBehavior];
    DLogLeave();
}

- (NSTypesetterBehavior)typesetterBehavior
{
    DLogEnter();
    NSTypesetterBehavior tb = [super typesetterBehavior];
    DLogLeave(@"%d", tb);
    return tb;
}

// Specifies the typesetter behavior (compatibility setting) value for the layout manager.  The default is determined by the version of AppKit against which the application is linked.

- (NSUInteger)layoutOptions
{
    DLogEnter();
    NSUInteger val = [super layoutOptions];
    DLogLeave(@"%lu", val);
    return val;
}
// Part of the NSGlyphStorage protocol, for use by the glyph generator.  Allows the glyph generator to ask which options the layout manager requests.

- (void)setAllowsNonContiguousLayout:(BOOL)flag
{
    DLogEnter(@"%d", flag);
    [super setAllowsNonContiguousLayout:flag];
    DLogLeave();
}

- (BOOL)allowsNonContiguousLayout
{
    DLogEnter();
    BOOL val = [super allowsNonContiguousLayout];
    DLogLeave(@"%d", val);
    return val;
}
// If YES, then the layout manager may perform glyph generation and layout for a given portion of the text, without having glyphs or layout for preceding portions.  The default is NO.  Turning this setting on will significantly alter which portions of the text will have glyph generation or layout performed when a given generation-causing method is invoked.  It also gives significant performance benefits, especially for large documents.
- (BOOL)hasNonContiguousLayout
{
    DLogEnter();
    BOOL val = [super hasNonContiguousLayout];
    DLogLeave(@"%d", val);
    return val;
}
// Even if non-contiguous layout is allowed, it may not always be used, and there may not always be layout holes.  This method returns YES if there might currently be non-contiguous portions of the text laid out.


- (BOOL)usesFontLeading
{
    DLogEnter();
    BOOL b = [super usesFontLeading];
    DLogLeave(@"%d", b);
    return b;
}

- (void)setUsesFontLeading:(BOOL)usesFontLeading
{
    DLogEnter(@"%d", usesFontLeading);
    [super setUsesFontLeading:usesFontLeading];
    DLogLeave();
}


// MARK: Invalidation
// This removes all glyphs for the old character range, adjusts the character indices of all the subsequent glyphs by the change in length, and invalidates the new character range.  If actualCharRange is non-NULL it will be set to the actual range invalidated after any necessary expansion.
- (void)invalidateGlyphsForCharacterRange:(NSRange)charRange changeInLength:(NSInteger)delta actualCharacterRange:(NSRangePointer)actualCharRange
{
    DLogEnter(@"charRange:" FMT_RANGE " changeInLength:%d", PARAM_RANGE(charRange), delta);
    [super invalidateGlyphsForCharacterRange:charRange changeInLength:delta actualCharacterRange:actualCharRange];
    DLogLeave();
}

// This method invalidates the layout information for the given range of characters.  If actualCharRange is non-NULL it will be set to the actual range invalidated after any necessary expansion.
- (void)invalidateLayoutForCharacterRange:(NSRange)charRange actualCharacterRange:(NSRangePointer)actualCharRange
{
    DLogEnter(@"charRange:" FMT_RANGE, PARAM_RANGE(charRange));
    [super invalidateLayoutForCharacterRange:charRange actualCharacterRange:actualCharRange];
    DLogLeave();
}

// These methods invalidate display for the glyph or character range given.  For the character range variant, unlaid parts of the range are remembered and will be redisplayed at some point later when the layout is available.  For the glyph range variant any part of the range that does not yet have glyphs generated is ignored.  Neither method actually causes layout.
- (void)invalidateDisplayForCharacterRange:(NSRange)charRange
{
    DLogEnter(@"charRange:" FMT_RANGE, PARAM_RANGE(charRange));
    [super invalidateDisplayForCharacterRange:charRange];
    DLogLeave();
}
- (void)invalidateDisplayForGlyphRange:(NSRange)glyphRange
{
    DLogEnter(@"glyphRange:" FMT_RANGE, PARAM_RANGE(glyphRange));
    [super invalidateDisplayForGlyphRange:glyphRange];
    DLogLeave();
}

// MARK: Causing glyph generation and layout

// These methods allow clients to specify exactly the portions of the document for which they wish to have glyphs or layout.  This is particularly important if non-contiguous layout is enabled.  The layout manager still reserves the right to perform glyph generation or layout for larger ranges.  If non-contiguous layout is not enabled, then the range in question will always effectively be extended to start at the beginning of the text.
- (void)ensureGlyphsForCharacterRange:(NSRange)charRange
{
    DLogEnter(@"charRange:" FMT_RANGE, PARAM_RANGE(charRange));
    [super ensureGlyphsForCharacterRange:charRange];
    DLogLeave();
}
          
- (void)ensureGlyphsForGlyphRange:(NSRange)glyphRange
{
    DLogEnter(@"glyphRange:" FMT_RANGE, PARAM_RANGE(glyphRange));
    [super ensureGlyphsForGlyphRange:glyphRange];
    DLogLeave();
}

- (void)ensureLayoutForCharacterRange:(NSRange)charRange
{
    DLogEnter(@"charRange:" FMT_RANGE, PARAM_RANGE(charRange));
    [super ensureLayoutForCharacterRange:charRange];
    DLogLeave();
}

- (void)ensureLayoutForGlyphRange:(NSRange)glyphRange
{
    DLogEnter(@"glyphRange" FMT_RANGE, PARAM_RANGE(glyphRange));
    [super ensureLayoutForGlyphRange:glyphRange];
    DLogLeave();
}

- (void)ensureLayoutForTextContainer:(NSTextContainer *)container
{
    DLogEnter(@"container:%@", container);
    [super ensureLayoutForTextContainer:container];
    DLogLeave();
}

- (void)ensureLayoutForBoundingRect:(CGRect)bounds inTextContainer:(NSTextContainer *)container
{
    DLogEnter(@"bounds:" FMT_RECT " inTextContainer:%@", bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height, container);
    [super ensureLayoutForBoundingRect:bounds inTextContainer:container];
    DLogLeave();
}

// MARK: Set glyphs and glyph properties

// Sets the initial glyphs and properties for a character range.  This method is invoked mainly from the glyph generation process.  Only place apps are allowed to directly call this method is from -layoutManager:shouldGenerateGlyphs:properties:characterIndexes:forGlyphRange:.  Each array has glyphRange.length items.  charIndexes must be contiguous (no skipped indexes).  It allows multiple items to have a same character index (a character index generating multiple glyph IDs).  Due to the font substitution, aFont passed into this method might not match the font in the attributes dictionary.  Calling this method for a range with the layout information invalidates the layout and display.
- (void)setGlyphs:(const CGGlyph *)glyphs properties:(const NSGlyphProperty *)props characterIndexes:(const NSUInteger *)charIndexes font:(UIFont *)aFont forGlyphRange:(NSRange)glyphRange
{
    DLogEnter(@"range=" FMT_RANGE ", font=%@", PARAM_RANGE(glyphRange), [aFont familyName]);
    [super setGlyphs:glyphs properties:props characterIndexes:charIndexes font:aFont forGlyphRange:glyphRange];
    DLogLeave();
}

// MARK: Get glyphs and glyph properties

// Returns the total number of glyphs.  If non-contiguous layout is not enabled, this will force generation of glyphs for all characters.
- (NSUInteger) numberOfGlyphs
{
    DLogEnter(@"==>");
    NSUInteger count = [super numberOfGlyphs];
    DLogLeave(@"<== %d", count);
    return count;
}

// If non-contiguous layout is not enabled, these will cause generation of all glyphs up to and including glyphIndex.  The first glyphAtIndex variant returns kCGFontIndexInvalid if the requested index is out of the range (0, numberOfGlyphs), and optionally returns a flag indicating whether the requested index is in range.  The second glyphAtIndex variant raises a NSRangeError if the requested index is out of range.
- (CGGlyph)glyphAtIndex:(NSUInteger)glyphIndex isValidIndex:(BOOL *)isValidIndex
{
    DLogEnter(@"glyphAtIndex:%d", glyphIndex);
    CGGlyph g = [super glyphAtIndex:glyphIndex isValidIndex:isValidIndex];
    DLogLeave(@"isValidIndex:%d => %d", *isValidIndex, g);
    return g;
}

- (CGGlyph)glyphAtIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    CGGlyph g = [super glyphAtIndex:glyphIndex];
    DLogLeave(@"%d", g);
    return g;
}

- (BOOL)isValidGlyphIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    BOOL b = [super isValidGlyphIndex:glyphIndex];
    DLogLeave(@"%d", b);
    return b;
}

+ (NSString *)stringFromNSGlyphProperty:(NSGlyphProperty)prop
{
    static NSDictionary *strings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        strings =
        @{
          @(0) : @"None",
          @(NSGlyphPropertyNull) : @"NSGlyphPropertyNull",
          @(NSGlyphPropertyControlCharacter) : @"NSGlyphPropertyControlCharacter",
          @(NSGlyphPropertyElastic) : @"NSGlyphPropertyElastic",
          @(NSGlyphPropertyNonBaseCharacter) : @"NSGlyphPropertyNonBaseCharacter"
          };
    });
   
    return strings[@(prop)];
}
// If non-contiguous layout is not enabled, this will cause generation of all glyphs up to and including glyphIndex.  It will return the glyph property associated with the glyph at the specified index.
- (NSGlyphProperty)propertyForGlyphAtIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    NSGlyphProperty gp = [super propertyForGlyphAtIndex:glyphIndex];
    DLogLeave(@"%@", [[self class] stringFromNSGlyphProperty:gp]);
    return gp;
}

// If non-contiguous layout is not enabled, this will cause generation of all glyphs up to and including glyphIndex.  It will return the character index for the first character associated with the glyph at the specified index.
- (NSUInteger)characterIndexForGlyphAtIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    NSUInteger ci = [super characterIndexForGlyphAtIndex:glyphIndex];
    DLogLeave(@"%d", ci);
    return ci;
}

// If non-contiguous layout is not enabled, this will cause generation of all glyphs up to and including those associated with the specified character.  It will return the glyph index for the first glyph associated with the character at the specified index.
- (NSUInteger)glyphIndexForCharacterAtIndex:(NSUInteger)charIndex
{
    DLogEnter(@"charIndex:%d", charIndex);
    NSUInteger gi = [super glyphIndexForCharacterAtIndex:charIndex];
    DLogLeave(@"%d", gi);
    return gi;
}

// Fills a passed-in buffer with a sequence of CGGlyphs.  They will also optionally fill other passed-in buffers with the glyph properties, character indexes, and bidi levels corresponding to these glyphs.  Each pointer passed in should either be NULL, or else point to sufficient memory to hold glyphRange.length elements.  These methods return the number of glyphs filled in.
- (NSUInteger)getGlyphsInRange:(NSRange)glyphRange glyphs:(CGGlyph *)glyphBuffer properties:(NSGlyphProperty *)props characterIndexes:(NSUInteger *)charIndexBuffer bidiLevels:(unsigned char *)bidiLevelBuffer
{
    DLogEnter(@"range=" FMT_RANGE, PARAM_RANGE(glyphRange));
    NSUInteger count = [super getGlyphsInRange:glyphRange glyphs:glyphBuffer properties:props characterIndexes:charIndexBuffer bidiLevels:bidiLevelBuffer];
    DLogLeave(@"%d", count);
    return count;
}

// MARK: Set layout information

// Associates the given container with the given range of glyphs.  This method should be called by the typesetter first, before setting line fragment rect or any of the layout bits, for each range of glyphs it lays out.  This method will reset several key layout attributes (like not shown and draws outside line fragment) to their default values.  In the course of layout, all glyphs should end up being included in a range passed to this method.  The range passed in is not expected to be the entire range of glyphs for that text container; usually, in fact, it will be the range for a given line fragment being laid out in that container.
- (void)setTextContainer:(NSTextContainer *)container forGlyphRange:(NSRange)glyphRange
{
    DLogEnter(@"container:%@ forGlyphRange:" FMT_RANGE, container, PARAM_RANGE(glyphRange));
    [super setTextContainer:container forGlyphRange:glyphRange];
    DLogLeave();
}


// Associates the given line fragment bounds with the given range of glyphs.  The typesetter should call this method second, after setting the line fragment rect and before setting the location or any of the layout bits.  In the course of layout, all glyphs should end up being included in a range passed to this method, but only glyphs which start a new line fragment should be at the start of such ranges.  Line fragment rects and line fragment used rects are always in container coordinates.
- (void)setLineFragmentRect:(CGRect)fragmentRect forGlyphRange:(NSRange)glyphRange usedRect:(CGRect)usedRect
{
    DLogEnter(@"fragmentRect:" FMT_RECT " forGlyphRange:" FMT_RANGE " usedRect:" FMT_RECT, PARAM_RECT(fragmentRect), PARAM_RANGE(glyphRange), PARAM_RECT(usedRect));
    [super setLineFragmentRect:fragmentRect forGlyphRange:glyphRange usedRect:usedRect];
    DLogLeave();
}


// Sets the bounds and container for the extra line fragment.  The extra line fragment is used when the text backing ends with a hard line break or when the text backing is totally empty, to define the extra line which needs to be displayed at the end of the text.  If the text backing is not empty and does not end with a hard line break, this should be set to NSZeroRect and nil.  Line fragment rects and line fragment used rects are always in container coordinates.
- (void)setExtraLineFragmentRect:(CGRect)fragmentRect usedRect:(CGRect)usedRect textContainer:(NSTextContainer *)container
{
    DLogEnter(@"fragmentRect:" FMT_RECT " usedRect:" FMT_RECT " textContainer:%@", PARAM_RECT(fragmentRect), PARAM_RECT(usedRect), container);
    [super setExtraLineFragmentRect:fragmentRect usedRect:usedRect textContainer:container];
    DLogLeave();
}


// Sets the location for the first glyph of the given range.  Setting the location for a glyph range implies that its first glyph is not nominally spaced with respect to the previous glyph.  In the course of layout, all glyphs should end up being included in a range passed to this method, but only glyphs which start a new nominal range should be at the start of such ranges.  The first glyph in a line fragment should always start a new nominal range.  Glyph locations are given relative to their line fragment rect's origin.
- (void)setLocation:(CGPoint)location forStartOfGlyphRange:(NSRange)glyphRange
{
    DLogEnter(@"location:" FMT_POINT " forStartOfGlyphRange:" FMT_RANGE, PARAM_POINT(location), PARAM_RANGE(glyphRange));
    [super setLocation:location forStartOfGlyphRange:glyphRange];
    DLogLeave();
}


// Some glyphs are not shown.  The typesetter decides which ones and sets this attribute in the layout manager to ensure that those glyphs will not be displayed.
- (void)setNotShownAttribute:(BOOL)flag forGlyphAtIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"notShownAttribute:%d forGlyphAtIndex:%d", flag, glyphIndex);
    [super setNotShownAttribute:flag forGlyphAtIndex:glyphIndex];
    DLogLeave();
}


// Used to indicate that a particular glyph for some reason will draw outside of its line fragment rect.  This can commonly happen if a fixed line height is used (consider a 12 point line height and a 24 point glyph).  This information is important for determining whether additional lines need to be redrawn as a result of changes to any given line fragment.
- (void)setDrawsOutsideLineFragment:(BOOL)flag forGlyphAtIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"drawOutsideLineFragment:%d forGlyphAtIndex:%d", flag, glyphIndex);
    [super setDrawsOutsideLineFragment:flag forGlyphAtIndex:glyphIndex];
    DLogLeave();
}


// For a glyph corresponding to an attachment, this method should be called to set the size the attachment cell will occupy.
- (void)setAttachmentSize:(CGSize)attachmentSize forGlyphRange:(NSRange)glyphRange
{
    DLogEnter(@"attachmentSize:" FMT_SIZE " forGlyphRange:" FMT_RANGE, PARAM_SIZE(attachmentSize), PARAM_RANGE(glyphRange));
    [super setAttachmentSize:attachmentSize forGlyphRange:glyphRange];
    DLogLeave();
}

// MARK: Get layout information

// Returns (by reference for the "get" method) the character index or glyph index or both of the first unlaid character/glyph in the layout manager at this time.
- (void)getFirstUnlaidCharacterIndex:(NSUInteger *)charIndex glyphIndex:(NSUInteger *)glyphIndex
{
    DLogEnter();
    [super getFirstUnlaidCharacterIndex:charIndex glyphIndex:glyphIndex];
    DLogLeave(@"charIndex:%d glyphIndex:%d", PARAM_OPT_INT(charIndex), PARAM_OPT_INT(glyphIndex));
}

- (NSUInteger)firstUnlaidCharacterIndex
{
    DLogEnter();
    NSUInteger ci = [super firstUnlaidCharacterIndex];
    DLogLeave(@"%d", ci);
    return ci;
}

- (NSUInteger)firstUnlaidGlyphIndex
{
    DLogEnter();
    NSUInteger ci = [super firstUnlaidGlyphIndex];
    DLogLeave(@"%d", ci);
    return ci;
}

// Returns the container in which the given glyph is laid and (optionally) by reference the whole range of glyphs that are in that container.  This will cause glyph generation and layout for the line fragment containing the specified glyph, or if non-contiguous layout is not enabled, up to and including that line fragment; if non-contiguous layout is not enabled and effectiveGlyphRange is non-NULL, this will additionally cause glyph generation and layout for the entire text container containing the specified glyph.
- (NSTextContainer *)textContainerForGlyphAtIndex:(NSUInteger)glyphIndex effectiveRange:(NSRangePointer)effectiveGlyphRange
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    NSTextContainer *tc = [super textContainerForGlyphAtIndex:glyphIndex effectiveRange:effectiveGlyphRange];
    DLogLeave(@"effectiveRange:" FMT_RANGE " ==>%@", PARAM_RANGE(PARAM_OPT_RANGE(effectiveGlyphRange)), tc);
    return tc;
}


// Returns the container's currently used area.  This determines the size that the view would need to be in order to display all the glyphs that are currently laid into the container.  This causes neither glyph generation nor layout.  Used rects are always in container coordinates.
- (CGRect)usedRectForTextContainer:(NSTextContainer *)container
{
    DLogEnter(@"container: %@", container);
    CGRect r = [super usedRectForTextContainer:container];
    DLogLeave(@"" FMT_RECT, PARAM_RECT(r));
    return r;
}


// Returns the rect for the line fragment in which the given glyph is laid and (optionally) by reference the whole range of glyphs that are in that fragment.  This will cause glyph generation and layout for the line fragment containing the specified glyph, or if non-contiguous layout is not enabled, up to and including that line fragment.  Line fragment rects are always in container coordinates.
- (CGRect)lineFragmentRectForGlyphAtIndex:(NSUInteger)glyphIndex effectiveRange:(NSRangePointer)effectiveGlyphRange
{
    DLogEnter(@"glyphIndex=%d", glyphIndex);
    CGRect r = [super lineFragmentRectForGlyphAtIndex:glyphIndex effectiveRange:effectiveGlyphRange];
    DLogLeave(@"effectiveGlyphRange:" FMT_RANGE " ==>" FMT_RECT, PARAM_RANGE(PARAM_OPT_RANGE(effectiveGlyphRange)), PARAM_RECT(r));
    return r;
}


// Returns the usage rect for the line fragment in which the given glyph is laid and (optionally) by reference the whole range of glyphs that are in that fragment.  This will cause glyph generation and layout for the line fragment containing the specified glyph, or if non-contiguous layout is not enabled, up to and including that line fragment.  Line fragment used rects are always in container coordinates.
- (CGRect)lineFragmentUsedRectForGlyphAtIndex:(NSUInteger)glyphIndex effectiveRange:(NSRangePointer)effectiveGlyphRange
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    CGRect r = [super lineFragmentUsedRectForGlyphAtIndex:glyphIndex effectiveRange:effectiveGlyphRange];
    DLogLeave(@"effectiveGlyphRange:" FMT_RANGE " ==>" FMT_RECT, PARAM_RANGE(PARAM_OPT_RANGE(effectiveGlyphRange)), PARAM_RECT(r));
    return r;
}

// Return info about the extra line fragment.  The extra line fragment is used for displaying the line at the end of document when the last character in the document causes a line or paragraph break.  Since the extra line is not associated with any glyph inside the layout manager, the information is handed separately from other line fragment rects.  Typically the extra line fragment is placed in the last document content text container along with other normal line fragment rects.  Line fragment rects and line fragment used rects are always in container coordinates.
- (CGRect) extraLineFragmentRect
{
    DLogEnter();
    CGRect r = [super extraLineFragmentRect];
    DLogLeave(@"" FMT_RECT, PARAM_RECT(r));
    return r;
}

- (CGRect)extraLineFragmentUsedRect
{
    DLogEnter();
    CGRect r = [super extraLineFragmentUsedRect];
    DLogLeave(@"" FMT_RECT, PARAM_RECT(r));
    return r;
}

- (NSTextContainer *)extraLineFragmentTextContainer
{
    DLogEnter();
    NSTextContainer *tc = [super extraLineFragmentTextContainer];
    DLogLeave(@"%@", tc);
    return tc;
}

// Returns the location for the given glyph within its line fragment.  If this glyph does not have an explicit location set for it (i.e., it is part of (but not first in) a sequence of nominally spaced characters), the location is calculated by glyph advancements from the location of the most recent preceding glyph with a location set.  Glyph locations are relative to their line fragment rect's origin.  This will cause glyph generation and layout for the line fragment containing the specified glyph, or if non-contiguous layout is not enabled, up to and including that line fragment.
- (CGPoint)locationForGlyphAtIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    CGPoint p = [super locationForGlyphAtIndex:glyphIndex];
    DLogLeave(@"" FMT_POINT, PARAM_POINT(p));
    return p;
}


// Some glyphs are not shown.  This method returns whether the given glyph has been designated as not shown.  This will cause glyph generation and layout for the line fragment containing the specified glyph, or if non-contiguous layout is not enabled, up to and including that line fragment.
- (BOOL)notShownAttributeForGlyphAtIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    BOOL b = [super notShownAttributeForGlyphAtIndex:glyphIndex];
    DLogLeave(@"%d", b);
    return b;
}


// Returns whether the glyph will draw outside of its line fragment rect.  This will cause glyph generation and layout for the line fragment containing the specified glyph, or if non-contiguous layout is not enabled, up to and including that line fragment.
- (BOOL)drawsOutsideLineFragmentForGlyphAtIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    BOOL b = [super drawsOutsideLineFragmentForGlyphAtIndex:glyphIndex];
    DLogLeave("%d", b);
    return b;
}


// For a glyph corresponding to an attachment, this method returns the size the attachment cell will occupy.  Returns {-1,-1} if no attachment size has been set for the specified glyph.
- (CGSize)attachmentSizeForGlyphAtIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    CGSize s = [super attachmentSizeForGlyphAtIndex:glyphIndex];
    DLogLeave(@"" FMT_SIZE, PARAM_SIZE(s));
    return s;
}



// Returns a range of truncated glyph range for a line fragment containing the specified index.  When there is no truncation for the line fragment, it returns {NSNotFound, 0}.
- (NSRange)truncatedGlyphRangeInLineFragmentForGlyphAtIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    NSRange r = [super truncatedGlyphRangeInLineFragmentForGlyphAtIndex:glyphIndex];
    DLogLeave(@"" FMT_RANGE, PARAM_RANGE(r));
    return r;
}

// MARK: More sophisticated queries

// Returns the range of glyphs that are generated from the characters in the given charRange.  If actualCharRange is not NULL, it will return by reference the actual range of characters that fully define the glyph range returned.  This range may be identical to or slightly larger than the requested character range.  For example, if the text storage contains the characters "o" and (umlaut) and the glyph store contains the single precomposed glyph (o-umlaut), and if the character range given encloses only the first or second character, then actualCharRange will be set to enclose both characters.  If the length of charRange is zero, the resulting glyph range will be a zero-length range just after the glyph(s) corresponding to the preceding character, and actualCharRange will also be zero-length.  If non-contiguous layout is not enabled, this will force the generation of glyphs for all characters up to and including the end of the specified range.
- (NSRange)glyphRangeForCharacterRange:(NSRange)charRange actualCharacterRange:(NSRangePointer)actualCharRange
{
    DLogEnter(@"charRange:" FMT_RANGE " actualCharRange:" FMT_RANGE, PARAM_RANGE(charRange), PARAM_RANGE(PARAM_OPT_RANGE(actualCharRange)));
    NSRange r = [super glyphRangeForCharacterRange:charRange actualCharacterRange:actualCharRange];
    DLogLeave(@"" FMT_RANGE, PARAM_RANGE(r));
    return r;
}


// Returns the range of characters that generated the glyphs in the given glyphRange.  If actualGlyphRange is not NULL, it will return by reference the full range of glyphs generated by the character range returned.  This range may be identical or slightly larger than the requested glyph range.  For example, if the text storage contains the character (o-umlaut) and the glyph store contains the two atomic glyphs "o" and (umlaut), and if the glyph range given encloses only the first or second glyph, then actualGlyphRange will be set to enclose both glyphs.  If the length of glyphRange is zero, the resulting character range will be a zero-length range just after the character(s) corresponding to the preceding glyph, and actualGlyphRange will also be zero-length.  If non-contiguous layout is not enabled, this will force the generation of glyphs for all characters up to and including the end of the returned range.
- (NSRange)characterRangeForGlyphRange:(NSRange)glyphRange actualGlyphRange:(NSRangePointer)actualGlyphRange
{
    DLogEnter(@"glyphRange:" FMT_RANGE " actualGlyphRange:" FMT_RANGE, PARAM_RANGE(glyphRange), PARAM_RANGE(PARAM_OPT_RANGE(actualGlyphRange)));
    NSRange r = [super characterRangeForGlyphRange:glyphRange actualGlyphRange:actualGlyphRange];
    DLogLeave(@"" FMT_RANGE, PARAM_RANGE(r));
    return r;
}


// Returns the range of characters which have been laid into the given container.  This is a less efficient method than the similar -textContainerForGlyphAtIndex:effectiveRange:.
- (NSRange)glyphRangeForTextContainer:(NSTextContainer *)container
{
    DLogEnter(@"container:%@", container);
    NSRange r = [super glyphRangeForTextContainer:container];
    DLogLeave(@"" FMT_RANGE, PARAM_RANGE(r));
    return r;
}


// Returns the range including the first glyph from glyphIndex on back that has a location set and up to, but not including the next glyph that has a location set.
- (NSRange)rangeOfNominallySpacedGlyphsContainingIndex:(NSUInteger)glyphIndex
{
    DLogEnter(@"glyphIndex:%d", glyphIndex);
    NSRange r = [super rangeOfNominallySpacedGlyphsContainingIndex:glyphIndex];
    DLogLeave(@"" FMT_RANGE, PARAM_RANGE(r));
    return r;
}


// Returns the smallest bounding rect which completely encloses the glyphs in the given glyphRange that are in the given container.  The range is intersected with the container's range before computing the bounding rect.  This method can be used to translate glyph ranges into display rectangles for invalidation.  Bounding rects are always in container coordinates.
- (CGRect)boundingRectForGlyphRange:(NSRange)glyphRange inTextContainer:(NSTextContainer *)container
{
    DLogEnter(@"glyphRange:" FMT_RANGE " container:%@", PARAM_RANGE(glyphRange), container);
    CGRect r = [super boundingRectForGlyphRange:glyphRange inTextContainer:container];
    DLogLeave(@"" FMT_RECT, PARAM_RECT(r));
    return r;
}


// Returns a contiguous glyph range containing all glyphs that would need to be displayed in order to draw all glyphs that fall (even partially) within the bounding rect given.  This range might include glyphs which do not fall into the rect at all.  At most this will return the glyph range for the whole container.  The WithoutAdditionalLayout variant will not generate glyphs or perform layout in attempting to answer, and thus may not be entirely correct.  Bounding rects are always in container coordinates.
- (NSRange)glyphRangeForBoundingRect:(CGRect)bounds inTextContainer:(NSTextContainer *)container
{
    DLogEnter(@"bounds:" FMT_RECT "container:%@", PARAM_RECT(bounds), container);
    NSRange r = [super glyphRangeForBoundingRect:bounds inTextContainer:container];
    DLogLeave(@"" FMT_RANGE, PARAM_RANGE(r));
    return r;
}

- (NSRange)glyphRangeForBoundingRectWithoutAdditionalLayout:(CGRect)bounds inTextContainer:(NSTextContainer *)container
{
    DLogEnter(@"bounds:" FMT_RECT "container:%@", PARAM_RECT(bounds), container);
    NSRange r = [super glyphRangeForBoundingRectWithoutAdditionalLayout:bounds inTextContainer:container];
    DLogLeave(@"" FMT_RANGE, PARAM_RANGE(r));
    return r;
}


// Returns the index of the glyph falling under the given point, expressed in the given container's coordinate system.  If no glyph is under the point, the nearest glyph is returned, where nearest is defined according to the requirements of selection by touch or mouse.  Clients who wish to determine whether the the point actually lies within the bounds of the glyph returned should follow this with a call to boundingRectForGlyphRange:inTextContainer: and test whether the point falls in the rect returned by that method.  If partialFraction is non-NULL, it will return by reference the fraction of the distance between the location of the glyph returned and the location of the next glyph.
- (NSUInteger)glyphIndexForPoint:(CGPoint)point inTextContainer:(NSTextContainer *)container fractionOfDistanceThroughGlyph:(CGFloat *)partialFraction
{
    DLogEnter(@"point:" FMT_POINT " container:%@", PARAM_POINT(point), container);
    NSUInteger gi = [super glyphIndexForPoint:point inTextContainer:container fractionOfDistanceThroughGlyph:partialFraction];
    DLogLeave(@"partialFraction:%f ==>%d", *partialFraction, gi);
    return gi;
}

- (NSUInteger)glyphIndexForPoint:(CGPoint)point inTextContainer:(NSTextContainer *)container
{
    DLogEnter(@"point:" FMT_POINT " container:%@", PARAM_POINT(point), container);
    NSUInteger gi = [super glyphIndexForPoint:point inTextContainer:container];
    DLogLeave(@"%d", gi);
    return gi;
}

- (CGFloat)fractionOfDistanceThroughGlyphForPoint:(CGPoint)point inTextContainer:(NSTextContainer *)container
{
    DLogEnter(@"point:" FMT_POINT " container:%@", PARAM_POINT(point), container);
    CGFloat f = [super fractionOfDistanceThroughGlyphForPoint:point inTextContainer:container];
    DLogLeave(@"%f", f);
    return f;
}


// Returns the index of the character falling under the given point, expressed in the given container's coordinate system.  If no character is under the point, the nearest character is returned, where nearest is defined according to the requirements of selection by touch or mouse.  This is not simply equivalent to taking the result of the corresponding glyph index method and converting it to a character index, because in some cases a single glyph represents more than one selectable character, for example an fi ligature glyph.  In that case, there will be an insertion point within the glyph, and this method will return one character or the other, depending on whether the specified point lies to the left or the right of that insertion point.  In general, this method will return only character indexes for which there is an insertion point (see next method).  The partial fraction is a fraction of the distance from the insertion point logically before the given character to the next one, which may be either to the right or to the left depending on directionality.
- (NSUInteger)characterIndexForPoint:(CGPoint)point inTextContainer:(NSTextContainer *)container fractionOfDistanceBetweenInsertionPoints:(CGFloat *)partialFraction
{
    DLogEnter(@"point:" FMT_POINT " container:%@", PARAM_POINT(point), container);
    NSUInteger ci = [super characterIndexForPoint:point inTextContainer:container fractionOfDistanceBetweenInsertionPoints:partialFraction];
    DLogLeave(@"partialFraction=%f ==>%d", *partialFraction, ci);
    return ci;
}


// Allows clients to obtain all insertion points for a line fragment in one call.  The caller specifies the line fragment by supplying one character index within it, and can choose whether to obtain primary or alternate insertion points, and whether they should be in logical or in display order.  The return value is the number of insertion points returned.  Each pointer passed in should either be NULL, or else point to sufficient memory to hold as many elements as there are insertion points in the line fragment (which cannot be more than the number of characters + 1).  The positions buffer passed in will be filled in with the positions of the insertion points, in the order specified, and the charIndexes buffer passed in will be filled in with the corresponding character indexes.  Positions indicate a transverse offset relative to the line fragment rect's origin.  Internal caching is used to ensure that repeated calls to this method for the same line fragment (possibly with differing values for other arguments) will not be significantly more expensive than a single call.
- (NSUInteger)getLineFragmentInsertionPointsForCharacterAtIndex:(NSUInteger)charIndex alternatePositions:(BOOL)aFlag inDisplayOrder:(BOOL)dFlag positions:(CGFloat *)positions characterIndexes:(NSUInteger *)charIndexes
{
    DLogEnter(@"charIndex:%d alternatePos:%d displayOrder:%d", charIndex, aFlag, dFlag);
    NSUInteger ip = [super getLineFragmentInsertionPointsForCharacterAtIndex:charIndex alternatePositions:aFlag inDisplayOrder:dFlag positions:positions characterIndexes:charIndexes];
    DLogLeave(@"%d", ip);
    return ip;

}


// Enumerates line fragments intersecting with glyphRange.
- (void)enumerateLineFragmentsForGlyphRange:(NSRange)glyphRange usingBlock:(void (^)(CGRect rect, CGRect usedRect, NSTextContainer *textContainer, NSRange glyphRange, BOOL *stop))block
{
    DLogEnter(@"glyphRange:" FMT_RANGE, PARAM_RANGE(glyphRange));
    [super enumerateLineFragmentsForGlyphRange:glyphRange usingBlock:block];
    DLogLeave();
}


// Enumerates enclosing rects for glyphRange in textContainer.  If a selected range is given in the second argument, the rectangles returned will be correct for drawing the selection.  Selection rectangles are generally more complicated than enclosing rectangles and supplying a selected range is the clue these methods use to determine whether to go to the trouble of doing this special work.  If the caller is interested in this more from an enclosing point of view rather than a selection point of view, pass {NSNotFound, 0} as the selected range.  This method will do the minimum amount of work required to answer the question.
- (void)enumerateEnclosingRectsForGlyphRange:(NSRange)glyphRange withinSelectedGlyphRange:(NSRange)selectedRange inTextContainer:(NSTextContainer *)textContainer usingBlock:(void (^)(CGRect rect, BOOL *stop))block
{
    DLogEnter(@"glyphRange:" FMT_RANGE " selectedRange:" FMT_RANGE " textContainer:%@", PARAM_RANGE(glyphRange), PARAM_RANGE(selectedRange), textContainer);
    [super enumerateEnclosingRectsForGlyphRange:glyphRange withinSelectedGlyphRange:selectedRange inTextContainer:textContainer usingBlock:block];
    DLogLeave();
}

// MARK: Draw support

// These methods are primitives for drawing.  You can override these to perform additional drawing, or to replace text drawing entirely, but not to change layout.  You can call them if you want, but focus must already be locked on the destination view or image.  -drawBackgroundForGlyphRange:atPoint: draws the background color and selection and marked range aspects of the text display, along with block decoration such as table backgrounds and borders.  -drawGlyphsForGlyphRange:atPoint: draws the actual glyphs, including attachments, as well as any underlines or strikethroughs.  In either case all of the specified glyphs must lie in a single container.
- (void)drawBackgroundForGlyphRange:(NSRange)glyphsToShow atPoint:(CGPoint)origin
{
    DLogEnter(@"glyphsToShow:" FMT_RANGE " atPoint:" FMT_POINT, PARAM_RANGE(glyphsToShow), PARAM_POINT(origin));
    [super drawBackgroundForGlyphRange:glyphsToShow atPoint:origin];
    DLogLeave();
}

- (void)drawGlyphsForGlyphRange:(NSRange)glyphsToShow atPoint:(CGPoint)origin
{
    DLogEnter(@"glyphsToShow:" FMT_RANGE " atPoint:" FMT_POINT, PARAM_RANGE(glyphsToShow), PARAM_POINT(origin));
    [super drawGlyphsForGlyphRange:glyphsToShow atPoint:origin];
    DLogLeave();
}


// This is the glyph rendering primitive method.  Renders glyphs at positions into the graphicsContext.  The positions are in the user space coordinate system.  If non-nil, graphicsContext that passed in is already configured according to the text attributes arguments: font, textMatrix, and attributes.  The font argument represents the font applied to the graphics state.  The value can be different from the NSFontAttributeName value in the attributes argument because of various font substitutions that the system automatically executes.  The textMatrix is the affine transform mapping the text space coordinate system to the user space coordinate system.  The tx and ty components of textMatrix are ignored since Quartz overrides them with the glyph positions.
- (void)showCGGlyphs:(const CGGlyph *)glyphs positions:(const CGPoint *)positions count:(NSUInteger)glyphCount font:(UIFont *)font matrix:(CGAffineTransform)textMatrix attributes:(NSDictionary *)attributes inContext:(CGContextRef)graphicsContext
{
    DLogEnter(@"glyphCount:%d font:%@", glyphCount, [font familyName]);
    [super showCGGlyphs:glyphs positions:positions count:glyphCount font:font matrix:textMatrix attributes:attributes inContext:graphicsContext];
    DLogLeave();
}


// This is the primitive used by -drawBackgroundForGlyphRange:atPoint: for actually filling rects with a particular background color, whether due to a background color attribute, a selected or marked range highlight, a block decoration, or any other rect fill needed by that method.  As with -showCGGlyphs:..., the character range and color are merely for informational purposes; the color will already be set in the graphics state.  If for any reason you modify it, you must restore it before returning from this method.  You should never call this method, but you might override it.  The default implementation will simply fill the specified rect array.
- (void)fillBackgroundRectArray:(const CGRect *)rectArray count:(NSUInteger)rectCount forCharacterRange:(NSRange)charRange color:(UIColor *)color
{
    DLogEnter(@"rectCount:%d charRange:" FMT_RANGE "color:%@", rectCount, PARAM_RANGE(charRange), color);
    [super fillBackgroundRectArray:rectArray count:rectCount forCharacterRange:charRange color:color];
    DLogLeave();
}


// The first of these methods actually draws an appropriate underline for the glyph range given.  The second method potentially breaks the range it is given up into subranges and calls drawUnderline... for ranges that should actually have the underline drawn.  As examples of why there are two methods, consider two situations.  First, in all cases you don't want to underline the leading and trailing whitespace on a line.  The -underlineGlyphRange... method is passed glyph ranges that have underlining turned on, but it will then look for this leading and trailing white space and only pass the ranges that should actually be underlined to -drawUnderline...  Second, if the underlineType: indicates that only words, (i.e., no whitespace), should be underlined, then -underlineGlyphRange... will carve the range it is passed up into words and only pass word ranges to -drawUnderline.
- (void)drawUnderlineForGlyphRange:(NSRange)glyphRange underlineType:(NSUnderlineStyle)underlineVal baselineOffset:(CGFloat)baselineOffset lineFragmentRect:(CGRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(CGPoint)containerOrigin
{
    DLogEnter(@"glyphRange:" FMT_RANGE " underlineType:%d baselineOffset:%f lineRect:" FMT_RECT "lineGlyphRange:" FMT_RANGE " containerOrigin:" FMT_POINT, PARAM_RANGE(glyphRange), underlineVal, baselineOffset, PARAM_RECT(lineRect), PARAM_RANGE(lineGlyphRange), PARAM_POINT(containerOrigin));
    [super drawUnderlineForGlyphRange:glyphRange underlineType:underlineVal baselineOffset:baselineOffset lineFragmentRect:lineRect lineFragmentGlyphRange:lineGlyphRange containerOrigin:containerOrigin];
    DLogLeave();
}

- (void)underlineGlyphRange:(NSRange)glyphRange underlineType:(NSUnderlineStyle)underlineVal lineFragmentRect:(CGRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(CGPoint)containerOrigin
{
    DLogEnter(@"glyphRange:" FMT_RANGE " underlineType:%d lineRect:" FMT_RECT "lineGlyphRange:" FMT_RANGE " containerOrigin:" FMT_POINT, PARAM_RANGE(glyphRange), underlineVal, PARAM_RECT(lineRect), PARAM_RANGE(lineGlyphRange), PARAM_POINT(containerOrigin));
    [super underlineGlyphRange:glyphRange underlineType:underlineVal lineFragmentRect:lineRect lineFragmentGlyphRange:lineGlyphRange containerOrigin:containerOrigin];
    DLogLeave();
}


// These two methods parallel the two corresponding underline methods, but draw strikethroughs instead of underlines.
- (void)drawStrikethroughForGlyphRange:(NSRange)glyphRange strikethroughType:(NSUnderlineStyle)strikethroughVal baselineOffset:(CGFloat)baselineOffset lineFragmentRect:(CGRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(CGPoint)containerOrigin
{
    DLogEnter(@"glyphRange:" FMT_RANGE " strikethroughType:%d baselineOffset:%f lineRect:" FMT_RECT "lineGlyphRange:" FMT_RANGE " containerOrigin:" FMT_POINT, PARAM_RANGE(glyphRange), strikethroughVal, baselineOffset, PARAM_RECT(lineRect), PARAM_RANGE(lineGlyphRange), PARAM_POINT(containerOrigin));
    [super drawStrikethroughForGlyphRange:glyphRange strikethroughType:strikethroughVal baselineOffset:baselineOffset lineFragmentRect:lineRect lineFragmentGlyphRange:lineGlyphRange containerOrigin:containerOrigin];
    DLogLeave();
}

- (void)strikethroughGlyphRange:(NSRange)glyphRange strikethroughType:(NSUnderlineStyle)strikethroughVal lineFragmentRect:(CGRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(CGPoint)containerOrigin
{
    DLogEnter(@"glyphRange:" FMT_RANGE " strikethroughType:%d lineRect:" FMT_RECT "lineGlyphRange:" FMT_RANGE " containerOrigin:" FMT_POINT, PARAM_RANGE(glyphRange), strikethroughVal, PARAM_RECT(lineRect), PARAM_RANGE(lineGlyphRange), PARAM_POINT(containerOrigin));
    [super strikethroughGlyphRange:glyphRange strikethroughType:strikethroughVal lineFragmentRect:lineRect lineFragmentGlyphRange:lineGlyphRange containerOrigin:containerOrigin];
    DLogLeave();
}





@end
/*

{
    DLog(@"");
}
*/