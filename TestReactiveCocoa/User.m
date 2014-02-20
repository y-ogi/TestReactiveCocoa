//
//  User.m
//  TestReactiveCocoa
//
//  Created by Yuta OGIHARA on 2/20/14.
//  Copyright (c) 2014 Yuta OGIHARA. All rights reserved.
//

#import "User.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@implementation UserManager

+ (UserManager *)sharedManager
{
    static UserManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[UserManager alloc] init];
    });
    return _manager;
}

- (RACSignal *)loginWithName:(NSString *)name password:(NSString *)password
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if ([name isEqualToString:password]) {
            [subscriber sendError:nil];
        } else {
            User *user = [[User alloc] initWithName:name password:password];
            [subscriber sendNext:RACTuplePack(user)];
            [subscriber sendCompleted];
        }
        return nil;
    }];
    return signal;
}

@end

@implementation User

- (id)initWithName:(NSString *)name password:(NSString *)password
{
    self = [super init];
    if (self) {
        self.name = name;
        self.password = password;
    }
    return self;
}


- (RACSignal *)photos
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSArray *photos = @[@"image1.jpg", @"image2.jpg"];
        [subscriber sendNext:RACTuplePack(photos)];
        [subscriber sendCompleted];
        return nil;
    }];
    return signal;
}

+ (UserManager *)manager
{
    return [UserManager sharedManager];
}

@end

