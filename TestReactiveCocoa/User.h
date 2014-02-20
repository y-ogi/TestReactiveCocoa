//
//  User.h
//  TestReactiveCocoa
//
//  Created by Yuta OGIHARA on 2/20/14.
//  Copyright (c) 2014 Yuta OGIHARA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface UserManager : NSObject

+ (UserManager *)sharedManager;
- (RACSignal *)loginWithName:(NSString *)name password:(NSString *)password;

@end

@interface User : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *password;

+ (UserManager *)manager;
- (id)initWithName:(NSString *)name password:(NSString *)password;
- (RACSignal *)photos;

@end