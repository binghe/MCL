(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:routing_tables.h"
; at Sunday July 2,2006 7:31:27 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; 
;  *    This include file defines the RTMP table and ZIP table
;  *    for the AppleTalk AIX router
;  *
;  *
;  *  0.01	03/16/94	LD	Creation
;  *  0.10	08/19/94	LD	merged	
;  *
;  
; #ifndef _NETAT_ROUTING_TABLES_H_
; #define _NETAT_ROUTING_TABLES_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_PRIVATE
#| #|



#define RTE_STATE_UNUSED	0		
#define RTE_STATE_BAD		2		
#define RTE_STATE_SUSPECT	4		
#define RTE_STATE_GOOD		8		
#define RTE_STATE_ZKNOWN	16		
#define RTE_STATE_UPDATED	32		
#define RTE_STATE_BKUP		64	
#define RTE_STATE_PERMANENT	128	

#define PORT_ONLINE    		32	
#define PORT_SEEDING		31	
#define PORT_ACTIVATING 	16	
#define PORT_ERR_NOZONE		6	
#define PORT_ERR_BADRTMP	5	
#define PORT_ERR_STARTUP	4	
#define PORT_ERR_CABLER		3	
#define PORT_ERR_SEED		2	
#define PORT_ONERROR		1	
#define PORT_OFFLINE 		0	

#define ZT_MAX			1024	
#define ZT_MIN			32	
#define ZT_DEFAULT		512	
#define RT_MAX			4096	
#define RT_MIN			128	
#define RT_DEFAULT		1024	
#define ZT_BYTES		(ZT_MAX8)	
#define ZT_MAXEDOUT		ZT_MAX+1	
#define RT_MIX_DEFAULT		2000	


#define NOTIFY_N_DIST   31      



#define TUPLENET(x) NET_VALUE(((at_rtmp_tuple *)(x))->at_rtmp_net)
#define TUPLEDIST(x)  ((((at_rtmp_tuple *)(x))->at_rtmp_data) & RTMP_DISTANCE)
#define TUPLERANGE(x) ((((at_rtmp_tuple *)(x))->at_rtmp_data) & RTMP_RANGE_FLAG)

#define CableStart  ifID->ifThisCableStart
#define CableStop  ifID->ifThisCableEnd

#define RTMP_IDLENGTH	4	


#define RTMP_VERSION_NUMBER 0x82    	

#define ERTR_SEED_CONFLICT  0x101   
#define ERTR_CABLE_CONFLICT 0x102   

#define ERTR_RTMP_BAD_VERSION  0x103   

#define ERTR_CABLE_STARTUP  0x104   

#define ERTR_CABLE_NOZONE	0x105	




typedef struct rt_entry {

	struct rt_entry *left;		
	struct rt_entry *right;		

	at_net_al NetStop;		
	at_net_al NetStart;		
	at_net_al NextIRNet;		
	at_node NextIRNode;		
	u_char ZoneBitMap[ZT_BYTES];	
	u_char NetDist;			
	u_char NetPort;			
	u_char EntryState;		
	u_char RTMPFlag;
	u_char AURPFlag;

} RT_entry;

	


typedef struct {

	u_short ZoneCount;		
	at_nvestr_t Zone;		

} ZT_entry;


typedef struct {
	unsigned short 	entryno;	
	ZT_entry	zt;		
} ZT_entryno;

#ifdefKERNEL



#define RT_DELETE(NetStop, NetStart) {\
    RT_entry *found; \
    if ((found = rt_bdelete(NetStop, NetStart))) { \
        memset(found, '\0', sizeof(RT_entry)); \
        found->right = RT_table_freelist; \
        RT_table_freelist  = found; \
    } \
}



#define RT_ALL_ZONES_KNOWN(entry)  	((entry)->EntryState & RTE_STATE_ZKNOWN)
#define RT_SET_ZONE_KNOWN(entry)  	((entry)->EntryState |= RTE_STATE_ZKNOWN)
#define RT_CLR_ZONE_KNOWN(entry)  	((entry)->EntryState ^= RTE_STATE_ZKNOWN)


#define ZT_ISIN_ZMAP(znum, zmap) ((zmap)[(znum-1) >> 3] & 0x80 >> (znum-1) % 8)



#define ZT_CLR_ZMAP(num, zmap) {					\
	if ((zmap)[(num-1) >> 3] & 0x80 >> (num-1) % 8) {	\
		(zmap)[(num-1) >> 3] ^= 0x80 >> (num-1) % 8;	\
		ZT_table[(num-1)].ZoneCount-- ;				\
	}												\
}



#define ZT_SET_ZMAP(num, zmap) {						\
	if (!zmap[(num-1) >> 3] & 0x80 >> (num-1) % 8) {	\
		zmap[(num-1) >> 3] |= 0x80 >> (num-1) % 8;		\
		ZT_table[(num-1)].ZoneCount++ ;					\
	}													\
}

extern int regDefaultZone(at_ifaddr_t *);
extern int zonename_equal(at_nvestr_t *, at_nvestr_t *);
	  
extern RT_entry *RT_table_freelist;
extern RT_entry RT_table_start;
extern RT_entry *RT_table;
extern RT_entry *rt_binsert();
extern RT_entry *rt_insert();
extern RT_entry *rt_bdelete();
extern RT_entry *rt_blookup(int);
extern RT_entry *rt_getNextRoute(int);

extern ZT_entry *ZT_table;
extern short	RT_maxentry;
extern short	ZT_maxentry;

extern volatile int RouterMix;

extern int zt_add_zone(char *, short);
extern int zt_add_zonename(at_nvestr_t *);
extern int zt_ent_zindex(u_char *);
extern ZT_entryno *zt_getNextZone(int); 
extern void zt_remove_zones(u_char *);
extern void zt_set_zmap(u_short, char *);
extern void rtmp_router_input();

#endif

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif /* _NETAT_ROUTING_TABLES_H_ */


(provide-interface "routing_tables")