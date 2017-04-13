//
//  HeartPointsContainer.m
//  HeartBarChart
//
//  Created by 陈刚 on 2017/4/13.
//  Copyright © 2017年 陈刚. All rights reserved.
//

#import "HeartPointsContainer.h"


static const NSInteger kDefaultMaxPointCount = 300;
static const NSInteger kPixelPerPoint = 1;

@interface HeartPointsContainer ()

@property (nonatomic , assign) NSInteger numberOfPoints;
@property (nonatomic , assign) CGPoint *pointsContainer;
@property (nonatomic , assign) NSInteger maxPointsCount;

@end

@implementation HeartPointsContainer

+ (HeartPointsContainer *)sharedContainer
{
    static HeartPointsContainer *container_ptr = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        container_ptr = [[self alloc] init];
        container_ptr.pointsContainer = malloc(sizeof(CGPoint) * kDefaultMaxPointCount);
        container_ptr.maxPointsCount = kDefaultMaxPointCount;
        memset(container_ptr.pointsContainer, 0, sizeof(CGPoint) * kDefaultMaxPointCount);
    });
    return container_ptr;
}

- (void)setDrawPanelWidth:(CGFloat)width {
    _maxPointsCount = (NSInteger)width / kPixelPerPoint;
    _pointsContainer = malloc(sizeof(CGPoint) * _maxPointsCount);
    memset(_pointsContainer, 0, sizeof(CGPoint) * _maxPointsCount);
}

- (void)addHeartDataToHeart:(NSInteger)data totalHeight:(CGFloat)totalHeight
{
    //  always add to the first one
    static NSInteger currentPointsCount = 0;
    if (currentPointsCount < _maxPointsCount) {
        NSInteger workIndex = currentPointsCount;
        while (workIndex > 0) {
            self.pointsContainer[workIndex].x = kPixelPerPoint * workIndex;
            self.pointsContainer[workIndex].y = self.pointsContainer[workIndex - 1].y;
            workIndex --;
        }
        self.pointsContainer[0].x = 0;
        self.pointsContainer[0].y = totalHeight-data;
        self.numberOfPoints = currentPointsCount + 1;
        currentPointsCount ++;
    } else {
        NSInteger workIndex = _maxPointsCount - 1;
        while (workIndex > 0) {
            self.pointsContainer[workIndex].x = kPixelPerPoint * workIndex;
            self.pointsContainer[workIndex].y = self.pointsContainer[workIndex - 1].y;
            workIndex --;
        }
        self.pointsContainer[0].x = 0;
        self.pointsContainer[0].y = totalHeight-data;
        self.numberOfPoints = _maxPointsCount;
    }
}



@end
