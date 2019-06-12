//
//  ListDataTableViewCell.m
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/11/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import "ListDataTableViewCell.h"
#import "VehicleInformation.h"
#import "Constants.h"

@implementation ListDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self cellViewConfiguration];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) cellViewConfiguration {
    self.cellContainerView.layer.cornerRadius = cornerRadius_10;
    //self.cellContainerView.layer.maskedCorners = kCALayerMinXMaxYCorner;
    
    [self.cellContainerView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.cellContainerView.layer setShadowOpacity:0.8];
    [self.cellContainerView.layer setShadowRadius:2.0];
    [self.cellContainerView.layer setShadowOffset:CGSizeMake(0.0, 2.0)];
}

- (void)setVehicleIcon {
    int x = arc4random() % 5;
    
    if (x == 1) {
        [_vehicleIcon setImage:[UIImage imageNamed:@"taxi_1"]];
    } else if (x == 2) {
        [_vehicleIcon setImage:[UIImage imageNamed:@"taxi_2"]];
    } else if (x == 3) {
        [_vehicleIcon setImage:[UIImage imageNamed:@"taxi_3"]];
    } else if (x == 4) {
        [_vehicleIcon setImage:[UIImage imageNamed:@"taxi_4"]];
    } else {
        [_vehicleIcon setImage:[UIImage imageNamed:@"taxi_1"]];
    }
}

- (void)setCellProperty:(VehicleInformation *)info {
    [_activationInfo setText:[info vehicleState]];
    [_vehicleIDInformation setText:[info vehicleID]];
    
    [self setVehicleIcon];
    
}

-(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

@end
