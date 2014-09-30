//
//  AppDelegate.h
//  Frans_Kurniawan_Test
//
//  Created by Qisha Sadiya Kendy on 9/29/14.
//  Copyright (c) 2014 FransKurniawan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

#define AppDel ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) BOOL fromUpdate;

@property (strong, nonatomic) ViewController *vC;

@end
