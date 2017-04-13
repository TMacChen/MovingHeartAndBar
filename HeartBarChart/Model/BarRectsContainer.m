//
//  BarRectsContainer.m
//  HeartBarChart
//
//  Created by 陈刚 on 2017/4/13.
//  Copyright © 2017年 陈刚. All rights reserved.
//

#import "BarRectsContainer.h"

static const NSInteger kDefaultMaxRectCount = 20;
static const NSInteger kWidthPerBar = 10;
static const NSInteger kSpacePerBar = 5;

@interface BarRectsContainer ()

@property (nonatomic , assign) NSInteger numberOfRects;
@property (nonatomic , assign) CGRect *rectsContainer;
@property (nonatomic , assign) NSInteger maxRectsCount;

@end

@implementation BarRectsContainer

+ (BarRectsContainer *)sharedContainer
{
    static BarRectsContainer *container_ptr = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        container_ptr = [[self alloc] init];
        container_ptr.rectsContainer = malloc(sizeof(CGRect) * kDefaultMaxRectCount);
        container_ptr.maxRectsCount = kDefaultMaxRectCount;
        memset(container_ptr.rectsContainer, 0, sizeof(CGRect) * kDefaultMaxRectCount);
    });
    return container_ptr;
}

- (void)setDrawPanelWidth:(CGFloat)width {
    _maxRectsCount = (NSInteger)((width + kWidthPerBar) / (kWidthPerBar+kSpacePerBar))+1;
    _rectsContainer = malloc(sizeof(CGRect) * _maxRectsCount);
    memset(_rectsContainer, 0, sizeof(CGRect) * _maxRectsCount);
}

- (void)addBarDataToBar:(NSInteger)data totalHeight:(CGFloat)totalHeight;
{
    //  always add to the first one
    static NSInteger currentPointsCount = 0;
    if (currentPointsCount < _maxRectsCount) {
        NSInteger workIndex = currentPointsCount;
        while (workIndex > 0) {
            CGRect lastRect = self.rectsContainer[workIndex];
            lastRect.origin.x = workIndex * kSpacePerBar + (workIndex-1) * kWidthPerBar;
            lastRect.origin.y = self.rectsContainer[workIndex - 1].origin.y;
            lastRect.size.width = kWidthPerBar;
            lastRect.size.height = self.rectsContainer[workIndex - 1].size.height;
            self.rectsContainer[workIndex] = lastRect;
            workIndex --;
        }
        CGRect firstRect = CGRectMake(-kWidthPerBar, totalHeight-data, kWidthPerBar, data);
        self.rectsContainer[0] = firstRect;
        self.numberOfRects = currentPointsCount + 1;
        currentPointsCount ++;
    } else {
        NSInteger workIndex = _maxRectsCount - 1;
        while (workIndex > 0) {
            CGRect lastRect = self.rectsContainer[workIndex];
            lastRect.origin.x = workIndex * kSpacePerBar + (workIndex-1) * kWidthPerBar;
            lastRect.origin.y = self.rectsContainer[workIndex - 1].origin.y;
            lastRect.size.width = kWidthPerBar;
            lastRect.size.height = self.rectsContainer[workIndex - 1].size.height;
            self.rectsContainer[workIndex] = lastRect;
            workIndex --;
        }
        CGRect firstRect = CGRectMake(-kWidthPerBar, totalHeight-data, kWidthPerBar, data);
        self.rectsContainer[0] = firstRect;
        self.numberOfRects = _maxRectsCount;
    }
}

@end
