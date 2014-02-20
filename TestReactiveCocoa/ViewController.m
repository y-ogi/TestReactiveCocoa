//
//  ViewController.m
//  TestReactiveCocoa
//
//  Created by Yuta OGIHARA on 2/18/14.
//  Copyright (c) 2014 Yuta OGIHARA. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "User.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// キャッシュとAPIから値を、Chainさせて取ってくるデモ
    _push.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        [[[[User manager] loginWithName:@"taro" password:@"password"] flattenMap:^RACStream *(id value) {
            RACTupleUnpack(User *user) = value;
            return [user photos];
        }] subscribeNext:^(id value) {
            RACTupleUnpack(NSArray *photos) = value;
            NSLog(@"%@", photos);
        } completed:^{
            NSLog(@"completed!");
        }];

        return [RACSignal empty];
        
    }];
    
    // テキストの入力値が同値か調べて、それによってラベルの値を設定するデモ
    RAC(self.resultLabel, text) = [RACSignal combineLatest:@[
                                                             self.firtTextField.rac_textSignal, self.secondTextField.rac_textSignal]
                                                    reduce:^(NSString *first, NSString *second){
        return [first isEqualToString:second]? @"match": @"unmatch";
    }];

    // 文字数入力制限つきのテキストフォーム
    // これだと日本語を入力した場合に落ちてしまう。残念。これは駄目ぽい。
    RAC(self.validateTextField, text) = [[self.validateTextField.rac_textSignal filter:^BOOL(id value) {
        return ((NSString *)value).length > 5;
    }] map:^id(id value) {
        return [((NSString *)value) substringToIndex:5];
    }];
    
    // Notificationを使ってみる 3回限定のNotification
    RACSignal *signal = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"HOGE" object:nil] take:3];
    [signal subscribeNext:^(id x) {
        NSLog(@"notificaation!");
    } completed:^{
        NSLog(@"completed");
    }];
    _notifyButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HOGE" object:nil];
        return [RACSignal empty];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
