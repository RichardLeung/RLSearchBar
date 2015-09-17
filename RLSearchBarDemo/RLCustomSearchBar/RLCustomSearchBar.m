//
//  RLCustomSearchBar.m
//  CustomSearchBarDemo
//
//  Created by RichardLeung on 15/7/15.
//  Copyright (c) 2015年 RichardLeung. All rights reserved.
//

#import "RLCustomSearchBar.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface RLCustomSearchBar()<UITextFieldDelegate>


@end

@implementation RLCustomSearchBar

+ (RLCustomSearchBar *) searchBar {
    RLCustomSearchBar * view = (RLCustomSearchBar *)[[[NSBundle mainBundle] loadNibNamed:@"RLCustomSearchBar" owner:self options:nil] lastObject];
    return view;
}

- (void)initWithGreenStyle{
    [self initWithBackgroundColor:rgba(45, 185, 105, 1)
              textBackgroundColor:rgba(38, 152, 87, 1)
                        textColor:[UIColor whiteColor]
                        tintColor:[UIColor whiteColor]
                      placeHolder:@"搜索信息"
                 placeHolderColor:rgba(200, 200, 200, 1)
                        imageMark:@"search_all_h" imageFunc:@"search_all_h"];
    _buttonCancel.hidden =NO;
    _layoutViewLeft.constant =5;
}

- (void)initWithBackgroundColor:(UIColor *)colorBackground
            textBackgroundColor:(UIColor *)colorTextBackground
                      textColor:(UIColor *)textColor
                      tintColor:(UIColor *)tintColor
                    placeHolder:(NSString *)placeHolder
               placeHolderColor:(UIColor *)placeHolderColor
                      imageMark:(NSString *)imageMarkName
                      imageFunc:(NSString *)imageFuncName
{
    _viewBackground.backgroundColor =colorBackground;
    _viewTextBackground.backgroundColor =colorTextBackground;
    _textFieldSearch.delegate =self;
    _viewTextBackground.backgroundColor =colorTextBackground;
    _imageViewMark.image =[UIImage imageNamed:imageMarkName];
    [_buttonFunc setBackgroundImage:[UIImage imageNamed:imageFuncName] forState:UIControlStateNormal];
    [_buttonCancel setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    //[_buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_viewTextBackground.layer setCornerRadius:5];
    [_viewTextBackground.layer setMasksToBounds:YES];
    [_textFieldSearch setTextColor:textColor];
    [_textFieldSearch setTintColor:tintColor];
    [_textFieldSearch setPlaceholder:placeHolder];
    _textFieldSearch.returnKeyType = UIReturnKeySearch;
    [_textFieldSearch setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    [_textFieldSearch addTarget:self action:@selector(textFieldSearchDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (IBAction)buttonCancelClick:(UIButton *)button{
    if ([self.delelgate respondsToSelector:@selector(searchBarButtonCancelDidClick)]) {
        [self.delelgate searchBarButtonCancelDidClick];
    }
}

-(void)textFieldSearchDidChange:(UITextField *)textField{
    if ([self.delelgate respondsToSelector:@selector(searchBarTextDidChange:)]) {
        [self.delelgate searchBarTextDidChange:textField.text];
    }
}

#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _buttonCancel.hidden =NO;
    if ([self.delelgate respondsToSelector:@selector(searchBarTextDidBegin)]) {
        [self.delelgate searchBarTextDidBegin];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delelgate respondsToSelector:@selector(searchBarTextDidEnd)]) {
        [self.delelgate searchBarTextDidEnd];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.delelgate respondsToSelector:@selector(searchBarButtonSearchDidClick:)]) {
        [self.delelgate searchBarButtonSearchDidClick:textField.text];
    }
    return YES;
}

@end
