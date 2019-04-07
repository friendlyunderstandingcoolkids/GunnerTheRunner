//
//  RWTSpike.h
//  GunnerTheRunner
//
//  Created by Kabilan Thangarajah on 2019-04-06.
//

#import "RWTModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RWTSpike : RWTModel
- (instancetype)initWithShader:(RWTBaseEffect *)shader;
- (void)updateWithDelta:(NSTimeInterval)dt;
@end

NS_ASSUME_NONNULL_END
