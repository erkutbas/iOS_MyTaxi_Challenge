//
//  ListDataViewModel.m
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/12/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListDataViewModel.h"
#import "VehicleListViewData.h"

@implementation ListDataViewModel

- (instancetype)initWithArrayData:(NSMutableArray<VehicleInformation *> *)arrayData {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _vehicleArray = [arrayData copy];
    
    return self;
    
}

- (NSString *)activationTitle:(NSUInteger)index {
    return [_vehicleArray objectAtIndex:index].vehicleState;
}

- (NSString *)idValue:(NSUInteger)index {
    return [_vehicleArray objectAtIndex:index].vehicleID;
}

- (NSUInteger *)numberOfVehicle {
    return _vehicleArray.count;
}

- (VehicleInformation *)returnVehicleInformationData:(NSUInteger)index {
    return [_vehicleArray objectAtIndex:index];
}


@end
