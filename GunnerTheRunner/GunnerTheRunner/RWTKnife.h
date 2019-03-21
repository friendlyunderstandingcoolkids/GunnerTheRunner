//
//  RWTKnife.h
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-03-16.
//

#import "RWTModel.h"

@interface RWTKnife : RWTModel

- (instancetype)initWithShader:(RWTBaseEffect *)shader velx:(float)velx vely:(float)vely;
- (void)updateWithDelta:(NSTimeInterval)dt;
- (float) getXPosition;
- (float) getYPosition;

@end

