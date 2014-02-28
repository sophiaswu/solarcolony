//
//  TowerDestroyer.m
//  SolarColony
//
//  Created by Student on 2/17/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "TowerRobot.h"

@implementation TowerRobot
@synthesize  targetLocation;
@synthesize towerTowerId;

@synthesize towerLife;
@synthesize towerPower;
@synthesize towerLocation;
@synthesize towerSpeed;
@synthesize towerActiveRadius;
@synthesize isAttacking;
@synthesize selfLocation;


- (instancetype) initTower:(CGPoint)location{
    
    self = [super init];
    if (!self) return(nil);
    //Game status global variables
    gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
    
    CCSprite* towerSprite = [CCSprite spriteWithFile:@"towerB.png"];
    [towerSprite setAnchorPoint:ccp(.8, 0.5)];
    //[self setLocation:ccp(200,200)];
    [self setLocation:location];
    selfLocation=location;
    [self setLife:100];
    [self setPower:50];
    [self setSetSpeedAttack:20];
    [self setSetSpeedAttack:50];
    [self setIsAttacking:false];
    
    //bullet= [CCSprite spriteWithFile:@"bulletA.png"];
    
    bullet = [[ NormalBullet alloc] initTower:location];
    //[bullet setPosition:ccp(location.x+10,location.y+10)];
    
    [self setPosition:[self getLocation]];
    
   //[[GridMap map] addChild:bullet];
    [self addChild:towerSprite];
    [self addChild:bullet];
    
    return self;
}

- (void) surveilance{
    
}
- (void) attack:(Soldier*) soldier{
    
}
- (void) attackTest:(CGPoint) soldier{
    
    [self setIsAttacking:true];
    
    //
    targetLocation=soldier;
    [self schedule: @selector(animatonAttack:) interval:1];
    
    
    //
    
    
    
}




-(void) animatonAttack: (ccTime) dt
{
    // bla bla bla
    //   if (counterTest<=5) {
   /* CCLOG(@"SHOTTING");
    //    counterTest++;
    //     if ([self numberOfRunningActions]==0) {
    [bullet setVisible:true];
    //   CCLOG(@"coord x %f",targetLocation.x);
    //  CCLOG(@"coord x %f",targetLocation.y);
    CGPoint targetLocations = [self convertToNodeSpace:targetLocation];
    //   CCLOG(@"coord x %f",targetLocations.x);
    //   CCLOG(@"coord x %f",targetLocations.y);
    CGPoint targetPrevious = [bullet position];
    //   id appearAction = [CCFadeIn actionWithDuration:.1];
    // id disappearAction = [CCFadeOut actionWithDuration:.1];
    movePoint = [CCMoveTo actionWithDuration:.1 position:targetLocations];
    returnPoint = [CCMoveTo actionWithDuration:.01 position:targetPrevious];
    
    [bullet runAction:[CCSequence actions: movePoint,returnPoint,nil]];
    //
    //    }
    */
    
    CCLOG(@"SHOTTING");
    [bullet setVisible:true];
    //   CCLOG(@"coord x %f",targetLocation.x);
    //  CCLOG(@"coord x %f",targetLocation.y);
    CGPoint targetLocations = [self convertToNodeSpace:targetLocation];
    //   CCLOG(@"coord x %f",targetLocations.x);
    //   CCLOG(@"coord x %f",targetLocations.y);
    CGPoint targetPrevious = [bullet position];
    //   id appearAction = [CCFadeIn actionWithDuration:.1];
    // id disappearAction = [CCFadeOut actionWithDuration:.1];
    bullet.targetLocation=targetLocations;
    [bullet startAttackTarget];
    
    //   }else{
    //   counterTest=0;
    
    [self unscheduleAllSelectors];
    [self setIsAttacking:false];
    // }
    
    
}


-(bool) getIsattacking{
    
    return nil;
}
-(void) setIsattacking:(bool) attack{
    
}

-(CCMenu*)loadMenu{
    
    return nil;
}

-(void) setPower:(int) power{
    towerPower=power;
}

-(int) getPower{
    return nil;
}

-(void) setLife:(int) life{
    towerLife=life;
}

-(int) getLife{
    return nil;
}

-(void) setSetSpeedAttack:(int) speed{
    towerSpeed=speed;
}

-(int) getSetSpeedAttack{
    return nil;
}

-(void) setClosesTarget:(Soldier*) soldier{}

-(Soldier*) getClosesTarget{
    return nil;
}

-(void) setLocation:(CGPoint) location{
    towerLocation=location;
}
-(CGPoint) getLocation{
    return towerLocation;
}

-(void) destroyedAnimation{}

-(void)beingAttacked:(int)attack_power{
    /*  int newHealth = [self getHEALTH] - attack_power;
     [self setHEALTH:newHealth];*/
}

-(void)dealloc{}
@end
