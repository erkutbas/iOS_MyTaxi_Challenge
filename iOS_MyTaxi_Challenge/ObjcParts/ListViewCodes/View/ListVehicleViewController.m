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

//@property (strong, nonatomic) UIButton *dismissButton;

@end

@implementation ListVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self tableViewManagements];
    [self addImageContainer];
    [self changeCornerRadiusOfImageContainerView];
    [self addBlurView];
    [self addScreenTitleLabel];
    
    self.dismissBottomView.layer.cornerRadius = 40;
    self.dismissBottomView.layer.maskedCorners = kCALayerMinXMinYCorner;
    
    [self.dismissBottomView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.dismissBottomView.layer setShadowOpacity:0.8];
    [self.dismissBottomView.layer setShadowRadius:5.0];
    [self.dismissBottomView.layer setShadowOffset:CGSizeMake(0, -2.0)];
    
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

- (void) changeNavigationControllerConfigurations {
    
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void) tableViewManagements {
    self.vehicleTableView.delegate = self;
    self.vehicleTableView.dataSource = self;
    
    [self.vehicleTableView setContentInset:UIEdgeInsetsMake(UIApplication.sharedApplication.statusBarFrame.size.height + imageContainerViewHeight + 5, 0, 0, 0)];
}

- (void) changeCornerRadiusOfImageContainerView {
    self.imageContainerView.layer.cornerRadius = 60;
    self.imageContainerView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    
    [self.imageContainerView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.imageContainerView.layer setShadowOpacity:1.0];
    [self.imageContainerView.layer setShadowRadius:10.0];
    [self.imageContainerView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    self.headerImageView.layer.cornerRadius = 50;
    self.headerImageView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    
}

- (void) addImageContainer {
    
    self.imageContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, imageContainerViewHeight)];
//    self.imageContainerView.translatesAutoresizingMaskIntoConstraints = false;
    self.imageContainerView.backgroundColor = UIColor.purpleColor;
    [self.view addSubview:self.imageContainerView];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.imageContainerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [self.imageContainerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [self.imageContainerView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              ]
     ];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIApplication.sharedApplication.statusBarFrame.size.height + imageContainerViewHeight)];
    self.headerImageView.translatesAutoresizingMaskIntoConstraints = false;
    self.headerImageView.clipsToBounds = true;
    [self.headerImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.headerImageView setImage:[UIImage imageNamed:@"taxiSample.jpg"]];
//    self.headerImageView.backgroundColor = UIColor.purpleColor;
    [self.imageContainerView addSubview:self.headerImageView];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.headerImageView.leadingAnchor constraintEqualToAnchor:self.imageContainerView.leadingAnchor],
                                              [self.headerImageView.trailingAnchor constraintEqualToAnchor:self.imageContainerView.trailingAnchor],
                                              [self.headerImageView.topAnchor constraintEqualToAnchor:self.imageContainerView.topAnchor ],
                                              [self.headerImageView.bottomAnchor constraintEqualToAnchor:self.imageContainerView.bottomAnchor],
                                              ]
     ];
}

- (void) addBlurView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //always fill the view
    self.blurEffectView.frame = self.imageContainerView.bounds;
    self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
    self.blurEffectView.alpha = 0;
    
    [self.headerImageView addSubview:self.blurEffectView];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.headerImageView.leadingAnchor],
                                              [self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.headerImageView.trailingAnchor],
                                              [self.blurEffectView.topAnchor constraintEqualToAnchor:self.headerImageView.topAnchor constant:-UIApplication.sharedApplication.statusBarFrame.size.height],
                                              [self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.headerImageView.bottomAnchor],
                                              ]
     ];
}

- (void) blurViewActivationManager:(BOOL *)value {
    [UIView animateWithDuration:0.3 animations:^(void) {
        if (value) {
            self.blurEffectView.alpha = 1;
        } else {
            self.blurEffectView.alpha = 0;
        }
    }];
}


- (void) addScreenTitleLabel {
    self.screenTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    self.screenTitle.translatesAutoresizingMaskIntoConstraints = false;
    self.screenTitle.text = @"Vehicle List Screen";
    self.screenTitle.alpha = 0;
    [self.screenTitle setFont:[UIFont fontWithName:@"Avenier-Medium" size:16]];
    [self.screenTitle setTextColor:UIColor.whiteColor];
    [self.headerImageView addSubview:self.screenTitle];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.screenTitle.centerXAnchor constraintEqualToAnchor:self.headerImageView.centerXAnchor],
                                              [self.screenTitle.bottomAnchor constraintEqualToAnchor:self.headerImageView.bottomAnchor constant:-10],
                                              ]
     ];
}

- (void) screenTitleActivationManager:(BOOL *)value {
    [UIView animateWithDuration:0.3 animations:^(void) {
        if (value) {
            self.screenTitle.alpha = 1;
        } else {
            self.screenTitle.alpha = 0;
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"takasiCell" forIndexPath:indexPath];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yValue = (imageContainerViewHeight) - (scrollView.contentOffset.y + imageContainerViewHeight);
    CGFloat height = MIN(MAX(yValue, imageContainerVisibleHeight), UIScreen.mainScreen.bounds.size.height);
 
    printf("yValue %2f :\n", yValue);
    printf("height %2f :\n", height);
    printf("scrollView.contentOffset.y %2f :\n", scrollView.contentOffset.y);
    
    self.imageContainerView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, height);
    
    if (height <= imageContainerVisibleHeight) {
        [self blurViewActivationManager:true];
        [self screenTitleActivationManager:true];
    } else {
        [self blurViewActivationManager:false];
        [self screenTitleActivationManager:false];
    };
    
//    let y = (groupImageContainerViewHeight) - (scrollView.contentOffset.y + groupImageContainerViewHeight)
//    let height = min(max(y, groupImageContainerVisibleHeight), UIScreen.main.bounds.height)
//    print("scrollView.contentOffset.y : \(scrollView.contentOffset.y)")
//    print("y : \(y)")
//    print("height : \(height)")
//    groupImageContainer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    
//    if (height <= groupImageContainerVisibleHeight) {
//        print("bitirim")
//        groupImageContainerView.activationManagerOfStackViewGroupInfo(active: true)
//    }
//
//    if (height <= groupImageContainerVisibleHeight) {
//        groupImageContainerView.activationManagerOfMaxSizeContainerView(active: true)
//    } else {
//        groupImageContainerView.activationManagerOfMaxSizeContainerView(active: false)
//        groupImageContainerView.activationManagerOfStackViewGroupInfo(active: false)
//    }
    
    
}

@end

