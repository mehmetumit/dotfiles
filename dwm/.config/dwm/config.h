#include <X11/XF86keysym.h>
#include "movestack.c"
/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 10;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
//static const char *fonts[]          = { "Font Awesome 5 Free:style=Solid:size=12:autohint=true","Source Code Pro:size=12:antialias=true:autohint=true"};
//static const char *fonts[]          = { "SauceCodePro Nerd Font:size=12:antialias=true:autohint=true"};
static const char *fonts[]          = { "SauceCodePro Nerd Font:size=12:antialias=true:autohint=true", "NotoColorEmoji:pixelsize=16:antialias=true:autohint=true"  };
static const char dmenufont[]       = "SauceCodePro Nerd Font:size=12:antialias=true:autohint=true";
//static const char dmenufont[]       = "Source Code Pro:size=12:style=Regular:antialias=true:autohint=true";
//background color
//static const char col_gray1[]       = "#1F3B6A";
static const char col_gray1[]       = "#2F3136";
//inactive windows border color
static const char col_gray2[]       = "#444444";
//font color
static const char col_gray3[]       = "#ffffff";
//current tag and current window font color
static const char col_gray4[]       = "#000000";
//Top bar second color (blue) and active window border color
//static const char col_cyan[]        ="#509DBC";
static const char col_cyan[]        = "#88B6B2";
//static const char border_col[] 	= "#ff8000";
static const char border_col[] 	="#509DBC";
//static const char border_col[] 		= "#378BD3";
//static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  border_col },
	[SchemeTitle]  = { col_gray1, col_gray1,  col_cyan  },
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;
const char *spfmcmd[] = {"urxvt", "-name", "spfm", "-g",  "150x38",  "-e", "ranger", NULL};
const char *sptermcmd[] = {"urxvt", "-name", "spterm", "-g", "130x34", NULL};
const char *sprescmd[] = {"urxvt", "-name", "spres", "-g", "130x34", "-e", "btop", NULL};
static Sp scratchpads[] = {
	/* name          cmd  */
	{"spfm",      spfmcmd},
	{"spterm",    sptermcmd},
	{"spres",    sprescmd},
};

/* tagging */
//
static const char *tags[] = { "PRMRY","SCNDRY", "EXTR", "BCKG"};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       1 << 2,            1,           -1 },
	//Start opengl demo applications in floating window mode
	{ NULL,    	  NULL,       "DEMO",       0,            1,           -1 },
	//Start camera window in floating window mode
	{ NULL,    	  NULL,       "CAM",       0,            1,           -1 },
	{ "kdenlive",     NULL,	NULL,       1 << 2,            1,           -1 },
	//{ "firefox",  NULL,       NULL,       1,       0,           -1 },
	//{ "Thunar",	  NULL,		NULL,       1 << 2,       0,           -1 },
	{ "discord",	  NULL,		NULL,       1 << 2,       0,           -1 },
	{ "obs",	  NULL,		NULL,       1 << 2,       0,           -1 },
	{ NULL,		  "spfm",		NULL,		SPTAG(0),		1,			 -1 },
	{ NULL,		  "spterm",		NULL,		SPTAG(1),		1,			 -1 },
	{ NULL,		  "spres",	NULL,		SPTAG(2),		1,			 -1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define STATUSBAR "dwmblocks"
/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, NULL };
static const char app_menu[] = { "rofi -show drun"};
static const char window_menu[] = { "rofi -show window"};
static const char run_menu[] = { "rofi -show run"};
static const char calc_menu[] = { "rofi -show calc -no-show-match -no-sort"};
static const char emoji_menu[] = { "rofi -show emoji -matching normal"};
static const char *termcmd[]  = { "urxvt", NULL };

