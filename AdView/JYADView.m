//
//  JYADView.m
//  ScrollView图片轮播器
//
//  Created by nero on 15/3/12.
//  Copyright (c) 2015年 zzc. All rights reserved.
//

#import "JYADView.h"
//#import "UIImageView+WebCache.h"
//#import "SKYHttpTool.h"
#import <SKYCategory/SKYCategory.h>

#define c_width (self.bounds.size.width) //两张图片之前有10点的间隔

#define c_height (self.bounds.size.height)
@interface JYADView ()<UIScrollViewDelegate>{
    UIPageControl    *_pageControl; //分页控件
    NSMutableArray *_curImageArray; //当前显示的图片数组
    NSInteger          _curPage;    //当前显示的图片位置
    NSTimer           *_timer;      //定时器
    UIView            *_lowFloorView;
    UILabel           *_nameLabel;
}

@end

@implementation JYADView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //滚动视图
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.contentSize = CGSizeMake(c_width*3, 0);
        self.scrollView.contentOffset = CGPointMake(c_width, 0);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        /*
        _lowFloorView=[[UIView alloc]init];
        [self addSubview:_lowFloorView];
        
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.textColor=[UIColor whiteColor];
        _nameLabel.numberOfLines=1;
        _nameLabel.font=[UIFont systemFontOfSize:17.0];
        [_lowFloorView addSubview:_nameLabel];
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [_lowFloorView addSubview:_pageControl];
         */
        
        //初始化数据，当前图片默认位置是0
        _curImageArray = [[NSMutableArray alloc] initWithCapacity:0];
        _curPage = 0;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rollBegin:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rollStop:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        //滚动视图
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.contentSize = CGSizeMake(c_width*3, 0);
        self.scrollView.contentOffset = CGPointMake(c_width, 0);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        /*
        _lowFloorView=[[UIView alloc]init];
        [self addSubview:_lowFloorView];
        
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.textColor=[UIColor whiteColor];
        _nameLabel.numberOfLines=2;
        _nameLabel.font=[UIFont systemFontOfSize:13.0];
        [_lowFloorView addSubview:_nameLabel];
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [_lowFloorView addSubview:_pageControl];
        */
        
        //初始化数据，当前图片默认位置是0
        _curImageArray = [[NSMutableArray alloc] initWithCapacity:0];
        _curPage = 0;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rollBegin:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rollStop:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}
-(void)rollBegin:(NSNotification *)notification{
    [self beginTimer];
}
-(void)rollStop:(NSNotification *)notification{
    [self pauseTimer];
}

