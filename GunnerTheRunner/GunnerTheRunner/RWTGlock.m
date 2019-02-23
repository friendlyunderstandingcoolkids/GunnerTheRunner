//
//  RWTGlock.m
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-02-23.
//

#import "RWTGlock.h"
#import "Glock19.h"

@implementation RWTGlock

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
    if ((self = [super initWithName:"glock" shader:shader vertices:(RWTVertex *)Cube_Material_Vertices vertexCount:sizeof(Cube_Material_Vertices)/sizeof(Cube_Material_Vertices[0])])) {
        [self loadTexture:@"rainbow.png"];
        self.rotationY = M_PI;
        self.rotationX = M_PI_2;
        self.scale = 0.5;
        self.position = GLKVector3Make(0.8, 0.8, 1.5);
        
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    self.rotationX += M_PI * dt;
    //self.rotationY += M_PI * dt;
}

@end
