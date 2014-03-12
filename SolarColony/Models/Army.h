//
//  Army.h
//  SolarColony
//
//  Created by Charles on 2/18/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wave.h"

@interface Army : NSObject
+ (instancetype) army: (NSString *) rid;
- (instancetype) init: (NSString *) rid;
- (int) count;
- (void) addWave: (Wave *) sol;
- (Wave *) popWave;
@property(assign, atomic) NSString *request_id;
@end
