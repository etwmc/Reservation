//
//  Multithread.h
//  Reservation
//
//  Created by Wai Man Chan on 4/4/16.
//  Copyright © 2016 CHAN, Wai Man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Multithread : NSObject
+(dispatch_queue_t)onlineQueryThread;
@end
