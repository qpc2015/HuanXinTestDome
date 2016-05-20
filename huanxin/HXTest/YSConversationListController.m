//
//  YSConversationListController.m
//  HXTest
//
//  Created by 覃鹏成 on 16/5/19.
//  Copyright © 2016年 覃鹏成. All rights reserved.
//

#import "YSConversationListController.h"

@interface YSConversationListController ()<EMChatManagerDelegate>

@property (nonatomic, strong)   UITextField  *messageTF;
@property (nonatomic, strong)   UIButton     *messageBtn;

@end

@implementation YSConversationListController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self tableViewDidTriggerHeaderRefresh];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];

    [self setupUI];
}


- (void)setupUI
{
    self.messageTF = [[UITextField alloc] init];
    self.messageTF.borderStyle = UITextBorderStyleRoundedRect;
    self.messageTF.font = [UIFont systemFontOfSize:12.f];
    self.messageTF.placeholder = @"请输入联系人id";
    [self.view addSubview:self.messageTF];
    [self.messageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.bottom.equalTo(@-50);
        make.width.equalTo(@150);
    }];
    
    self.messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.messageBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.messageBtn setBackgroundColor:[UIColor orangeColor]];
    [self.messageBtn addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.messageBtn];
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageTF.mas_right).with.offset(10);
        make.bottom.equalTo(@-50);
        make.width.equalTo(@100);
    }];
    
}


#pragma mark -- Click
- (void)messageClick:(UIButton *)btn
{
    if(self.messageTF.text.length > 0){
            EaseMessageViewController *message = [[EaseMessageViewController alloc] initWithConversationChatter:self.messageTF.text conversationType:EMConversationTypeChat];
        [self.navigationController pushViewController:message animated:YES];
    }

}


- (void)keyboardWillShow:(NSNotification *)noti
{
    NSDictionary *dict = noti.userInfo;
    NSTimeInterval duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -200);
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)noti
{
    NSDictionary *dict = noti.userInfo;
    NSTimeInterval duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


// 收到消息回调
- (void)didReceiveMessages:(NSArray *)aMessages
{
    [self tableViewDidTriggerHeaderRefresh];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
