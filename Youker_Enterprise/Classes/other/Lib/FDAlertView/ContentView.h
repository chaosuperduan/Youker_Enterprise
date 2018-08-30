//
//  ContentView.h
//  FDAlertViewDemo
//
//  Created by fergusding on 15/5/26.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^submitBlock)(void);
@interface ContentView : UIView
@property(nonatomic,copy)submitBlock block;
@property (weak, nonatomic) IBOutlet UITextView *noticeView;


@end
