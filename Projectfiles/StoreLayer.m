//
//  StoreLayer.m
//  bullet hell-o
//
//  Created by Kevin Frans on 7/10/13.
//
//

#import "StoreLayer.h"
#import "HelloWorldLayer.h"

@implementation StoreLayer

int numPowerUp1;
int numPowerUp2;

int coins;
NSString *CoinString;
CCLabelBMFont *coinsLabel;

-(id) init
{
	if ((self = [super init]))
	{
        CCSprite* background = [CCSprite spriteWithFile:@"shop.png"];
        background.position = ccp(160,240);
        [self addChild:background];
        
        //glClearColor(255, 255, 255, 255);
        screenSize = [[CCDirector sharedDirector] winSize];
        CGPoint screenCenter = [[CCDirector sharedDirector] screenCenter];
        CCLabelBMFont *gameTitle = [CCLabelTTF labelWithString:@"STORE" fontName:@"Bend2SquaresBRK" fontSize:75];
        gameTitle.color = ccc3(0,0,0);
        gameTitle.position = ccp(screenCenter.x, screenCenter.y + 210);
     //   [self addChild:gameTitle];
        
        int CoinNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"coins"];
        //        NSNumber *endingHighScoreNumber = [MGWU objectForKey:@"sharedHighScore"];
        coins = CoinNumber;
        CoinString = [[NSString alloc] initWithFormat:@"Coins: %i", coins];
        coinsLabel = [CCLabelTTF labelWithString:CoinString fontName:@"AvenirNext-UltraLight" fontSize:30];
        coinsLabel.position = ccp(screenSize.width/2, 75);
        coinsLabel.color = ccc3(255, 255, 255);
        [self addChild:coinsLabel];
        
        
        CCLabelBMFont *label1 = [CCLabelTTF labelWithString:@"1.00" fontName:@"Bend2SquaresBRK" fontSize:30];
        label1.color = ccc3(0,0,0);
        label1.position = ccp(80, 280);
      //  [self addChild:label1];
        
        CCLabelBMFont *label2 = [CCLabelTTF labelWithString:@"2.00" fontName:@"Bend2SquaresBRK" fontSize:30];
        label2.color = ccc3(0,0,0);
        label2.position = ccp(240, 280);
     //   [self addChild:label2];
        
        CCLabelBMFont *label3 = [CCLabelTTF labelWithString:@"5.00" fontName:@"Bend2SquaresBRK" fontSize:30];
        label3.color = ccc3(0,0,0);
        label3.position = ccp(160, 160);
       // [self addChild:label3];
        
        
        /*CCMenuItemFont *goBackToHome = [CCMenuItemFont itemFromString: @"Back to Menu" target:self selector:@selector(goHome)];
        [goBackToHome setFontName:@"Bend2SquaresBRK"];
        [goBackToHome setFontSize:25];
        goBackToHome.color = ccc3(0, 0, 0);
        
        CCMenu *goHomeMenu = [CCMenu menuWithItems:goBackToHome, nil];
        [goHomeMenu alignItemsVertically];
        goHomeMenu.position = ccp(screenSize.width/2, 40);
        [self addChild:goHomeMenu];*/
        
        
        CCLabelTTF *highscore = [CCMenuItemImage itemFromNormalImage:@"smallcoins.png" selectedImage:@"smallcoins.png" target:self selector:@selector(buyCash1)];
        highscore.position = ccp(160, 300);
        CCMenu *starMenu = [CCMenu menuWithItems:highscore, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
        
        CCLabelTTF *boss = [CCMenuItemImage itemFromNormalImage:@"medcoins.png" selectedImage:@"medcoins.png" target:self selector:@selector(buyCash2)];
        boss.position = ccp(160, 220);
        CCMenu *moreMenu = [CCMenu menuWithItems:boss, nil];
        moreMenu.position = CGPointZero;
        [self addChild:moreMenu];
        
        CCLabelTTF *back = [CCMenuItemImage itemFromNormalImage:@"bigconins.png" selectedImage:@"bigconins.png" target:self selector:@selector(buyCash3)];
        back.position = ccp(160, 140);
        //back.scale = 0.5;
        CCMenu *backmenu = [CCMenu menuWithItems:back, nil];
        backmenu.position = CGPointZero;
        [self addChild:backmenu];
        
        CCLabelTTF *back2 = [CCMenuItemImage itemFromNormalImage:@"leave.png" selectedImage:@"leave.png" target:self selector:@selector(goHome)];
        back2.position = ccp(160, 70);
        back2.scale = 0.8;
        CCMenu *backmenu2 = [CCMenu menuWithItems:back2, nil];
        backmenu2.position = CGPointZero;
       // [self addChild:backmenu2];
        
        [self scheduleUpdate];
        
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"iphone5"])
        {
            background.position = ccp(160,328);
            highscore.position = ccp(160,388);
            boss.position = ccp(160,308);
            back.position = ccp(160,228);
            back2.position = ccp(160,158);
            
            CCSprite* bluebg = [CCSprite spriteWithFile:@"nightfill.png"];
            bluebg.position = [CCDirector sharedDirector].screenCenter;
            [self addChild:bluebg z:-10 ];
        }
        
    }
    return self;
}

