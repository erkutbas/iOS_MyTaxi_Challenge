//
//  ListDataViewModel.m
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/12/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListDataViewModel.h"

@implementation ListDataViewModel

- (instancetype)initWithArrayData:(NSMutableArray<VehicleInformation *> *)arrayData topImage:(UIImage *)inputImage countryInformation:(CountryInformaton *)countryInfo {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _vehicleArray = [arrayData copy];
    _topImage = [inputImage copy];
    _countryInformation = countryInfo;
    
    
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

- (UIImage *) returnTopImage {
    return _topImage;
}

- (CountryInformaton *) returnCountryInformation {
    return _countryInformation;
}


@end
