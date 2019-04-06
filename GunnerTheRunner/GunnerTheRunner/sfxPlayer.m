//
//  sfxPlayer.m
//  GunnerTheRunner
//
//  Created by Dylan Chew on 2019-03-23.
//

#import <Foundation/Foundation.h>
#import "sfxPlayer.h"
#import "SoundManager.h"

@implementation sfxPlayer

- (void) setup {
    [SoundManager sharedManager].allowsBackgroundMusic = YES;
    [[SoundManager sharedManager] prepareToPlay];
}

- (void) startMenuMusic {
    //[self setup];
    [SoundManager sharedManager].allowsBackgroundMusic = YES;
    [[SoundManager sharedManager] prepareToPlay];
    [[SoundManager sharedManager] stopMusic];
    [[SoundManager sharedManager] playMusic:@"mainMenu.mp3" looping:YES];
}
- (void) startGameMusic {
    [self setup];
    [[SoundManager sharedManager] stopMusic:YES];
    [[SoundManager sharedManager] playMusic:@"mainGame.mp3" looping:YES];
}
- (void) gameStartFX {
    [self setup];
    [[SoundManager sharedManager]playSound:@"gameStart.mp3" looping:NO];
}
- (void) knifeThrowFX {
    [self setup];
    [[SoundManager sharedManager]playSound:@"knifeThrow.mp3" looping:NO];
}
- (void) oof {
    [self setup];
    [[SoundManager sharedManager]playSound:@"oof.mp3" looping:NO];
}
- (void) oof2 {
    [self setup];
    [[SoundManager sharedManager]playSound:@"oof2.mp3" looping:NO];
}
- (void) jump {
    [self setup];
    [[SoundManager sharedManager]playSound:@"jump.mpr" looping:NO];
}
@end
