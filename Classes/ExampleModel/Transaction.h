//
//  Transaction.h
//  WebCoder
//
//  Created by Sean Christmann on 10/11/10.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject<NSCoding> {
	double _amount;
	NSDate *_date;
}
@property(nonatomic, assign) double amount;
@property(nonatomic, retain) NSDate *date;

@end
