//
//  HomeViewController.m
//  HeartBarChart
//
//  Created by 陈刚 on 2017/4/13.
//  Copyright © 2017年 陈刚. All rights reserved.
//

#import "HomeViewController.h"
#import "HeartPointsContainer.h"
#import "BarRectsContainer.h"
#import "HeartView.h"
#import "BarView.h"

@interface HomeViewController ()

@property (nonatomic , strong) HeartView *heartView;
@property (nonatomic , strong) BarView   *barView;

@end

@implementation HomeViewController


- (HeartView *)heartView
{
    if (!_heartView) {
        CGFloat xOffset = 10;
        _heartView = [[HeartView alloc] initWithFrame:CGRectMake(xOffset, 20, CGRectGetWidth(self.view.frame) - 2 * xOffset, 200)];
        _heartView.backgroundColor = [UIColor blackColor];
    }
    return _heartView;
}

- (BarView *)barView
{
    if (!_barView) {
        CGFloat xOffset = 10;
        _barView = [[BarView alloc] initWithFrame:CGRectMake(xOffset, CGRectGetMaxY(self.heartView.frame) + 30, CGRectGetWidth(self.view.frame) - 2 * xOffset, 200)];
        _barView.backgroundColor = [UIColor blackColor];
    }
    return _barView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.heartView];
    [self.view addSubview:self.barView];
    
    [self startLoadData];
    
}

- (void)startLoadData {
    HeartPointsContainer *container = [HeartPointsContainer sharedContainer];
    [container setDrawPanelWidth:self.heartView.bounds.size.width];
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(addHeartData) userInfo:nil repeats:YES];
//
    BarRectsContainer *barContainer = [BarRectsContainer sharedContainer];
    [barContainer setDrawPanelWidth:self.barView.bounds.size.width];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(addBarData) userInfo:nil repeats:YES];
}

- (void)addHeartData {
    NSInteger  biggest = (NSInteger)self.heartView.bounds.size.height;
    NSInteger random =  (arc4random() % biggest-4) + 5;
    [[HeartPointsContainer sharedContainer] addHeartDataToHeart:random totalHeight:biggest];
    [self.heartView fireDrawingWithPoints:[HeartPointsContainer sharedContainer].pointsContainer  pointsCount:[HeartPointsContainer sharedContainer].numberOfPoints];
}

- (void)addBarData {
    NSInteger  biggest = (NSInteger)self.barView.bounds.size.height;
    NSInteger random =  (arc4random() % (biggest/2-4)) + 5;
    [[BarRectsContainer sharedContainer] addBarDataToBar:random totalHeight:biggest];
    [self.barView fireDrawingWithRects:[BarRectsContainer sharedContainer].rectsContainer rectsCount:[BarRectsContainer sharedContainer].numberOfRects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
