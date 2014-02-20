//
//  ViewController.h
//  TestReactiveCocoa
//
//  Created by Yuta OGIHARA on 2/18/14.
//  Copyright (c) 2014 Yuta OGIHARA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *push;
@property (weak, nonatomic) IBOutlet UIButton *notifyButton;
@property (weak, nonatomic) IBOutlet UITextField *firtTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UITextField *validateTextField;

@end
