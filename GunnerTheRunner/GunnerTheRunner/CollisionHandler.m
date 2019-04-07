//
//  CollisionHandler.m
//  GunnerTheRunner
//
//  Created by Kabilan Thangarajah on 2019-03-09.
//

#import "CollisionHandler.h"
#import "RWTGlock.h"
#import "RWTMushroom.h"
#import "RWTBullet.h"
#import "RWTKnife.h"
#import "RWTSpike.h"

//Values for Glock
float GxBoundsTop = 1.0f / 2.0f;
float GyBoundsTop = 0.1f / 2.0f;
float GxOffsetTop = -0.3f / 2.0f;
float GyOffsetTop = 0.1f / 2.0f;

float GxBoundsBot = 0.2f / 2.0f;
float GyBoundsBot = 0.5f / 2.0f;
float GxOffsetBot = -0.2f / 2.0f;
float GyOffsetBot = -0.1f / 2.0f;

float GtBboxTop;
float GtBboxRight;
float GtBboxBot;
float GtBboxLeft;

float GbBboxTop;
float GbBboxRight;
float GbBboxBot;
float GbBboxLeft;

//Values for Mushroom
float MxBounds = 0.8f / 2.0f;
float MyBounds = 1.0f / 2.0f;

float MBboxTop;
float MBboxRight;
float MBboxBot;
float MBboxLeft;

//Values for Spike
float SxBounds = 0.8f;
float SyBounds = 1;

float SBboxTop;
float SBboxRight;
float SBboxBot;
float SBboxLeft;

//Values for Bullet
float BxBounds = 1.0f;
float ByBounds = 0.3f;

float BBboxTop;
float BBboxRight;
float BBboxBot;
float BBboxLeft;

//Values for Knife
float Kbounds = 0.5f;
float kBBoxTop;
float kBBoxRight;
float kBBoxBot;
float kBBoxLeft;

@interface CollisionHandler ()
{
    BOOL didMushroomHitGlock;
    BOOL didBulletHitGlock;
    BOOL didKnifeHitBullet;
    BOOL didKnifeHitMush;
    BOOL didSpikeHitGlock;
}
@end
@implementation CollisionHandler{
    RWTGlock *_glock;
    RWTMushroom *_mush;
    RWTMushroom *_bullet;
    
}

- (BOOL)mushroomDetection:(RWTMushroom *)mushroom glockDetection:(RWTGlock *)glock{
    
    didMushroomHitGlock = false;
    GtBboxTop = glock.position.y + GyOffsetTop + GyBoundsTop;
    GtBboxBot = glock.position.y + GyOffsetTop - GyBoundsTop;
    GtBboxRight = glock.position.x + GxOffsetTop + GxBoundsTop;
    GtBboxLeft = glock.position.x + GxOffsetTop - GxBoundsTop;
    
    GbBboxTop = glock.position.y + GyOffsetBot + GyBoundsBot;
    GbBboxBot = glock.position.y + GyOffsetBot - GyBoundsBot;
    GbBboxRight = glock.position.x + GxOffsetBot + GxBoundsBot;
    GbBboxLeft = glock.position.x + GxOffsetBot - GxBoundsBot;
    
    MBboxTop = mushroom.position.y + MyBounds;
    MBboxBot = mushroom.position.y - MyBounds;
    MBboxRight = mushroom.position.x + MxBounds;
    MBboxLeft = mushroom.position.x - MxBounds;
    //MBboxLeft >= GbBboxRight &&
    if(((GbBboxBot <= MBboxTop && GbBboxBot >= MBboxBot) || (GbBboxTop <= MBboxTop && GbBboxTop >= MBboxBot)) && ((GbBboxLeft >= MBboxLeft && GbBboxLeft <= MBboxRight) || (GbBboxRight >= MBboxLeft && GbBboxRight <= MBboxRight))){
        //printf("hit");
        didMushroomHitGlock = true;
    }
    
    return didMushroomHitGlock;
}

- (BOOL)spikeDetection:(RWTSpike *)spike glockDetection:(RWTGlock *)glock{
    
    didSpikeHitGlock = false;
    GtBboxTop = glock.position.y + GyOffsetTop + GyBoundsTop;
    GtBboxBot = glock.position.y + GyOffsetTop - GyBoundsTop;
    GtBboxRight = glock.position.x + GxOffsetTop + GxBoundsTop;
    GtBboxLeft = glock.position.x + GxOffsetTop - GxBoundsTop;
    
    GbBboxTop = glock.position.y + GyOffsetBot + GyBoundsBot;
    GbBboxBot = glock.position.y + GyOffsetBot - GyBoundsBot;
    GbBboxRight = glock.position.x + GxOffsetBot + GxBoundsBot;
    GbBboxLeft = glock.position.x + GxOffsetBot - GxBoundsBot;
    
    SBboxTop = spike.position.y + SyBounds;
    SBboxBot = spike.position.y - SyBounds;
    SBboxRight = spike.position.x + SxBounds;
    SBboxLeft = spike.position.x - SxBounds;
    //MBboxLeft >= GbBboxRight &&
    if(((GbBboxBot <= SBboxTop && GbBboxBot >= SBboxBot) || (GbBboxTop <= SBboxTop && GbBboxTop >= SBboxBot)) && ((GbBboxLeft >= SBboxLeft && GbBboxLeft <= SBboxRight) || (GbBboxRight >= SBboxLeft && GbBboxRight <= SBboxRight))){
        //printf("hit");
        didSpikeHitGlock = true;
    }
    
    return didSpikeHitGlock;
}

