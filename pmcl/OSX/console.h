
/*
 *  console.h
 *
 * This is actually a weird mix of Symantec's console package and Metrowerks' SIOUX
 * code.
 *
 */

/*
  07/26/96  gb   changed everything.
  ----- 3.9
*/

#ifndef __CONSOLE_H
#define __CONSOLE_H


/*
 *  Structure for holding the console specific settings ...
 *  default values are:
 *      {TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, 4, 80, 24, 0, 0, monaco, 9, normal};
 */

typedef struct tconsoleSettings {
  char 
    initializeTB,           /* Do we initialize the ToolBox ... */
    standalone,             /* Is console running in standalone mode ... */
    setupmenus,             /* Do we draw the console menus ... */
    autocloseonquit,        /* Do we close the console window on program termination ... */
    asktosaveonclose,       /* Do we offer to save on a close ... */
    showstatusline;         /* Do we draw the status line ... */
  
    short
      tabspaces,              /* if non-zero, replace tabs with 'tabspaces' spaces ... */
      columns, rows,          /* The initial size of the console window ... */
      toppixel, leftpixel,    /* The topleft window position (in pixels) ... */
      /*  (0,0 centers on main screen) ... */
      fontid, fontsize,
      fontface;               /* console's font, size and textface (i.e. bold, etc...) ... */
} tconsoleSettings;

extern tconsoleSettings   consoleSettings;      /* console's settings structure ... */
extern short consoleHandleOneEvent(struct EventRecord *userevent);

#include <Controls.h>
#include <TextEdit.h>
#include <Types.h>
#include <Windows.h>

typedef enum tconsoleState {
    OFF = 0,
    IDLE,
    PRINTFING,
    SCANFING,
    TERMINATED,
    ABORTED
} tconsoleState;
    
typedef struct tconsoleWin {
    WindowPtr       windowptr;                 /*  Pointer to Documents Window */
    TEHandle        edit;                   /*  TextEdit Handle */
    ControlHandle   vscroll;                /*  Vertical scrollbar */
    short           linesInFolder;          /*  Number of lines in the window */
    Boolean         dirty;                  /*  Is the document dirty (applies only to textWindow) */
    short           vrefnum;                /*  The window's file position on disk ... */
    long            dirid;
    Str63           fname;
} tconsoleWin, *pconsoleWin;

extern Boolean consoleIsAppWindow(WindowPtr window);
extern void consoleUpdateScrollbar(void);
extern void consoleDoContentClick(WindowPtr window, EventRecord *theEvent);
extern void consoleDrawGrowBox(WindowPtr theWindow);
extern void consoleUpdateWindow(WindowPtr theWindow);
extern void consoleUpdateStatusLine(WindowPtr theWindow);
extern void consoleMyGrowWindow(WindowPtr theWindow, Point thePoint);
extern Boolean consoleSetupTextWindow(void);
extern void consoleDoAboutBox(void);
extern void consoleCantSaveAlert(Str63 filename);
extern short consoleYesNoCancelAlert(Str63 filename);
extern Boolean consoleisinrange(short first, TEHandle te);

extern short        consoleselstart;          /*  The starting point for a read (can't read before this) ... */
extern Rect         consoleDragRect;          /*  The global drag rect ... */
extern Rect         consoleBigRect;           /*  The global clip rect ... */
extern Boolean      consoleQuitting;          /*  Are we quitting? ... */
extern Boolean      consoleUseWaitNextEvent;  /*  Can we use WaitNextEvent? ... */
extern tconsoleState  consoleState;             /*  Used to signal that we are trying to get a string ... */
extern pconsoleWin    consoleTextWindow;        /*  Pointer to the console text window structure ... */


/*  Local Defines */
#define console_BUFSIZ 512U                   /*  console's internal buffer size ... */
#define TICK_DELTA 30UL                     /*  Max ticks allowed between tests for UserBreak() */

/*  Local Globals */
static Boolean toolBoxDone = false;         /*  set to true when the TB is setup */
static unsigned long LastTick = 0UL;        /*  The tickcount of the last UserBreak test ... */
static short inputBuffersize = 0;           /*  Used by GetCharsFromconsole and DoOneEvent ... */
static CursHandle iBeamCursorH = NULL;      /*  Contains the iBeamCursor ... */
static Boolean atEOF = false;               /*  Is the stream at EOF? */

