//
//  Dead.m
//  bullet hell-o
//
//  Created by Kevin Frans on 7/2/13.
//
//

#import "Dead.h"
#import "HelloWorldLayer.h"
#import "Title.h"
#import "LevelSelect.h"
#import "StatLayer.h"

@implementation Dead

-(id) init
{
    if ((self = [super init]))
    {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iphone5"]) //iphone 5
        {
            size = [[CCDirector sharedDirector] winSize];
            glClearColor(255, 255, 255, 255);
            [self unscheduleAllSelectors];
            
            // have everything stop
            CCNode* node;
            CCARRAY_FOREACH([self children], node)
            {
                [node pauseSchedulerAndActions];
            }
            
            CGPoint screencenter = [[CCDirector sharedDirector] screenCenter];
            
            CCSprite* background = [CCSprite spriteWithFile:@"gameoverbg5.png"];
            background.position = ccp(screencenter.x,screencenter.y);
            [self addChild:background z:-10000];
            
            CCSprite* bg = [CCSprite spriteWithFile:@"darkbluefill.png"];
            bg.position = [CCDirector sharedDirector].screenCenter;
            [self addChild:bg z:-1000000];
            bg.scale = 2;
            
            // add the labels shown during game over
            CGSize screenSize = [[CCDirector sharedDirector] winSize];
            
            CGSize screenSize1 = [[CCDirector sharedDirector] winSizeInPixels];
            
            score = [NSString stringWithFormat:@"%i", [[NSUserDefaults standardUserDefaults] integerForKey:@"score"]];
            
            
            intscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
            
            if([[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"] < [[NSUserDefaults standardUserDefaults] integerForKey:@"score"])
            {
                [[NSUserDefaults standardUserDefaults] setInteger:intscore forKey:@"highscore"];
            }
            
            NSNumber* scorenum = [NSNumber numberWithInt:[[NSUserDefaults standardUserDefaults] integerForKey:@"score"]];
            NSNumber* levelnumber = [NSNumber numberWithInt:1];
            NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: score, @"score", levelnumber, @"level_number", nil];
            [MGWU logEvent:@"blue_gameover" withParams:params];
            
            CCLabelTTF* currentscorelabel = [CCLabelTTF labelWithString:@"Score:" fontName:@"Avenir" fontSize:20];
            currentscorelabel.position = ccp(160,465);
            currentscorelabel.color = ccc3(255,255,255);
            [self addChild:currentscorelabel z: 100];
            
            
            
            CCLabelTTF* gameOver2 = [CCLabelTTF labelWithString:score fontName:@"AvenirNext-Heavy" fontSize:52];

            gameOver2.position = ccp(160, 418);
            gameOver2.color = ccc3(255, 255, 255);
            [self addChild:gameOver2 z:100 tag:100];
            
            
            CCLabelTTF* currentscorelabel2 = [CCLabelTTF labelWithString:@"High Score:" fontName:@"Avenir" fontSize:20];
            currentscorelabel2.position = ccp(160,380);
            currentscorelabel2.color = ccc3(255,255,255);
            [self addChild:currentscorelabel2 z: 100];
            
            CCLabelTTF* highscore3 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",[[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"]] fontName:@"AvenirNext-Heavy" fontSize:52];
            
            highscore3.position = ccp(160, 330);
            highscore3.color = ccc3(255, 255, 255);
            [self addChild:highscore3 z:100 tag:100];
            
            //CCTintTo* tint = [CCTintTo actionWithDuration:2 red:0 green:0 blue:255];

            CCLabelTTF *highscore = [CCMenuItemImage itemFromNormalImage:@"button-restart.png" selectedImage:@"button-restart.png" target:self selector:@selector(retry)];
            highscore.position = ccp(160, 124);
            highscore.scale = 1;
            CCMenu *starMenu = [CCMenu menuWithItems:highscore, nil];
            starMenu.position = CGPointZero;
            [self addChild:starMenu];
            
            
            CCLabelTTF *morethings = [CCMenuItemImage itemFromNormalImage:@"button-high-scores.png" selectedImage:@"button-high-scores.png" target:self selector:@selector(sel)];
            morethings.position = ccp(160, 204);
            morethings.scale = 1;
            CCMenu *morethingsm = [CCMenu menuWithItems:morethings, nil];
            morethingsm.position = CGPointZero;
            [self addChild:morethingsm];
            
            
            
            //xyhw
            nameField = [[UITextField alloc] initWithFrame:CGRectMake(50, 272, 230, 35)];
            [[[CCDirector sharedDirector] view] addSubview:nameField];
            nameField.delegate = self;
            nameField.placeholder = @"Tap to Enter Username";
            nameField.borderStyle = UITextBorderStyleRoundedRect;
            [nameField setReturnKeyType:UIReturnKeyDone];
            [nameField setAutocorrectionType:UITextAutocorrectionTypeNo];
            [nameField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
            //        textField.visible = true;
            
            
            
            // NSLog(@"I HATE YOU FACEBOOK");
            CCLabelTTF *fb = [CCMenuItemImage itemFromNormalImage:@"facebook.png" selectedImage:@"facebook.png" target:self selector:@selector(fb)];
            fb.position = ccp(size.width - 16, size.height - 16);
            fb.scale = 1.5;
            fb.position = ccp(size.width - 24, size.height - 20);
            fb.size = CGSizeMake(200, 200);
            CCMenu *fbm = [CCMenu menuWithItems:fb, nil];
            fbm.position = CGPointZero;
            [self addChild:fbm];
            
            
            
            
            
            
            
            
            [self scheduleUpdate];
        }
        else
        {
        
            size = [[CCDirector sharedDirector] winSize];
            glClearColor(255, 255, 255, 255);
            [self unscheduleAllSelectors];
            
            // have everything stop
            CCNode* node;
            CCARRAY_FOREACH([self children], node)
            {
                [node pauseSchedulerAndActions];
            }
            
            CGPoint screencenter = [[CCDirector sharedDirector] screenCenter];
            
            CCSprite* background = [CCSprite spriteWithFile:@"gameoverbg5.png"];
            background.position = ccp(screencenter.x,screencenter.y - 44);
            [self addChild:background z:-10000];
            
            CCSprite* bg = [CCSprite spriteWithFile:@"darkbluefill.png"];
            bg.position = [CCDirector sharedDirector].screenCenter;
            [self addChild:bg z:-1000000];
            bg.scale = 2;
            
            // add the labels shown during game over
            CGSize screenSize = [[CCDirector sharedDirector] winSize];
            
            CGSize screenSize1 = [[CCDirector sharedDirector] winSizeInPixels];
            
            score = [NSString stringWithFormat:@"%i", [[NSUserDefaults standardUserDefaults] integerForKey:@"score"]];
            
            
            intscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
            
            if([[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"] < [[NSUserDefaults standardUserDefaults] integerForKey:@"score"])
            {
                [[NSUserDefaults standardUserDefaults] setInteger:intscore forKey:@"highscore"];
            }
            
            NSNumber* scorenum = [NSNumber numberWithInt:[[NSUserDefaults standardUserDefaults] integerForKey:@"score"]];
            NSNumber* levelnumber = [NSNumber numberWithInt:1];
            NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: score, @"score", levelnumber, @"level_number", nil];
            [MGWU logEvent:@"blue_gameover" withParams:params];
            
            CCLabelTTF* currentscorelabel = [CCLabelTTF labelWithString:@"Score:" fontName:@"Avenir" fontSize:20];
            currentscorelabel.position = ccp(160,415);
            currentscorelabel.color = ccc3(255,255,255);
            [self addChild:currentscorelabel z: 100];
            
            CCLabelTTF* gameOver2 = [CCLabelTTF labelWithString:score fontName:@"AvenirNext-Heavy" fontSize:52];
            
            gameOver2.position = ccp(160, 378);
            gameOver2.color = ccc3(255, 255, 255);
            [self addChild:gameOver2 z:100 tag:100];
            
            
            CCLabelTTF* currentscorelabel2 = [CCLabelTTF labelWithString:@"High Score:" fontName:@"Avenir" fontSize:20];
            currentscorelabel2.position = ccp(160,340);
            currentscorelabel2.color = ccc3(255,255,255);
            [self addChild:currentscorelabel2 z: 100];
            
            CCLabelTTF* highscore3 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",[[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"]] fontName:@"AvenirNext-Heavy" fontSize:52];
            
            highscore3.position = ccp(160, 295);
            highscore3.color = ccc3(255, 255, 255);
            [self addChild:highscore3 z:100 tag:100];
            
            //CCTintTo* tint = [CCTintTo actionWithDuration:2 red:0 green:0 blue:255];
            
            CCLabelTTF *highscore = [CCMenuItemImage itemFromNormalImage:@"button-restart.png" selectedImage:@"button-restart.png" target:self selector:@selector(retry)];
            highscore.position = ccp(160, 84);
            highscore.scale = 1;
            CCMenu *starMenu = [CCMenu menuWithItems:highscore, nil];
            starMenu.position = CGPointZero;
            [self addChild:starMenu];
            
            
            CCLabelTTF *morethings = [CCMenuItemImage itemFromNormalImage:@"button-high-scores.png" selectedImage:@"button-high-scores.png" target:self selector:@selector(sel)];
            morethings.position = ccp(160, 169);
            morethings.scale = 1;
            CCMenu *morethingsm = [CCMenu menuWithItems:morethings, nil];
            morethingsm.position = CGPointZero;
            [self addChild:morethingsm];
        
        
        //xywh
            
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(50, 220, 230, 35)];
        [[[CCDirector sharedDirector] view] addSubview:nameField];
        nameField.delegate = self;
        nameField.placeholder = @"Tap to Enter Username";
        nameField.borderStyle = UITextBorderStyleRoundedRect;
        [nameField setReturnKeyType:UIReturnKeyDone];
        [nameField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [nameField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
        //        textField.visible = true;
        
        
        
           // NSLog(@"derp");
        CCLabelTTF *fb = [CCMenuItemImage itemFromNormalImage:@"facebook.png" selectedImage:@"facebook.png" target:self selector:@selector(fb)];
        fb.scale = 1.5;
        fb.position = ccp(size.width - 24, size.height - 20);
        CCMenu *fbm = [CCMenu menuWithItems:fb, nil];
        fbm.position = CGPointZero;
        [self addChild:fbm];
        
        
        
        
        
        
        
        
        [self scheduleUpdate];
        
       // [MGWU submitHighScore:[[NSUserDefaults standardUserDefaults] integerForKey:@"score"] byPlayer:@"Player" forLeaderboard:@"defaultLeaderboard"];
        }
    }
    return self;
}