-(void)setTitleTexts:(NSArray *)titleTexts{
    _titleTexts=titleTexts;
    if (_titleTexts) {
        _lowFloorView.backgroundColor=RGBACOLOR(0, 0, 0, 0.6);
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width=self.frame.size.width;
    CGFloat height=self.frame.size.height;
    
    self.scrollView.frame=CGRectMake(0, 0, width, height);
    
    _lowFloorView.frame=CGRectMake(0, height-40, width, 40);
    
//    CGFloat pageWidth = width*0.25;
    _nameLabel.frame=CGRectMake(10, 0, width-120, 40);
    
    //分页控件
    CGFloat pageWidth = width*0.25;
    CGFloat pageHieght = 20;
    CGFloat pageX = (_lowFloorView.frame.size.width - pageWidth)-10;
    CGFloat pageY = 10;
    _pageControl.frame=CGRectMake(pageX, pageY, pageWidth, pageHieght);
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //如果scrollView当前偏移位置x大于等于两倍scrollView宽度
    if (scrollView.contentOffset.x >= c_width*2) {
        //当前图片位置+1
        _curPage++;
        //如果当前图片位置超过数组边界，则设置为0
        if (_curPage == [self.imageArray count]) {
            _curPage = 0;
        }
        //刷新图片
        [self reloadData];
        //设置scrollView偏移位置
        [scrollView setContentOffset:CGPointMake(c_width, 0)];
    }
    
    //如果scrollView当前偏移位置x小于等于0
    else if (scrollView.contentOffset.x <= 0) {
        //当前图片位置-1
        _curPage--;
        //如果当前图片位置小于数组边界，则设置为数组最后一张图片下标
        if (_curPage == -1) {
            _curPage = [self.imageArray count]-1;
        }
        //刷新图片
        [self reloadData];
        //设置scrollView偏移位置
        [scrollView setContentOffset:CGPointMake(c_width, 0)];
    }
}

//停止滚动的时候回调
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //设置scrollView偏移位置
    [scrollView setContentOffset:CGPointMake(c_width, 0) animated:YES];
}
/**
 *  开始拖拽的时候调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 停止定时器(一旦定时器停止了,就不能再使用)
    [self removeTimer];
}
/**
 *  停止拖拽的时候调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 开启定时器
    [self addTimer];
}


- (void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = imageArray;
    //设置分页控件的总页数
    _pageControl.numberOfPages = imageArray.count>5?5:imageArray.count;
    //刷新图片
    [self reloadData];
    
    //开启定时器
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    //判断图片长度是否大于1，如果一张图片不开启定时器
    if ([imageArray count] > 1) {

        [self addTimer];
    }
}

- (void)reloadData
{
    //设置页数
    _pageControl.currentPage = _curPage;
    //根据当前页取出图片
    [self getDisplayImagesWithCurpage:_curPage];
    if (self.titleTexts) {
        _nameLabel.text=self.titleTexts[_curPage];
    }
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [self.scrollView subviews];
    if ([subViews count] > 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    //创建imageView
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(c_width*i, 0, self.bounds.size.width, c_height)];
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
#pragma mark 加载数据在这里,图片URL位置,可以自动修改选择加载的路径
        //          设置数据
        imageView.image = _curImageArray[i];
//        NSString *imageUrl = _curImageArray[i];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        
        //tap手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [imageView addGestureRecognizer:tap];
    }
}

- (void)getDisplayImagesWithCurpage:(NSInteger)page
{
    //取出开头和末尾图片在图片数组里的下标
    NSInteger front = page - 1;
    NSInteger last = page + 1;
    
    //如果当前图片下标是0，则开头图片设置为图片数组的最后一个元素
    if (page == 0) {
        front = [self.imageArray count]-1;
    }
    
    //如果当前图片下标是图片数组最后一个元素，则设置末尾图片为图片数组的第一个元素
    if (page == [self.imageArray count]-1) {
        last = 0;
    }
    
    //如果当前图片数组不为空，则移除所有元素
    if ([_curImageArray count] > 0) {
        [_curImageArray removeAllObjects];
    }
    
    //当前图片数组添加图片
    [_curImageArray addObject:self.imageArray[front]];
    [_curImageArray addObject:self.imageArray[page]];
    [_curImageArray addObject:self.imageArray[last]];
}
/**
 *  添加定时器
 */
-(void)addTimer {
    _timer = [NSTimer timerWithTimeInterval:2.5 target:self selector:@selector(timerScrollImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] runMode:UITrackingRunLoopMode beforeDate:[NSDate date]];
    
}
//启动定时器
-(void)beginTimer{
    if(_timer == nil){
        [self addTimer];
        return;
    }
    if(_timer && [_timer isValid]){
        [_timer setFireDate:[NSDate date]];
    }
}
/**
 *  移除定时器
 */
- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}
//暂停定时器
-(void)pauseTimer{
    if(_timer && [_timer isValid]){
        [_timer setFireDate:[NSDate distantFuture]];
    }
}
- (void)timerScrollImage{
    //刷新图片
    [self reloadData];
    
    //设置scrollView偏移位置
    [self.scrollView setContentOffset:CGPointMake(c_width*2, 0) animated:YES];
}
-(void)ADViewDidSelected:(JYADView *)adView atIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(ADViewDidSelected:atIndex:)]) {
        [self.delegate ADViewDidSelected:self atIndex:index];
    }
}
#pragma mark 点击事件响应处理
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    [self.delegate ADViewDidSelected:self atIndex:_curPage];
    if (_adDidClick) {
        NSLog(@"%ld",(long)_curPage);
        _adDidClick(_curPage);
    }
    
}

- (void)dealloc{
    //代理指向nil，关闭定时器
    self.scrollView.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_timer invalidate];
}

@end
