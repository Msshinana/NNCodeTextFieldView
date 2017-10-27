//
//  DeleteKeyTextField.m
//  NNCodeTextFieldView
//
//  Created by dzcx-shinana on 2017/10/27.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import "CodeTextFieldView.h"
#import "DeleteKeyTextField.h"
@interface CodeTextFieldView ()<UITextFieldDelegate,DeleteKeyTextFieldDelegate>
@property(nonatomic,strong)UILabel *placeHoldLabel;
@property(nonatomic,strong)DeleteKeyTextField *numOneTF;
@property(nonatomic,strong)DeleteKeyTextField *numTwoTF;
@property(nonatomic,strong)DeleteKeyTextField *numThreeTF;
@property(nonatomic,strong)DeleteKeyTextField *numFourTF;

@end
@implementation CodeTextFieldView

- (id)initWithFrame:(CGRect)frame withPlaceHoldStr:(NSString *)placeHoldStr{
   self = [super initWithFrame:frame];
   if (self) {
      
      self.placeHoldLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-8)];
      self.placeHoldLabel.text = placeHoldStr;
      self.placeHoldLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
      self.placeHoldLabel.textColor = [UIColor whiteColor];
      [self addSubview:self.placeHoldLabel];
      
      for (int i=0; i<4; i++) {
         
         CGFloat spaceWidth = 16;
         CGFloat TFWidth = (self.frame.size.width-16*3)/4;
         CGFloat TFHeight = 27;
         DeleteKeyTextField *TF = [[DeleteKeyTextField alloc] initWithFrame:CGRectMake(i*(TFWidth+spaceWidth), 0, TFWidth, TFHeight)];
         [[UITextField appearance] setTintColor:[UIColor grayColor]];
         TF.tag = 10+i;
         TF.delegate = self;
         TF.deleteKey_delegate = self;
          TF.layer.borderColor = [UIColor grayColor].CGColor;
          TF.layer.borderWidth = 1;
          TF.layer.cornerRadius = 10;
          TF.clipsToBounds = YES;
         TF.font = [UIFont systemFontOfSize:20];
         TF.textColor = [UIColor blackColor];
         TF.textAlignment = NSTextAlignmentCenter;
         TF.borderStyle = UITextBorderStyleNone;
         TF.clearButtonMode = UITextFieldViewModeWhileEditing;
         TF.keyboardType = UIKeyboardTypeNumberPad;
          
         [TF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
         [self addSubview:TF];

      }
      self.numOneTF = [self viewWithTag:10];
      self.numTwoTF = [self viewWithTag:11];
      self.numThreeTF = [self viewWithTag:12];
      self.numFourTF = [self viewWithTag:13];

   }
   return self;
}
//重新输入时移除之前记录
-(void)textFieldDidBeginEditing:(UITextField *)textField{
   if (textField.becomeFirstResponder == YES) {
      if (textField.text.length>=1) {
         [textField setText:@""];
      }
   }
   if (self.numOneTF.text.length>0 || self.numTwoTF.text.length>0 || self.numThreeTF.text.length>0 || self.numFourTF.text.length>0) {
      self.placeHoldLabel.hidden = YES;
   }else{
      self.placeHoldLabel.hidden = NO;
   }
   
   if (_beginEdditingBlock) {
      _beginEdditingBlock();
   }
}
- (void)textFieldDidChange:(DeleteKeyTextField*)textField{
   if (self.numOneTF.text.length>0 || self.numTwoTF.text.length>0 || self.numThreeTF.text.length>0 || self.numFourTF.text.length>0) {
      self.placeHoldLabel.hidden = YES;
   }else{
      self.placeHoldLabel.hidden = NO;
   }
   if (textField == self.numOneTF) {
      if (textField.text.length == 1) {
         [self.numTwoTF becomeFirstResponder];
      }
   }
   if (textField == self.numTwoTF) {
      if (textField.text.length == 1) {
         [self.numThreeTF becomeFirstResponder];
      }
   }
   if (textField == self.numThreeTF) {
      if (textField.text.length == 1) {
         [self.numFourTF becomeFirstResponder];
      }
   }
   if (textField == self.numFourTF) {
      if (textField.text.length == 1) {
         [self.numFourTF resignFirstResponder];
      }
   }
   if (self.numOneTF.text.length==1 && self.numTwoTF.text.length==1 && self.numThreeTF.text.length==1 && self.numFourTF.text.length==1){
      NSString *codeNum = [NSString stringWithFormat:@"%@%@%@%@",self.numOneTF.text, self.numTwoTF.text,self.numThreeTF.text, self.numFourTF.text];
      if (_endEdditingBlock) {
         _endEdditingBlock(codeNum);
      }
   }
}
//删除按键
- (void)textFieldDeleteBackward:(DeleteKeyTextField *)textField{
   if (textField == self.numOneTF) {
      if (textField.text.length == 0){
         [self.numOneTF becomeFirstResponder];
      }
   }
   if (textField == self.numTwoTF) {
      if (textField.text.length == 0){
         [self.numOneTF becomeFirstResponder];
      }
   }
   if (textField == self.numThreeTF) {
      if (textField.text.length == 0){
         [self.numTwoTF becomeFirstResponder];
      }
   }
   if (textField == self.numFourTF) {
      if (textField.text.length == 0){
         [self.numThreeTF becomeFirstResponder];
      }
   }
}
- (void)autoBecomeResponder{
   self.numOneTF.text = @"";
   self.numTwoTF.text = @"";
   self.numThreeTF.text = @"";
   self.numFourTF.text = @"";
   
   self.placeHoldLabel.hidden = NO;
   [self.numOneTF becomeFirstResponder];
}
- (void)autoResignResponder{
   [self.numOneTF resignFirstResponder];
   [self.numTwoTF resignFirstResponder];
   [self.numThreeTF resignFirstResponder];
   [self.numFourTF resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   [self endEditing:YES];
   return YES;
}
@end
