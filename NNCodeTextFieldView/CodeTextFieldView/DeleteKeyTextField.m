//
//  DeleteKeyTextField.h
//  NNCodeTextFieldView
//
//  Created by dzcx-shinana on 2017/10/27.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import "DeleteKeyTextField.h"


@implementation DeleteKeyTextField

- (void)deleteBackward {
   [super deleteBackward];
   
   if ([self.deleteKey_delegate respondsToSelector:@selector(textFieldDeleteBackward:)]) {
      [self.deleteKey_delegate textFieldDeleteBackward:self];
   }
}


@end
