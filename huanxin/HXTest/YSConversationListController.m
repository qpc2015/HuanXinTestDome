//
//  YSConversationListController.m
//  HXTest
//
//  Created by 覃鹏成 on 16/5/19.
//  Copyright © 2016年 覃鹏成. All rights reserved.
//

#import "YSConversationListController.h"
#import "EMChatViewController.h"

@interface YSConversationListController ()<EMChatManagerDelegate>

@property (nonatomic, strong)   UITextField  *messageTF;
@property (nonatomic, strong)   UIButton     *messageBtn;

@end

@implementation YSConversationListController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self tableViewDidTriggerHeaderRefresh];
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
        EMChatViewController *chatController = [[EMChatViewController alloc] initWithConversationId:self.messageTF.text type:EMConversationTypeChat createIfNotExist:YES];
        [self.navigationController pushViewController:chatController animated:YES];
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

// 收到消息回调
- (void)didReceiveMessages:(NSArray *)aMessages{
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
