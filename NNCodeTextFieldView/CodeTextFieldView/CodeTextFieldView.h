//
//  DeleteKeyTextField.h
//  NNCodeTextFieldView
//
//  Created by dzcx-shinana on 2017/10/27.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DeleteKeyTextField;

typedef void(^EndEdditingBlock)(NSString *);
typedef void(^BeginEdditingBlock)();
@interface CodeTextFieldView : UIView

@property (copy, nonatomic)EndEdditingBlock endEdditingBlock;
@property (copy, nonatomic)BeginEdditingBlock beginEdditingBlock;
- (id)initWithFrame:(CGRect)frame withPlaceHoldStr:(NSString *)placeHoldStr;

- (void)autoBecomeResponder;
- (void)autoResignResponder;
@end
