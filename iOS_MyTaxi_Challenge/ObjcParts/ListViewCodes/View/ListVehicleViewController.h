//
//  ListVehicleViewController.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/11/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageContainerView.h"
#import "ListDataViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListVehicleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *vehicleTableView;
@property (strong, nonatomic) IBOutlet UIView *dismissBottomView;

@property (strong, nonatomic) ListDataViewModel *viewModel;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) ImageContainerView *imageContainerView;
@property (strong, nonatomic) UIVisualEffectView *bottomBlurView;

@end

NS_ASSUME_NONNULL_END
