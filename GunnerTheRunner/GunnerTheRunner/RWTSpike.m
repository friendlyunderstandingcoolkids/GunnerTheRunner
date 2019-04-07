//
//  RWTSpike.m
//  GunnerTheRunner
//
//  Created by Kabilan Thangarajah on 2019-04-06.
//

#import "RWTSpike.h"
#import "spike.h"

@interface RWTSpike () {
    int spawnedPos;
    float xpos;
    float spikeSpeed;
}
@end
@implementation RWTSpike

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
    if ((self = [super initWithName:"spike" shader:shader vertices:(RWTVertex *)Spike_Material_Vertices vertexCount:sizeof(Spike_Material_Vertices)/sizeof(Spike_Material_Vertices[0])])) {
        [self loadTexture:@"brass.png"];
        self.scale = GLKVector3Make(0.55, 0.55, 0.22);
        self.position = GLKVector3Make(12, -1, 1.5);
        spawnedPos = [self getRandomNumberBetween:8 to:12];
        xpos = spawnedPos;
    }
    spikeSpeed = [self getRandomNumberBetween:5 to:10];
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    NSLog(@"%f", spikeSpeed);
    xpos -= dt*spikeSpeed;
    if(self.position.x < -10){
        spikeSpeed = [self getRandomNumberBetween:5 to:10];
        spawnedPos = [self getRandomNumberBetween:8 to:12];
        self.position = GLKVector3Make(spawnedPos, -1, 1.5);
        xpos = spawnedPos;
    }
    else{
        self.position = GLKVector3Make(xpos, -1, 1.5);
    }
}

-(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

@end
