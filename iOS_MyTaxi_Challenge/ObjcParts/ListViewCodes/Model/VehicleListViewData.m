//
//  VehicleListViewData.m
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/12/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import "VehicleListViewData.h"
#import "VehicleInformation.h"
#import <UIKit/UIKit.h>

@implementation VehicleListViewData

- (instancetype) initWithArrayData:(NSMutableArray<VehicleInformation *> *)arrayData topImage:(UIImage *)inputImage {
    
    self = [super init];

    if (!self) {
        return nil;
    }

    _vehicleArray = [arrayData copy];
    _topImage = [inputImage copy];

    return self;

}

@end
