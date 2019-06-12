//
//  VehicleInformation.m
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/12/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import "VehicleInformation.h"

@implementation VehicleInformation

- (instancetype)initWithID:(NSString *)vehicleID state:(NSString *)vehicleState {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _vehicleID = [vehicleID copy];
    _vehicleState = [vehicleState copy];
    
    return self;
}


@end
