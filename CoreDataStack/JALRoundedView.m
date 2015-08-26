//
//  JALRoundedView.m
//  CoreDataStack
//
//  Created by Jason Lew on 8/25/15.
//  Copyright (c) 2015 Jason Lew. All rights reserved.
//

#import "JALRoundedView.h"

@implementation JALRoundedView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        CGRect parent = CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height);
        self.frame = parent;
        self.layer.cornerRadius = 30;
        self.layer.masksToBounds = YES;
        CGFloat randomFloat = arc4random_uniform(100);
        UIColor *bkgColor = [UIColor colorWithHue:randomFloat / 100 saturation:0.6 brightness:0.9 alpha:1.0];
        self.layer.backgroundColor = bkgColor.CGColor;
    }
    return self;
}

@end
