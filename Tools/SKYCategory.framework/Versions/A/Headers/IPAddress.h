//
//  IPAddress.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#ifndef SuningEBuy_IPAddress_h
#define SuningEBuy_IPAddress_h


#define MAXADDRS     32

extern char *if_names[MAXADDRS];

extern char *ip_names[MAXADDRS];

extern char *hw_addrs[MAXADDRS];

extern unsigned long ip_addrs[MAXADDRS];


void InitAddresses(void);

void FreeAddresses(void);

void GetIPAddresses(void);

void GetHWAddresses(void);


#endif
