//
//  RWTGlock.m
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-02-23.
//

#import "RWTMushroom.h"
#import "mushroom.h"

float xPosition = 8;
float xPosition2 = 8;
float speed = 3;
float OTP = 3;
float OTP2 = 4;
@interface RWTMushroom () {
    
}
@end

@implementation RWTMushroom

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
    if ((self = [super initWithName:"mushroom" shader:shader vertices:(RWTVertex *)Mushroom_Cylinder_mushroom_Vertices vertexCount:sizeof(Mushroom_Cylinder_mushroom_Vertices)/sizeof(Mushroom_Cylinder_mushroom_Vertices[0])])) {
        [self loadTexture:@"mushroom.png"];
        self.rotationY = M_PI;
        self.rotationX = M_PI_2;
        self.scale = GLKVector3Make(0.22, 0.22, 0.22);
        self.position = GLKVector3Make(8, -1, 1.5);
        self.rotationX -= M_PI/180 * 20;
        self.rotationY -= M_PI/180 * 10;
        self.rotationZ = M_PI/180 * 40;
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt isMush2:(BOOL)isMush2 {

    if(isMush2){
        if(xPosition < -10){
            OTP = [self getRandomNumberBetween:2 to:5];
            xPosition = 9;
        }
        xPosition -= dt * speed * OTP;
        self.position = GLKVector3Make(xPosition, -1, 1.5);
    }
    else{
        if(xPosition2 < -10){
            OTP2 = [self getRandomNumberBetween:2 to:5];
            xPosition2 = 9;
        }
        xPosition2 -= dt * speed * OTP2;
        self.position = GLKVector3Make(xPosition2, -1, 1.5);
    }
}

-(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

@end