-(void) buyCash1
{
    [MGWU buyProduct:@"com.mgwu.blue.15" withCallback:@selector(boughtProduct:) onTarget:self];
}

-(void) buyCash2
{
    [MGWU buyProduct:@"com.mgwu.blue.50" withCallback:@selector(boughtProduct:) onTarget:self];
}

-(void) buyCash3
{
    [MGWU buyProduct:@"com.mgwu.blue.300" withCallback:@selector(boughtProduct:) onTarget:self];
}


-(void) boughtProduct:(NSString*) powerupToBuy
{
    NSLog(@"Something was Bought!");
    [MGWU showMessage:@"Purchase Successful" withImage:nil];
    if ([powerupToBuy isEqualToString:@"com.mgwu.blue.15"] == true)
    {
        NSLog(@"1000 Coins added!");
        coins += 15;
        //NSNumber *boughtCoinVal = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:@"coins"];
    }
    
    if ([powerupToBuy isEqualToString:@"com.mgwu.blue.50"] == true)
    {
        NSLog(@"3000 Coins added!");
        coins += 50;
        //NSNumber *boughtCoinVal = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:@"coins"];
        
    }
    
    if ([powerupToBuy isEqualToString:@"com.mgwu.blue.300"] == true)
    {
        NSLog(@"10000 Coins added!");
        coins += 300;
        //NSNumber *boughtCoinVal = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:@"coins"];
    }
    
    [self updateCoinsLabel];
}

- (void)updateCoinsLabel {
    int CoinNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"coins"];
    //        NSNumber *endingHighScoreNumber = [MGWU objectForKey:@"sharedHighScore"];
    coins = CoinNumber;
    CoinString = [[NSString alloc] initWithFormat:@"Coins: %i", coins];
    coinsLabel.string = CoinString;
}


-(void) goHome
{
    //glClearColor(0, 0, 0, 255);
    [[CCDirector sharedDirector] popScene];
}


-(void) update:(ccTime)delta
{
    
    if ([KKInput sharedInput].anyTouchBeganThisFrame)
    {
        KKInput* input = [KKInput sharedInput];
        CGPoint pos = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
        
        NSLog(@"%f  %f",pos.x,pos.y);
        
        
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"iphone5"] == true)
        {
            
            if(pos.y < 568 && pos.y > 518 && pos.x < 40)
            {
                [self goHome];
            }
        }
        else
        {
            if(pos.y < 480 && pos.y > 430 && pos.x < 40)
            {
                [self goHome];
            }
        }
    }
}

@end
