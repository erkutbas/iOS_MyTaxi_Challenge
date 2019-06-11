//
//  ListVehicleViewController.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/11/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListVehicleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *vehicleTableView;
@property (strong, nonatomic) IBOutlet UIView *dismissBottomView;


@end

NS_ASSUME_NONNULL_END