-(void) update:(ccTime)delta
{
    
    if ([KKInput sharedInput].anyTouchBeganThisFrame)
    {
        KKInput* input = [KKInput sharedInput];
        CGPoint pos = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
        

        
        
        
        
        if(pos.y < 480 && pos.y > 430 && pos.x < 40)
        {
            [self quitGame];
        }
        
        if(pos.y > 0 && pos.y < 50 && pos.x < 40)
        {
            [self sel];
        }
    }
    
    else if([[NSUserDefaults standardUserDefaults] boolForKey:@"iphone5"])
    {
        KKInput* input = [KKInput sharedInput];
        CGPoint pos = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
        
        
        
        
        
        
        if(pos.y < 568 && pos.y > 518 && pos.x < 40)
        {
            [self quitGame];
        }
        
//        if(pos.y > 0 && pos.y < 50 && pos.x < 40)
//        {
//            [self sel];
//        }
    }
}

-(void) fblogin
{
    [MGWU loginToFacebook];
}
-(void) fb
{
    if([MGWU isFacebookActive])
    {
    NSString *myString = @"I just finished a run of Blue and got a score of ";
    NSString *test = [myString stringByAppendingString:score];
    [MGWU shareWithTitle:@"Blue" caption:[MGWU getUsername] andDescription:test];
    }
else{
    [self fblogin];
}
}

