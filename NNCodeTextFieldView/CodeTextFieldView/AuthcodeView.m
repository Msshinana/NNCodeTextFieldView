//
//  AuthcodeView.m
//  NNCodeTextFieldView
//
//  Created by dzcx-shinana on 2017/10/27.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import "AuthcodeView.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
@implementation AuthcodeView

- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self)
   {
      self.layer.cornerRadius = 3.0f;
      self.layer.masksToBounds = YES;
      self.backgroundColor = RGBCOLOR(242, 242, 242);
      
      [self getAuthcode];//获得随机验证码
   }
   return self;
}

#pragma mark 获得随机验证码
- (void)getAuthcode
{
   _authCodeStr = [NSString stringWithFormat:@"%u%u%u%u",arc4random_uniform(9),arc4random_uniform(9),arc4random_uniform(9),arc4random_uniform(9)];
   [self setNeedsDisplay];
}

#pragma mark 点击界面切换验证码
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   _authCodeStr = [NSString stringWithFormat:@"%u%u%u%u",arc4random_uniform(9),arc4random_uniform(9),arc4random_uniform(9),arc4random_uniform(9)];
   
   [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
   [super drawRect:rect];

   //根据要显示的验证码字符串，根据长度，计算每个字符串显示的位置
   NSString *text = [NSString stringWithFormat:@"%@",_authCodeStr];
   
   CGSize cSize = [@"A" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
   
   int width = rect.size.width/text.length - cSize.width;
   int height = rect.size.height - cSize.height;
   
   CGPoint point;
   
   //依次绘制每一个字符,可以设置显示的每个字符的字体大小、颜色、样式等
   float pX,pY;
   for ( int i = 0; i<text.length; i++)
   {
      pX = arc4random() % width + rect.size.width/text.length * i;
      pY = arc4random() % height;
      point = CGPointMake(pX, pY);
      
      unichar c = [text characterAtIndex:i];
      NSString *textC = [NSString stringWithFormat:@"%C", c];
      
      [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:25],NSForegroundColorAttributeName:RGBCOLOR(138, 97, 114)}];
   }

   CGContextRef context = UIGraphicsGetCurrentContext();
   //设置线条宽度
   CGContextSetLineWidth(context, 2);
   //设置线条填充色
   UIColor *color = RGBCOLOR(138, 97, 114);
   CGContextSetStrokeColorWithColor(context, color.CGColor);
   
   CGContextMoveToPoint(context, 0, rect.size.height/2);
   CGContextAddCurveToPoint(context,arc4random() % (int)rect.size.width,  arc4random() % (int)rect.size.height, arc4random() % (int)rect.size.width,  arc4random() % (int)rect.size.height, rect.size.width, arc4random() % (int)rect.size.height);
   CGContextStrokePath(context);
}

@end
