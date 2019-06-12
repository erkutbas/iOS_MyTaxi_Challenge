//
//  VehicleListViewData.m
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/12/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import "VehicleListViewData.h"
#import "VehicleInformation.h"

@implementation VehicleListViewData

- (instancetype) initWithArrayData:(NSMutableArray<VehicleInformation *> *)arrayData {
    
    self = [super init];

    if (!self) {
        return nil;
    }

    _vehicleArray = [arrayData copy];

    return self;

}

//- (instancetype) initWithArrayData:(VehicleInformation *)arrayData {
//    self = [super init];
//
//    if (!self) {
//        return nil;
//    }
//
//    _vehicleArray = [arrayData copy];
//
//    return self;
//}

@end
