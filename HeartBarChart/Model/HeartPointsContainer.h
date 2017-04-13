//
//  HeartPointsContainer.h
//  HeartBarChart
//
//  Created by 陈刚 on 2017/4/13.
//  Copyright © 2017年 陈刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HeartPointsContainer : NSObject

@property (nonatomic , readonly) NSInteger numberOfPoints;
@property (nonatomic , readonly) CGPoint *pointsContainer;

+ (HeartPointsContainer *)sharedContainer;

- (void)setDrawPanelWidth:(CGFloat)width;
- (void)addHeartDataToHeart:(NSInteger)data totalHeight:(CGFloat)totalHeight;

@end
