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
#import "ChatDemoHelper.h"

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
            NSLog(@"注册失败 :%@",error);
        }
    }

    
}


- (IBAction)loginClick:(id)sender {
    if(self.accountTF.text && self.accountTF.text){
        EMError *error = [[EMClient sharedClient] loginWithUsername:self.accountTF.text password:self.passwordTF.text];
        
        if (error==nil) {
            NSLog(@"登录成功");
            //切换聊天列表为跟控制器
            YSConversationListController  *listVC = [[YSConversationListController alloc] init];
            listVC.title = @"消息列表";
            
            [ChatDemoHelper shareHelper].mainVC = listVC;
            
            [AppDelegate getAppDelegate].window.rootViewController = [[UINavigationController alloc] initWithRootViewController:listVC];
            
        }else{
            NSLog(@"登录失败 :%@",error);
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