//***************Custom key actions ***************
//playerctl package needed
static const char volup[]   = { "/usr/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%; update-block 7;"};
static const char voldown[] = { "/usr/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%; update-block 7;"};
static const char volmute[] = { "/usr/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle; update-block 7;"};
static const char brup[] = {"xbacklight -inc 5; update-block 6;"};
static const char brdown[] = {"xbacklight -dec 5; update-block 6;"};
static const char medpause[] = {"playerctl play-pause"};
static const char mednext[] = {"playerctl next"};
static const char medprev[] = {"playerctl previous"};
static const char focshot[] = {"mkdir -p $HOME/Screenshots && scrot -u $HOME/Screenshots/%Y-%m-%d@%H-%M-%S.png" };
static const char fullsshot[] = {"mkdir -p $HOME/Screenshots && scrot $HOME/Screenshots/%Y-%m-%d@%H-%M-%S.png" };
static const char selsshot[] = {"mkdir -p $HOME/Screenshots && scrot -s $HOME/Screenshots/%Y-%m-%d@%H-%M-%S.png"};
static const char sharesshot[] = {"mkdir -p $HOME/Screenshots && scrot -s $HOME/Screenshots/%Y-%m-%d@%H-%M-%S.png -e 'xclip -selection clipboard -target image/png -i $f'"};
static const char bootmenu[] = {"bootmenu"};
static const char clipmenu[] = {"clipmenu"};
static const char qrgen[] = {"qrgen"};
static const char owebbrowser[] = {"$BROWSER"};
//static const char ofilebrowser[] = {"urxvt -e ranger"};
static const char osshots[] = {"cd ~/Screenshots/ && urxvt -e ranger"};
//autostart.sh script which exist in ~/.dwm/
static const char kill_all[] = {"killall startup-script; killall dwm; killall dwmblocks;"};
static const char color_picker[] = {"colpick -n -c "};
//*************************************************
//XK_Scroll_Lock -> Don't use Mod3Key use this
//XK_Pause
//XK_Print
//
static Key keys[] = {
	/* modifier                     key        function        argument */
	//{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,            		XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_space, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,             		XK_q,      killclient,     {0} },
	//{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_n,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY|ShiftMask,             XK_Return,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },

	{ MODKEY,                       XK_Down,   moveresize,     {.v = "0x 25y 0w 0h" } },
	{ MODKEY,                       XK_Up,     moveresize,     {.v = "0x -25y 0w 0h" } },
	{ MODKEY,                       XK_Right,  moveresize,     {.v = "25x 0y 0w 0h" } },
	{ MODKEY,                       XK_Left,   moveresize,     {.v = "-25x 0y 0w 0h" } },
	{ MODKEY|ShiftMask,             XK_Down,   moveresize,     {.v = "0x 0y 0w 25h" } },
	{ MODKEY|ShiftMask,             XK_Up,     moveresize,     {.v = "0x 0y 0w -25h" } },
	{ MODKEY|ShiftMask,             XK_Right,  moveresize,     {.v = "0x 0y 25w 0h" } },
	{ MODKEY|ShiftMask,             XK_Left,   moveresize,     {.v = "0x 0y -25w 0h" } },
	{ MODKEY|ControlMask,           XK_Up,     moveresizeedge, {.v = "t"} },
	{ MODKEY|ControlMask,           XK_Down,   moveresizeedge, {.v = "b"} },
	{ MODKEY|ControlMask,           XK_Left,   moveresizeedge, {.v = "l"} },
	{ MODKEY|ControlMask,           XK_Right,  moveresizeedge, {.v = "r"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Up,     moveresizeedge, {.v = "T"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Down,   moveresizeedge, {.v = "B"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Left,   moveresizeedge, {.v = "L"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Right,  moveresizeedge, {.v = "R"} },


	{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },


	{ MODKEY,            			XK_a,  	   togglescratch,  {.ui = 0 } },
	{ MODKEY,            			XK_u,	   togglescratch,  {.ui = 1 } },
	{ MODKEY,            			XK_y,	   togglescratch,  {.ui = 2 } },

	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_asterisk,  setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,            	XK_asterisk, setgaps,        {.i = 0  } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
//	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
//Used underscore for not conflict with other functions which can be exist in future
	{ MODKEY|ShiftMask,                       XK_s,      spawn,          SHCMD(osshots) },
	{ MODKEY|ShiftMask,             XK_q,      spawn,           SHCMD(kill_all) },
	{ MODKEY,             			XK_c,      spawn,           SHCMD(clipmenu) },
	{ MODKEY,             			XK_z,      spawn,           SHCMD(qrgen) },
	{ MODKEY|ShiftMask,             XK_x,      spawn,           SHCMD(color_picker) },
	//{ MODKEY,             			XK_a,      spawn,           SHCMD(ofilebrowser) },
	{ MODKEY|ShiftMask,            	XK_w,      spawn,           SHCMD(owebbrowser) },
	{ MODKEY,            			XK_e,      spawn,           SHCMD(emoji_menu) },
	{ MODKEY|ShiftMask,            	XK_c,      spawn,           SHCMD(calc_menu) },
	{ MODKEY,            			XK_p,      spawn,           SHCMD(app_menu) },
	{ MODKEY|ShiftMask,            	XK_p,      spawn,           SHCMD(run_menu) },
	{ MODKEY,            			XK_w,      spawn,           SHCMD(window_menu) },
	{ 0,                       XF86XK_AudioLowerVolume, spawn, SHCMD(voldown) },
	{ 0,                       XF86XK_AudioMute, spawn, SHCMD(volmute) },
	{ 0,                       XF86XK_AudioRaiseVolume, spawn, SHCMD(volup) },
	{ 0,                       XF86XK_MonBrightnessUp, spawn, SHCMD(brup) },
	{ 0,                       XF86XK_MonBrightnessDown, spawn, SHCMD(brdown) },
	{ 0,						XF86XK_AudioPlay, spawn, SHCMD(medpause) },
	{ 0,						XF86XK_AudioPause, spawn, SHCMD(medpause) },
	{ 0,						XF86XK_AudioPrev, spawn, SHCMD(medprev) },
	{ 0,						XF86XK_AudioNext, spawn, SHCMD(mednext) },
	{ShiftMask,					XK_Pause ,			spawn, 		SHCMD(brup) },
	{MODKEY|ALTKEY,				XK_Right , 			spawn, 		SHCMD(brup) },
	{ControlMask,				XK_Pause , 			spawn, 		SHCMD(brdown) },
	{MODKEY|ALTKEY,				XK_Left,			spawn, 		SHCMD(brdown) },
	{MODKEY|ALTKEY,				XK_Up, 				spawn, 		SHCMD(volup) },
	{MODKEY|ALTKEY,				XK_Down, 			spawn, 		SHCMD(voldown) },
	{0,							XK_Scroll_Lock, 	spawn, 		SHCMD(medpause) },
	{ShiftMask,					XK_Scroll_Lock, 	spawn, 		SHCMD(mednext) },
	{ControlMask,				XK_Scroll_Lock, 	spawn, 		SHCMD(medprev) },
	{0,							XK_Print,			spawn,		SHCMD(fullsshot) },
	{ShiftMask,					XK_Print,			spawn,		SHCMD(selsshot) },
	{ControlMask|ShiftMask,		XK_Print,			spawn,		SHCMD(sharesshot) },
	{ControlMask,				XK_Print,			spawn,		SHCMD(focshot) },
	{MODKEY,					XK_x,				spawn,		SHCMD(bootmenu) },

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkStatusText,        0,              Button1,        sigstatusbar,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigstatusbar,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigstatusbar,   {.i = 3} },
	{ ClkStatusText,        ShiftMask,      Button1,        sigstatusbar,   {.i = 4} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

