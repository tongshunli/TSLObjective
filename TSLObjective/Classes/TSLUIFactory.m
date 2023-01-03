//
//  TSLUIFactory.m
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//

#import "TSLUIFactory.h"

#import "TSLFrameDefine.h"

@implementation TSLUIFactory

+ (UIView *)view {
    UIView *view = [[UIView alloc] init];
    view.clipsToBounds = YES;
    return view;
}

+ (UILabel *)label:(UIFont *)textFont withTextColor:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc] init];
    label.font = textFont;
    label.textColor = textColor;
    label.preferredMaxLayoutWidth = kScreenWidth;
    return label;
}

+ (UIImageView *)imageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}

+ (UIButton *)button:(id)target withSelector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.clipsToBounds = YES;
    button.adjustsImageWhenHighlighted = NO;
    return button;
}

+ (UIButton *)button:(UIFont *)textFont withTextColor:(UIColor *)textColor withTarget:(id)target withSelector:(SEL)selector {
    UIButton *button = [TSLUIFactory button:target withSelector:selector];
    [button.titleLabel setFont:textFont];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.preferredMaxLayoutWidth = kScreenWidth;
    return button;
}

+ (UITextField *)textField:(UIFont *)textFont withTextColor:(UIColor *)textColor withPlaceholder:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc] init];
    textField.font = textFont;
    textField.textColor = textColor;
    textField.placeholder = placeholder;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}

+ (UIScrollView *)scrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    return scrollView;
}

+ (UITextView *)textView:(UIFont *)textFont withTextColor:(UIColor *)textColor {
    UITextView *textView = [[UITextView alloc] init];
    textView.font = textFont;
    textView.textColor = textColor;
    textView.showsVerticalScrollIndicator = NO;
    textView.showsHorizontalScrollIndicator = NO;
    return textView;
}

+ (UITableView *)tableView:(UITableViewStyle)style {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    tableView.estimatedRowHeight = 44.0;
    if (@available(iOS 15.0, *)) {
        tableView.sectionHeaderTopPadding = 0;
    }
    return tableView;
}

+ (UICollectionView *)collectionView:(UICollectionViewFlowLayout *)flowLayout {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    return collectionView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
