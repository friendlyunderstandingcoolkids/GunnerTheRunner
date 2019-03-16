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
    //[NSTimer scheduledTimerWithTimeInterval:1.0f
      //                               target:self selector:@selector(gyroDetec:) userInfo:nil repeats:YES];
    
    motionManager = [[CMMotionManager alloc] init];
    if (motionManager.gyroAvailable) {
        motionManager.gyroUpdateInterval = 1.0/60.0;
        [motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler: ^(CMGyroData *gyroData, NSError *error)
         {
             CMRotationRate rotate = gyroData.rotationRate;
             //NSLog(@"rotation rate = [%f, %f, %f]", rotate.x, rotate.y, rotate.z);
             self->bg1.center = CGPointMake(self->bg1.center.x - (rotate.x / 9), self->bg1.center.y + (rotate.y / 9));
             self->bg2.center = CGPointMake(self->bg2.center.x - (rotate.x / 7), self->bg2.center.y + (rotate.y / 7));
             self->bg3.center = CGPointMake(self->bg3.center.x - (rotate.x / 5), self->bg3.center.y + (rotate.y / 5));
             self->bg4.center = CGPointMake(self->bg4.center.x - (rotate.x / 2), self->bg4.center.y + (rotate.y / 2));
             
             self->bullets.center = CGPointMake(self->bullets.center.x - (rotate.x / 4), self->bullets.center.y + (rotate.y / 4));
             self->gun.center = CGPointMake(self->gun.center.x - (rotate.x / 4), self->gun.center.y + (rotate.y / 4));
             //self->title.center = CGPointMake(self->title.center.x - rotate.x / 8, self->title.center.y + rotate.y / 8);
             //self->knife.center = CGPointMake(self->knife.center.x - rotate.x / 8, self->knife.center.y + rotate.y / 8);
             
         }];
    } else {
        NSLog(@"No gyroscope on device.");
    }
}

- (void) gyroDetec:(NSTimer *)timer
{
    //Do calculations.

}

- (IBAction)parallaxTest:(UIPanGestureRecognizer *) params {
//    CGPoint translation = [params translationInView:self.view];
//    NSLog(@"%f", translation.x);
//    NSLog(@"%f", translation.y);
//    bg1.center = CGPointMake(bg1.center.x, bg1.center.y + translation.y / 3000);
//    bg2.center = CGPointMake(bg2.center.x, bg2.center.y + translation.y / 1500);
//    bg3.center = CGPointMake(bg3.center.x, bg3.center.y + translation.y / 1000);
//    bg4.center = CGPointMake(bg4.center.x, bg4.center.y + translation.y / 200);
//
//    bullets.center = CGPointMake(bullets.center.x, bullets.center.y + translation.y / 600);
//    gun.center = CGPointMake(gun.center.x, gun.center.y + translation.y / 600);
    //title.center = CGPointMake(title.center.x + translation.x / 500, title.center.y + translation.y / 500);
    //knife.center = CGPointMake(knife.center.x + translation.x / 550, knife.center.y + translation.y / 550);
}

- (IBAction)startGame:(UITapGestureRecognizer *) params {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Game" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RWTViewController"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];

}
@end
