//
//  ViewController.m
//  HXTest
//
//  Created by 覃鹏成 on 16/5/19.
//  Copyright © 2016年 覃鹏成. All rights reserved.
//

#import "ViewController.h"
#import "YSConversationListController.h"
#import "AppDelegate.h"
#import "EMDemoHelper.h"
#import "DemoCallManager.h"  // 1v1实时通话功能的头文件
#import "DemoConfManager.h"  // 多人实时通话功能的头文件

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)registeredClick:(id)sender
{
    if(self.accountTF.text && self.accountTF.text){
        EMError *error = [[EMClient sharedClient] registerWithUsername:self.accountTF.text password:self.passwordTF.text];
        if (error==nil) {
            NSLog(@"注册成功");
        }else{
            NSLog(@"注册失败 :%@",error.errorDescription);
            [self showHint:error.errorDescription];
        }
    }
}

- (IBAction)loginClick:(id)sender {
    if(self.accountTF.text && self.accountTF.text){
        EMError *error = [[EMClient sharedClient] loginWithUsername:self.accountTF.text password:self.passwordTF.text];
        
        if (error==nil) {
            NSLog(@"登录成功");
            [EMDemoHelper shareHelper];
            [DemoCallManager sharedManager];  // 初始化1v1实时通话功能的单例
            [DemoConfManager sharedManager];  // 初始化多人实时通话功能的单例
            YSConversationListController *listVC = [[YSConversationListController alloc] init];
            [AppDelegate getAppDelegate].window.rootViewController = [[UINavigationController alloc] initWithRootViewController:listVC];
            
        }else{
            NSLog(@"登录失败 :%@",error.errorDescription);
            [self showHint:error.errorDescription];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
