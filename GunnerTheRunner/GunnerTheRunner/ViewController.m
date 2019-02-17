//
//  ViewController.m
//  GunnerTheRunner
//
//  Created by Dylan Chew on 2019-02-16.
//

#import "ViewController.h"

@interface ViewController () {
    IBOutlet UIImageView *bg1;
    IBOutlet UIImageView *bg2;
    IBOutlet UIImageView *bg3;
    IBOutlet UIImageView *bg4;
    
    IBOutlet UIImageView *bullets;
    IBOutlet UIImageView *gun;
    IBOutlet UIImageView *title;
    IBOutlet UIImageView *knife;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    motionManager = [[CMMotionManager alloc] init];
    
    if (motionManager.gyroAvailable) {
        motionManager.gyroUpdateInterval = 1.0/60.0;
        [motionManager startGyroUpdates];
        
        opQ = [NSOperationQueue currentQueue];
        CMGyroHandler gyroHandler = ^ (CMGyroData *gyroData, NSError *error) {
            CMRotationRate rotate = gyroData.rotationRate;
            NSLog(@"rotation rate = [%f, %f, %f]", rotate.x, rotate.y, rotate.z);
        };
    } else {
        NSLog(@"No gyroscope on device.");
    }
}

- (IBAction)parallaxTest:(UIPanGestureRecognizer *) params {
    CGPoint translation = [params translationInView:self.view];
    NSLog(@"%f", translation.x);
    NSLog(@"%f", translation.y);
    bg1.center = CGPointMake(bg1.center.x, bg1.center.y + translation.y / 3000);
    bg2.center = CGPointMake(bg2.center.x, bg2.center.y + translation.y / 1500);
    bg3.center = CGPointMake(bg3.center.x, bg3.center.y + translation.y / 1000);
    bg4.center = CGPointMake(bg4.center.x, bg4.center.y + translation.y / 200);
    
    bullets.center = CGPointMake(bullets.center.x, bullets.center.y + translation.y / 600);
    gun.center = CGPointMake(gun.center.x, gun.center.y + translation.y / 600);
    //title.center = CGPointMake(title.center.x + translation.x / 500, title.center.y + translation.y / 500);
    //knife.center = CGPointMake(knife.center.x + translation.x / 550, knife.center.y + translation.y / 550);
}

- (IBAction)startGame:(UITapGestureRecognizer *) params {
    NSLog(@"binch");

}
@end
