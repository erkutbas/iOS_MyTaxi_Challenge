//
//  ListVehicleViewController.m
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/11/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import "ListVehicleViewController.h"
#import "ListDataTableViewCell.h"
#import "Constants.h"
#import "iOS_MyTaxi_Challenge-Swift.h"

@interface ListVehicleViewController ()

@end

@implementation ListVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self tableViewManagements];
    [self addTopViewToTableView];
    [self addImageContainerView];
    [self changeCornerRadius];
    [self addBlurViewToBottomDismissView];
    
    [self addTapGestures];
    
}

- (void) addTapGestures {
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.dismissBottomView addGestureRecognizer:singleFingerTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void) tableViewManagements {
    self.vehicleTableView.delegate = self;
    self.vehicleTableView.dataSource = self;
    
    [self.vehicleTableView setContentInset:UIEdgeInsetsMake(UIApplication.sharedApplication.statusBarFrame.size.height + imageContainerViewHeight + 5, 0, bottomEdge_80, 0)];
}

- (void) changeCornerRadius {
    _topView.layer.cornerRadius = cornerRadius_10;
    _topView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    
    [_topView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_topView.layer setShadowOpacity:1.0];
    [_topView.layer setShadowRadius:5.0];
    [_topView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    _dismissBottomView.layer.cornerRadius = cornerRadius_40;
    _dismissBottomView.layer.maskedCorners = kCALayerMinXMinYCorner;
    _dismissBottomView.clipsToBounds = true;

    [_dismissBottomView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_dismissBottomView.layer setShadowOpacity:0.8];
    [_dismissBottomView.layer setShadowRadius:5.0];
    [_dismissBottomView.layer setShadowOffset:CGSizeMake(0, -2.0)];
    
}

- (void) addTopViewToTableView {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, imageContainerViewHeight)];
    _topView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:_topView];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [_topView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [_topView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [_topView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              ]
     ];
    
}

- (void) addImageContainerView {
    
    _imageContainerView = [[ImageContainerView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIApplication.sharedApplication.statusBarFrame.size.height + imageContainerViewHeight)];
    _imageContainerView.translatesAutoresizingMaskIntoConstraints = false;
    _imageContainerView.clipsToBounds = true;
    
    [_topView addSubview:_imageContainerView];
    
    [NSLayoutConstraint activateConstraints:@[[_imageContainerView.leadingAnchor constraintEqualToAnchor:_topView.leadingAnchor], [_imageContainerView.trailingAnchor constraintEqualToAnchor:_topView.trailingAnchor], [_imageContainerView.topAnchor constraintEqualToAnchor:_topView.topAnchor], [_imageContainerView.bottomAnchor constraintEqualToAnchor:_topView.bottomAnchor]] ];
    
}

- (void) addBlurViewToBottomDismissView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _bottomBlurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _bottomBlurView.translatesAutoresizingMaskIntoConstraints = false;
    
    //[_headerImageView addSubview:_blurEffectView];
    [_dismissBottomView insertSubview:_bottomBlurView atIndex:0];
    
    [NSLayoutConstraint activateConstraints:@[[_bottomBlurView.leadingAnchor constraintEqualToAnchor:_dismissBottomView.leadingAnchor],
                                              [_bottomBlurView.trailingAnchor constraintEqualToAnchor:_dismissBottomView.trailingAnchor],
                                              [_bottomBlurView.topAnchor constraintEqualToAnchor:_dismissBottomView.topAnchor constant:-UIApplication.sharedApplication.statusBarFrame.size.height],
                                              [_bottomBlurView.bottomAnchor constraintEqualToAnchor:_dismissBottomView.bottomAnchor],
                                              ]
     ];
    
//    _bottomBlurView.layer.cornerRadius = cornerRadius_40;
//    _bottomBlurView.layer.maskedCorners = kCALayerMinXMinYCorner;
}

- (void) imageContainerViewPropertyActivationManager:(BOOL *)value {
    [_imageContainerView blurViewActivationManager:value];
    [_imageContainerView screenTitleActivationManager:value];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewModel numberOfVehicle];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"vehicleCell" forIndexPath:indexPath];
    
    [cell setCellProperty:[_viewModel returnVehicleInformationData:indexPath.row]];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeight_70;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yValue = (imageContainerViewHeight) - (scrollView.contentOffset.y + imageContainerViewHeight);
    CGFloat height = MIN(MAX(yValue, imageContainerVisibleHeight), UIScreen.mainScreen.bounds.size.height);
    
    printf("yValue %2f :\n", yValue);
    printf("height %2f :\n", height);
    printf("scrollView.contentOffset.y %2f :\n", scrollView.contentOffset.y);
    
    _topView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, height);
    
    if (height <= imageContainerVisibleHeight) {
        [self imageContainerViewPropertyActivationManager:true];
    } else {
        [self imageContainerViewPropertyActivationManager:false];
    };
    
}

@end

