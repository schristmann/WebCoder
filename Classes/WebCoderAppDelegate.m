//
//  WebCoderAppDelegate.m
//  WebCoder
//
//  Created by Sean Christmann on 10/17/10.
//

#import "WebCoderAppDelegate.h"

#import "CJSONDeserializer.h"
#import "TouchXML.h"

#import "JSONUnarchiver.h"
#import "XMLUnarchiver.h"
#import "AccountOverview.h"

@implementation WebCoderAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
    [window makeKeyAndVisible];
	
	NSError *error = NULL;
	
	//load sample json data and deserialize to AccountOverview object
	NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"json" ofType:@"txt"];
	NSString *jsonStr = [NSString stringWithContentsOfFile:jsonPath encoding:NSASCIIStringEncoding error:NULL];
	NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF32BigEndianStringEncoding];
	
	NSDictionary *jsonDic = [[CJSONDeserializer deserializer] deserialize:jsonData error:NULL];
	JSONUnarchiver *j_unarch = [JSONUnarchiver unarchiverWithDictionary:jsonDic];
	AccountOverview *overview1 = [[AccountOverview alloc] initWithCoder:j_unarch];
	
	NSLog(@"%@", overview1);
	
	
	
	//load sample xml data and deserialize to same AccountOverview object
	NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"xml" ofType:@"txt"];
	NSString *xmlStr = [NSString stringWithContentsOfFile:xmlPath encoding:NSASCIIStringEncoding error:NULL];
	
	CXMLDocument *xmlDoc = [[[CXMLDocument alloc] initWithXMLString:xmlStr options:0 error:&error] autorelease];
	XMLUnarchiver *x_unarch = [XMLUnarchiver unarchiverWithNode:[xmlDoc rootElement]];
	AccountOverview *overview2 = [[AccountOverview alloc] initWithCoder:x_unarch];
	
	NSLog(@"%@", overview2);
	
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
