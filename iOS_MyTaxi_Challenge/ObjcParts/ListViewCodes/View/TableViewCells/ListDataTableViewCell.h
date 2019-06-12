//
//  ListDataTableViewCell.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/11/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleInformation.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListDataTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *activationInfo;
@property (strong, nonatomic) IBOutlet UILabel *vehicleIDInformation;
@property (strong, nonatomic) IBOutlet UIView *cellContainerView;
@property (strong, nonatomic) IBOutlet UIImageView *vehicleIcon;

- (void) setCellProperty:(VehicleInformation *)info;

@end

NS_ASSUME_NONNULL_END
