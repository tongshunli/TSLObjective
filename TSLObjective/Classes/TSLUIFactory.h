//
//  TSLUIFactory.h
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//  UI封装

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSLUIFactory : UIView

+ (UIView *)view;

+ (UILabel *)label:(UIFont *)textFont withTextColor:(UIColor *)textColor;

+ (UIImageView *)imageView;

+ (UIButton *)button:(id)target withSelector:(SEL)selector;

+ (UIButton *)button:(UIFont *)textFont withTextColor:(UIColor *)textColor withTarget:(id)target withSelector:(SEL)selector;

+ (UITextField *)textField:(UIFont *)textFont withTextColor:(UIColor *)textColor withPlaceholder:(NSString *)placeholder;

+ (UIScrollView *)scrollView;

+ (UITextView *)textView:(UIFont *)textFont withTextColor:(UIColor *)textColor;

+ (UITableView *)tableView:(UITableViewStyle)style;

+ (UICollectionView *)collectionView:(UICollectionViewFlowLayout *)flowLayout;

@end

NS_ASSUME_NONNULL_END
