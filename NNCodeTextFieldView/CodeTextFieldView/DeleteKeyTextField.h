//
//  DeleteKeyTextField.h
//  NNCodeTextFieldView
//
//  Created by dzcx-shinana on 2017/10/27.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DeleteKeyTextField;

@protocol DeleteKeyTextFieldDelegate <NSObject>

- (void)textFieldDeleteBackward:(DeleteKeyTextField *)textField;

@end



@interface DeleteKeyTextField : UITextField

@property (nonatomic, assign) id <DeleteKeyTextFieldDelegate> deleteKey_delegate;

@end
