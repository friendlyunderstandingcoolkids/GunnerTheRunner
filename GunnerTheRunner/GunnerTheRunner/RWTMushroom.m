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
float speed = 6;
@interface RWTMushroom () {
    int spawnedPos;
    float xpos;
}
@end

@implementation RWTMushroom

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
    if ((self = [super initWithName:"mushroom" shader:shader vertices:(RWTVertex *)Mushroom_Cylinder_mushroom_Vertices vertexCount:sizeof(Mushroom_Cylinder_mushroom_Vertices)/sizeof(Mushroom_Cylinder_mushroom_Vertices[0])])) {
        [self loadTexture:@"mushroom.png"];
        self.rotationY = M_PI;
        self.rotationX = M_PI_2;
        self.scale = GLKVector3Make(0.22, 0.22, 0.22);
        self.position = GLKVector3Make(12, -1, 1.5);
        self.rotationX -= M_PI/180 * 20;
        self.rotationY -= M_PI/180 * 10;
        self.rotationZ = M_PI/180 * 40;
        spawnedPos = [self getRandomNumberBetween:8 to:12];
        xpos = spawnedPos;
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    
    xpos -= dt*speed;
    if(self.position.x < -10){
        spawnedPos = [self getRandomNumberBetween:8 to:12];
        self.position = GLKVector3Make(spawnedPos, -1, 1.5);
        xpos = spawnedPos;
    }
    else{
        self.position = GLKVector3Make(xpos, -1, 1.5);
    }
}

- (void)setRandomPosition:(int)position {
    spawnedPos = position;
}
- (float)getMushPosition {
    return spawnedPos;
}

-(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

@end
