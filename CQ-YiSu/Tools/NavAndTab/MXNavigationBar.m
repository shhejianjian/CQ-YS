//
//  MXNavigationBar.m
//  navDemo
//
//  Created by Max on 16/9/20.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#define SafeAreaTopHeight (kWJScreenHeight == 812.0 ? 88 : 64)
#import "MXNavigationBar.h"
#import "MXBarButtonItem.h"
@interface MXNavigationBar ()

@property (strong, nonatomic) UIView *lineView;

@end



@implementation MXNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpDefaultAttribute];
    }
    return self;
}


- (void)setUpDefaultAttribute
{
    self.backgroundColor = [UIColor colorWithRed:40/255.0 green:124/255.0 blue:245/255.0 alpha:1];
    self.frame = (CGRect){0, 0, [UIScreen mainScreen].bounds.size.width, 64};
    self.lineView = [[UIView alloc] initWithFrame:(CGRect){0, 64, [UIScreen mainScreen].bounds.size.width, 0.5}];
    self.lineView.backgroundColor = [UIColor colorWithRed:10/255 green:10/255 blue:10/255 alpha:0.1f];
    [self addSubview:self.lineView];
}







@end
