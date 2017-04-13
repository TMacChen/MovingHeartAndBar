//
//  BarRectsContainer.h
//  HeartBarChart
//
//  Created by 陈刚 on 2017/4/13.
//  Copyright © 2017年 陈刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BarRectsContainer : NSObject

@property (nonatomic , readonly) NSInteger numberOfRects;
@property (nonatomic , readonly) CGRect   *rectsContainer;

+ (BarRectsContainer *)sharedContainer;

- (void)setDrawPanelWidth:(CGFloat)width;
- (void)addBarDataToBar:(NSInteger)data totalHeight:(CGFloat)totalHeight;


@end