typedef struct tconsoleBuffer {
    char        *startpos,  /* pointer to a block of memory which will serve as the buffer */
                *curpos,    /* pointer to insertion point in the buffer */
                *endpos;    /* pointer to end of text in the buffer */
    long        tepos;      /* current offset in TEHandle (0 if at end) */
} tconsoleBuffer;
static tconsoleBuffer consoleBuffer;

#define ZEROconsoleBUFFER()       {                                                           \
                                    consoleBuffer.curpos =                                    \
                                        consoleBuffer.endpos =                                \
                                            consoleBuffer.startpos;                           \
                                    consoleBuffer.tepos = -1;                                 \
                                }
#define CURRENTBUFSIZE()        (consoleBuffer.endpos - consoleBuffer.startpos)
#define CHECKFOROVERFLOW(c)     {                                                           \
                                    if (CURRENTBUFSIZE() + (c) >= console_BUFSIZ)             \
                                        InsertconsoleBuffer();                                \
                                }
#define DELETEFROMBUFFER(num)   {                                                           \
                                    if (consoleBuffer.curpos != consoleBuffer.endpos)           \
                                        BlockMoveData(consoleBuffer.curpos,                   \
                                                consoleBuffer.curpos - (num),                 \
                                                consoleBuffer.endpos - consoleBuffer.curpos);   \
                                    consoleBuffer.endpos -= (num);                            \
                                    consoleBuffer.curpos -= (num);                            \
                                }
#define ROLLBACKBUFFER(num)     { consoleBuffer.curpos = consoleBuffer.endpos - (num); }
#define INSERTCHAR(c)           {                                                           \
                                    if (consoleBuffer.tepos == -1) {                          \
                                        *consoleBuffer.curpos = (c);                          \
                                        if (consoleBuffer.curpos == consoleBuffer.endpos)       \
                                            consoleBuffer.endpos++;                           \
                                        consoleBuffer.curpos++;                               \
                                    } else {                                                \
                                        TEHandle theTEH = consoleTextWindow->edit;            \
                                        TESetSelect(consoleBuffer.tepos,                      \
                                                    consoleBuffer.tepos + 1,                  \
                                                    theTEH);                                \
                                        TEKey(c, theTEH);                                   \
                                        consoleBuffer.tepos++;                                \
                                        if (consoleBuffer.tepos == (*theTEH)->teLength - 1)   \
                                            consoleBuffer.tepos = -1;                         \
                                    }                                                       \
                                }
#define INSERTLINEFEED()        {                                                           \
                                    *consoleBuffer.endpos = 0x0d;                             \
                                    consoleBuffer.endpos++;                                   \
                                    consoleBuffer.curpos = consoleBuffer.endpos;                \
                                    consoleBuffer.tepos = -1;                                 \
                                }

#include "mpwIO.h"

int32 console_faccess(char * name, unsigned int cmd, long *arg);
int32 console_close(MPWIOEntry * entry);
int32 console_read(MPWIOEntry * entry);
int32 console_write(MPWIOEntry * entry);
int32 console_ioctl(MPWIOEntry * entry, unsigned int cmd, long *arg);

enum {
	APPLEID 		= 32000,
	APPLEABOUT 		= 1
};

enum {
	FILEID			= 32001,
	FILESAVE 		= 4,
	FILEPAGESETUP	= 6,
	FILEPRINT		= 7,
	FILEQUIT		= 9
};

enum {
	EDITID			= 32002,
	EDITCUT			= 3,
	EDITCOPY		= 4,
	EDITPASTE		= 5,
	EDITCLEAR		= 6,
	EDITSELECTALL	= 8
};

extern void		consoleSetupMenus(void);
extern void		consoleUpdateMenuItems(void);
extern short            consoleDoSaveText(void);
extern void		consoleDoEditCut(void);
extern void		consoleDoEditCopy(void);
extern void		consoleDoEditPaste(void);
extern void		consoleDoEditClear(void);
extern void		consoleDoEditSelectAll(void);

extern void		consoleDoMenuChoice(long menuValue);

#endif
