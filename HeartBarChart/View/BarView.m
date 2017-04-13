//
//  BarView.m
//  HeartBarChart
//
//  Created by 陈刚 on 2017/4/13.
//  Copyright © 2017年 陈刚. All rights reserved.
//

#import "BarView.h"

@interface BarView()

@property (nonatomic , assign) CGRect *rects;
@property (nonatomic , assign) NSInteger currentRectsCount;

@end

@implementation BarView


- (void)setRects:(CGRect *)rects {
    _rects = rects;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clearsContextBeforeDrawing = YES;
    }
    return self;
}

- (void)fireDrawingWithRects:(CGRect *)rects rectsCount:(NSInteger)count
{
    self.currentRectsCount = count;
    self.rects = rects;
}

- (void)drawCurve
{
    if (self.currentRectsCount == 0) {
        return;
    }
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(currentContext, 0, 1, 0, 1);
    for (NSInteger i=0; i < self.currentRectsCount; ++i) {
        CGRect rect = self.rects[i];
        CGContextFillRect(currentContext, rect);
    }
    CGContextStrokePath(currentContext);
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self drawCurve];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
