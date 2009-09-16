/*
  $Log: lisp-debug.h,v $
  Revision 1.5  2003/12/08 05:12:01  gtbyers
  New flags & masks.

  Revision 1.4  2003/12/01 17:56:08  gtbyers
  recover pre-MOP changes

  Revision 1.2  2003/11/12 19:01:05  gtbyers
  Fix typo; remove extra log template.

  Revision 1.1  2003/11/12 18:56:10  gtbyers
  New file.

*/

typedef enum {
  debug_continue,		/* stay in the repl */
  debug_exit_success,		/* return 0 from lisp_Debugger */
  debug_exit_fail,		/* return non-zero from lisp_Debugger */
  debug_kill
} debug_command_return;

typedef debug_command_return (*debug_command) (ExceptionInformationPowerPC *, int);

#define DEBUG_COMMAND_FLAG_REQUIRE_XP 1 /* function  */
#define DEBUG_COMMAND_FLAG_AUX_REGNO  (2 | DEBUG_COMMAND_FLAG_REQUIRE_XP)
#define DEBUG_COMMAND_FLAG_AUX_SPR (4 | DEBUG_COMMAND_FLAG_REQUIRE_XP)
#define DEBUG_COMMAND_REG_FLAGS 7
#define DEBUG_COMMAND_FLAG_EXCEPTION_ENTRY_ONLY 8

typedef struct {
  debug_command f;
  char *help_text;
  unsigned flags;
  char *aux_prompt;
  int c;
} debug_command_entry;

debug_command_entry debug_command_entries[];

char *
print_lisp_object(LispObj);