-(void) quitGame
{
    [nameField removeFromSuperview];
//    [nameField release];
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInL transitionWithDuration:0.5f scene:[Title node]]];
}

-(void) sel
{
    [nameField removeFromSuperview];
//    [nameField release];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.5f scene:[StatLayer node]]];
}

-(void) retry
{
    [nameField removeFromSuperview];
//    [nameField release];
    //    [[CCDirector sharedDirector] popSceneWithTransition:
    //       [CCTransitionCrossFade transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
}

- (void)textFieldDidEndEditing:(UITextField*)textField
{
    if (textField == nameField && ![nameField.text isEqualToString:@""])
    {
       
        //if([[NSUserDefaults standardUserDefaults] integerForKey:@"score"] > 0)
       // {
        
        [nameField endEditing:YES];
        [nameField removeFromSuperview];
        // here is where you should do something with the data they entered
        NSString *result = nameField.text;
        
        
        if(intscore > 0)
        {
        NSLog(@"hurp");
        //        username = result;
        [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"username"];
        [MGWU submitHighScore:[[NSUserDefaults standardUserDefaults] integerForKey:@"score"] byPlayer:result forLeaderboard:@"defaultLeaderboard"];
        //}
        }
        
        
    }
}
-(void) setDimensionsInPixelsOnSprite:(CCSprite *) spriteToSetDimensions width:(int) width height:(int) height
{
    spriteToSetDimensions.scaleX = width/[spriteToSetDimensions boundingBox].size.width;
    spriteToSetDimensions.scaleY = height/[spriteToSetDimensions boundingBox].size.height;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
	if (![nameField.text isEqualToString:@""])
	{
		//Hide keyboard when "done" clicked
		[textField resignFirstResponder];
		[nameField removeFromSuperview];
		return YES;
	}
    else
    {
        [textField resignFirstResponder];
        return YES;
    }
}

@end