- (BOOL)bulletDetection:(RWTBullet *)bullet glockDetection:(RWTGlock *)glock{
    
    didBulletHitGlock = false;
    GtBboxTop = glock.position.y + GyOffsetTop + GyBoundsTop;
    GtBboxBot = glock.position.y + GyOffsetTop - GyBoundsTop;
    GtBboxRight = glock.position.x + GxOffsetTop + GxBoundsTop;
    GtBboxLeft = glock.position.x + GxOffsetTop - GxBoundsTop;
    
    GbBboxTop = glock.position.y + GyOffsetBot + GyBoundsBot;
    GbBboxBot = glock.position.y + GyOffsetBot - GyBoundsBot;
    GbBboxRight = glock.position.x + GxOffsetBot + GxBoundsBot;
    GbBboxLeft = glock.position.x + GxOffsetBot - GxBoundsBot;
    
    BBboxTop = bullet.position.y + ByBounds;
    BBboxBot = bullet.position.y - ByBounds;
    BBboxRight = bullet.position.x + BxBounds;
    BBboxLeft = bullet.position.x - BxBounds;
    //MBboxLeft >= GbBboxRight &&
    if(((GbBboxBot <= BBboxTop && GbBboxBot >= BBboxBot) || (GbBboxTop <= BBboxTop && GbBboxTop >= BBboxBot)) && ((GbBboxLeft >= BBboxLeft && GbBboxLeft <= BBboxRight) || (GbBboxRight >= BBboxLeft && GbBboxRight <= BBboxRight))){
        //printf("hit bot \n");
        didBulletHitGlock = true;
    }
    //MBboxLeft >= GbBboxRight &&
    if(((GtBboxBot <= BBboxTop && GtBboxBot >= BBboxBot) || (GtBboxTop <= BBboxTop && GtBboxTop >= BBboxBot)) && ((GtBboxLeft >= BBboxLeft && GtBboxLeft <= BBboxRight) || (GtBboxRight >= BBboxLeft && GtBboxRight <= BBboxRight))){
        //printf("hit top \n");
        didBulletHitGlock = true;
    }
    
    return didBulletHitGlock;
}


- (BOOL)knifeDetection:(RWTKnife *)knife bulletDetection:(RWTBullet *)bullet {
    didKnifeHitBullet = false;
    
    BBboxTop = bullet.position.y + ByBounds;
    BBboxBot = bullet.position.y - ByBounds;
    BBboxRight = bullet.position.x + BxBounds;
    BBboxLeft = bullet.position.x - BxBounds;
    
    kBBoxTop = knife.position.y + Kbounds;
    kBBoxRight = knife.position.x + Kbounds;
    kBBoxBot = knife.position.y - Kbounds;
    kBBoxLeft = knife.position.x -  Kbounds;
    
//    if(((kBBoxBot <= BBboxTop && kBBoxBot >= BBboxBot) || (kBBoxTop <= BBboxTop && kBBoxTop >= BBboxBot)) && ((kBBoxLeft >= BBboxLeft && kBBoxLeft <= BBboxRight) || (kBBoxRight >= BBboxLeft && kBBoxRight <= BBboxRight))){
    float tempx = ABS(knife.position.x - bullet.position.x);
    float tempy = ABS(knife.position.y - bullet.position.y);
    float hyp = sqrtf(powf(tempx, 2) + powf(tempy, 2));
    if(hyp <= 0.5f) {
        printf("knifeHitBullet");
        didKnifeHitBullet = true;
    }
    
    return didKnifeHitBullet;
}

- (BOOL)knifeDetection:(RWTKnife *)knife mushDetection:(RWTMushroom *)mushroom {
    didKnifeHitMush = false;
    
    MBboxTop = mushroom.position.y + MyBounds;
    MBboxBot = mushroom.position.y - MyBounds;
    MBboxRight = mushroom.position.x + MxBounds;
    MBboxLeft = mushroom.position.x - MxBounds;
    
    kBBoxTop = knife.position.y + Kbounds;
    kBBoxRight = knife.position.x + Kbounds;
    kBBoxBot = knife.position.y - Kbounds;
    kBBoxLeft = knife.position.x -  Kbounds;
    
    if(((kBBoxBot <= MBboxTop && kBBoxBot >= MBboxBot) || (kBBoxTop <= MBboxTop && kBBoxTop >= MBboxBot)) && ((kBBoxLeft >= MBboxLeft && kBBoxLeft <= MBboxRight) || (kBBoxRight >= MBboxLeft && kBBoxRight <= MBboxRight))){
        printf("knifeHitMush");
        didKnifeHitMush = true;
    }
    
    return didKnifeHitMush;
}

@end
//1. function to recieve two objects (both of which are different objects to be collided with eachother)
//2. function must be accesible by the view contrller
//3. function must return a boolean (or equivalent)
//4. function must take the two objects and run a function of them that retrieves their bounding parameters
//5. function must test bounding parameters

