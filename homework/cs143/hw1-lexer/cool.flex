/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */
int comment_level = 0; //holds the level of nested comments we are in.  if we are in no comment, it is 0
%}

/*
 * Define names for regular expressions here.
 */

DARROW          =>
INTEGER         [0-9]+
KEYWORD         class|else|fi|if|in|inherits|isvoid|let|loop|pool|then|while|case|esac|new|of|not|false|true
IDENTIFIER      3
WS              [\n\f\r\t\v\32]+
DOUBLE_DASH     --
COMMENT_START   "(*"
COMMENT_CONTENT .*/"*)"
COMMENT_END     "*)"
%%

 /*
  *  Nested comments
  */


 /*
  *  The multiple-character operators.
  */
{DARROW}	      { return (DARROW); }
{INTEGER}             { return (DARROW); }
{KEYWORD}             { return (DARROW); }
.*/"*)" { return (DARROW); }
{COMMENT_CONTENT}     { return (DARROW);}

 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */


 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */


%%