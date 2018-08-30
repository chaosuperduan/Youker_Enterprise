//
//  DEFINE.m
//  youke
//
//  Created by Duan Chao on 2018/5/15.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

#import <Foundation/Foundation.h>
// status bar height.

#define  kStatusBarHeight      (IS_iPhoneX ? 44.f : 20.f)

// Navigation bar height.

#define  kNavigationBarHeight  44.f

// Tabbar height.

#define  kTabbarHeight        (IS_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.

#define  kTabbarSafeBottomMargin        (IS_iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height.

#define  kStatusBarAndNavigationBarHeight  (IS_iPhoneX ? 88.f : 64.f)

//判断是否iPhone X

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
