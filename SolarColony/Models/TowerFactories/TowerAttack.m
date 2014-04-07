//
//  TowerDestroyer.m
//  SolarColony
//
//  Created by Student on 2/17/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "TowerAttack.h"

@implementation TowerAttack
@synthesize  targetLocation;
@synthesize towerTowerId;

@synthesize towerLife;
@synthesize towerPower;
@synthesize towerLocation;
@synthesize towerSpeed;
@synthesize towerActiveRadius;
@synthesize isAttacking;
@synthesize selfLocation;
@synthesize isCharging;
@synthesize isDeath;
@synthesize whichRace;

- (instancetype) initTower:(CGPoint)location Race: (NSString*) raceType Power: (int) power{
    
    self = [super init];
    if (!self) return(nil);
    
    //Game status global variables
    gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];

    
    if ([raceType isEqualToString:@"Human"]) {
        
        towerSprite = [CCSprite spriteWithFile:@"towerB.png"];
        [towerSprite setAnchorPoint:ccp(.8, 0.5)];
        towerTowerId=2;
        selfLocation=location;
        [self setLocation:location];
        [self setLife:100];
        [self setPower:power];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:50];
        [self setIsAttacking:false];
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
        isCharging=false;
        [self setPosition:[self getLocation]];

    }if ([raceType isEqualToString:@"Robot"]) {
        
        towerSprite = [CCSprite spriteWithFile:@"towerB.png"];
        [towerSprite setAnchorPoint:ccp(.8, 0.5)];
        towerTowerId=2;
        selfLocation=location;
        [self setLocation:location];
        [self setLife:100];
        [self setPower:power];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:50];
        [self setIsAttacking:false];
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
        isCharging=false;
     
        [self setPosition:[self getLocation]];

    }if ([raceType isEqualToString:@"Magic"]) {
        
        towerSprite = [CCSprite spriteWithFile:@"towerB.png"];
        [towerSprite setAnchorPoint:ccp(.8, 0.5)];
        towerTowerId=2;
        selfLocation=location;
        [self setLocation:location];
        [self setLife:100];
        [self setPower:power];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:50];
        [self setIsAttacking:false];

        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
        isCharging=false;
  
        [self setPosition:[self getLocation]];

    }
    whichRace=raceType;
    
    [self addChild:towerSprite];
    [self addChild:bullet];
 
    return self;
}

-(CGRect) getBoundingBoxTower{
    CGRect originTower;
    originTower.origin=ccp(towerLocation.x-20, towerLocation.y-20);
    originTower.size.width=30;
    originTower.size.height=30;
    return originTower;
}
- (void) surveilance{
    
}
- (void) attack:(Soldier*) soldier{
    
}
- (void) attackTest:(CGPoint) soldier{
    
    [self setIsAttacking:true];    
    //
    targetLocation=soldier;
    //  [self schedule: @selector(animatonAttack:) interval:1];
    bullet.targetLocation=soldier;
    [self schedule: @selector(animatonAttackTest:) interval:1];
 
}

-(void) animatonAttackTest: (ccTime) dt
{
    //  bullet.targetLocation=soldier;
    [bullet delegateRaceAttack];
    [self unscheduleAllSelectors];
    [self setIsAttacking:false];
}

-(void) reloadAnimation
{
    
    if (isCharging==false) {
        isCharging=true;
        CCProgressFromTo *to1 = [CCProgressFromTo actionWithDuration:1 from:100 to:0];
        CCSprite* progressSprite = [CCSprite spriteWithFile:@"towerBcharge.png"];
        timeBar = [CCProgressTimer progressWithSprite:progressSprite];
        [timeBar setAnchorPoint:ccp(.8, 0.5)];
        counter=0;
        [self addChild:timeBar];
        [timeBar runAction:to1];
        [self schedule: @selector(doNothingCharge:) interval:.3];
    }
    
}

-(void) doNothingCharge: (ccTime) dt{

    NSLog(@" waitting to charge %d", counter);
    
    if (counter > 1) {
        
        NSLog(@"stopped 1st scheduler");
        isCharging=false;
        counter=0;
        [self unschedule:@selector(doNothingCharge:)];
    }else{
         counter++;
    }
 
}


-(void)beignattacked{
    
    if ([self getLife]<=0) {
        isDeath=true;
    }else{
       [self setLife:([self getLife]-10)];
    }
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
    return towerLife;
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
