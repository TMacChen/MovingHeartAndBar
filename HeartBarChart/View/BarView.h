//
//  BarView.h
//  HeartBarChart
//
//  Created by 陈刚 on 2017/4/13.
//  Copyright © 2017年 陈刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarView : UIView

- (void)fireDrawingWithRects:(CGRect *)rects rectsCount:(NSInteger)count;

@end
