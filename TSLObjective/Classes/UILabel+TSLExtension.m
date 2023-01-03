//
//  UILabel+TSLExtension.m
//  TSLObjective
//
//  Created by TSL on 2022/12/29.
//

#import "UILabel+TSLExtension.h"

@implementation UILabel (TSLExtension)

- (CGFloat)textWidth {
    if (self.text.length == 0) {
        return 0.0;
    }
    
    return floor([self.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.font} context:nil].size.width) + 1.0;
}

- (CGFloat)textHeight {
    if (self.text.length == 0) {
        return 0.0;
    }
    
    return floor([self.text boundingRectWithSize:CGSizeMake(self.preferredMaxLayoutWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.font} context:nil].size.height) + 1.0;
}

- (CGFloat)attributedTextWidth {
    if (self.attributedText.length == 0) {
        return 0.0;
    }
    
    NSDictionary *alternativeParagraphStyle = [self.attributedText attributesAtIndex:0 effectiveRange:nil];
    
    return floor([self.attributedText.string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:alternativeParagraphStyle context:nil].size.width) + 1.0;
}

- (CGFloat)attributedTextHeight {
    if (self.attributedText.length == 0) {
        return 0.0;
    }
    
    NSDictionary *alternativeParagraphStyle = [self.attributedText attributesAtIndex:0 effectiveRange:nil];
    
    return floor([self.attributedText.string boundingRectWithSize:CGSizeMake(self.preferredMaxLayoutWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:alternativeParagraphStyle context:nil].size.height) + 1.0;
}

@end
