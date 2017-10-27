//
//  ViewController.m
//  NNCodeTextFieldView
//
//  Created by dzcx-shinana on 2017/10/27.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import "ViewController.h"
#import "AuthcodeView.h"
#import "CodeTextFieldView.h"
@interface ViewController ()
@property (strong, nonatomic) CodeTextFieldView *codeTextFieldView;
@property (strong, nonatomic) AuthcodeView *authCodeView;
@property (strong, nonatomic)UILabel *errorLabel;
@property(nonatomic,strong)NSString *codeNum;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self prepareUI];
}
- (void)prepareUI{
    //验证码输入框
    self.codeTextFieldView = [[CodeTextFieldView alloc]initWithFrame:CGRectMake(20, (self.view.frame.size.height-36)/2, self.view.frame.size.width-88-31-40, 36)withPlaceHoldStr:@"输入右边数字"];
    __weak typeof(self) weakSelf=self;
    self.codeTextFieldView.beginEdditingBlock = ^() {
        
    };
    self.codeTextFieldView.endEdditingBlock = ^(NSString * codeNum){
        weakSelf.codeNum = codeNum;
        //延时0.5S开始验证数字码和手机号
        [weakSelf performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.5];
    };
    [self.view addSubview:weakSelf.codeTextFieldView];
    
    //图形验证码
    self.authCodeView = [[AuthcodeView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.codeTextFieldView.frame)+31, (self.view.frame.size.height-36)/2, 88, 35)];
    [self.view addSubview:self.authCodeView];
    
    self.errorLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(self.codeTextFieldView.frame), self.view.frame.size.width-20, 20)];
    self.errorLabel.textColor = [UIColor redColor];
    self.errorLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.errorLabel];
}
- (void)delayMethod{
    //验证码输完进行校验
    if ([self.codeNum isEqualToString:self.authCodeView.authCodeStr]) {//验证码正确
        self.errorLabel.hidden = YES;
    }else{//验证码错误
        self.errorLabel.hidden = NO;
        self.errorLabel.text = @"请输入正确的数字码";
        [self.codeTextFieldView autoBecomeResponder];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
