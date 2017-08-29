//
//  IPAddres.m
//  VideoOpener
//
//  Created by Stas Chmilenko on 02.07.17.
//  Copyright © 2017 Stas Chmilenko. All rights reserved.
//

#import "IPAddres.h"
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>

@implementation IPAddres
+ (NSArray<NSString *> *)localIPAddress
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                if (![array containsObject:localIP]) {
                    [array addObject:localIP];
                    
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return [array copy];
}
@end
