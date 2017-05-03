// can go for a cleanup.
// Orig from: https://bitbucket.org/skulltus/ultimate-dwm
#include <X11/XF86keysym.h>
#define NUMCOLORS       14
#define MODKEY          Mod4Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
static const unsigned int tagspacing = 1;       /* space between tags */
static const unsigned int tagpadding = 1;      /* inner padding of tags */
static const unsigned int taglinepx = 4;        /* height of tag underline */
static const unsigned int systrayspacing = 0;   /* systray spacing */
static const Bool showsystray = False;           /* false means no systray */
static const unsigned int gappx = 10;            /* gaps between windows */
static const unsigned int borderpx = 1;         /* border pixel of windows */
static const unsigned int snap = 32;            /* snap pixel */
static const Bool showbar = True;               /* false means no bar */
static const Bool topbar = True;                /* false means bottom bar */
static const float mfact = 0.50;                /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;                   /* number of clients in master area */
static const Bool resizehints = False;          /* true means respect size hints in tiled resizals */
static const char font[] = "-*-tamsynmod-medium-r-*-*-14-*-*-*-*-*-*-*"; //-*-terminus-medium-r-*-*-20-*-*-*-*-*-*-*";
static const char font2[] = "-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*";
static const char colors[NUMCOLORS][ColLast][10] = {
    /* border    fg         bg */
    { "#002b36", "#afd700", "#002b36" },        /* 01 - regular */
    { "#cb4b16", "#afd700", "#cb4b16" },        /* 02 - selected */
    { "#268bd2", "#afd700", "#002b36" },        /* 03 - urgent */
    { "#268bd2", "#cb4b16", "#002b36" },        /* 04 - occupied */
    { "#d44782", "#FFFFFF", "#d44782" },        /* 05 - Wifi */
    { "#a54242", "#000000", "#a54242" },        /* 06 - Battery */
    { "#131516", "#5d810e", "#131516" },        /* 09 - PROC */
    { "#afd700", "#dc322f", "#002b36" },        /* 0A - layout colours */
    { "#ff2c4b", "#FFFFFF", "#ff2c4b" },        /* 0B - Clock */
    { "#0b9dff", "#054f87", "#0b9dff" },        /* 0C - Volume */
    { "#20B2AA", "#000000", "#20B2AA"},      /* 0E - Mem free */
};
static const Layout layouts[] = {
    /* symbol   gaps    arrange */
    { "þ",      True,   tile },
    { "ü",      True,   bstack },
    { "ÿ",      False,  monocle },
    { "ý",      False,  NULL },
};
static const Tag tags[] = {
    /* name     layout          mfact   nmaster */
    { "web",    &layouts[0],    -1,     -1 },
    { "term",   &layouts[1],    -1,     -1 },
    { "media",  &layouts[1],    -1,     -1 },
    { "misc",   &layouts[0],    -1,     -1 },
    { "work",   &layouts[0],    -1,     -1 },
};
static const Rule rules[] = {
    /* class                   instance    title       tags mask     isfloating      iscentred       monitor */
   { "Chromium",                NULL,       NULL,       1 << 0,       False,            False,        -1 },
   { "Chrome",                  NULL,       NULL,       1 << 0,       False,            False,        -1 },
   { "Dwarf Fortress"           NULL,       NULL,       4 << 0,       True,             True,         -1 },
   { "Google-chrome-stable",    NULL,       NULL,       1 << 0,       False,            False,        -1 },
   { "Filezilla",               NULL,       NULL,       1 << 3,       False,            False,        -1 },
   { "Truecrypt",               NULL,       NULL,       0,            True,             True,         -1 },
   { "Firefox",                 NULL,       NULL,       1 << 0,       False,            False,        -1 },
   { "Steam",                   NULL,       NULL,       1 << 3,       False,            True,         -1 },
   { "Gimp",                    NULL,       NULL,       0,            True,             True,         -1 },
   { "Virtualbox",              NULL,       NULL,       1 << 3,       True,             False,        -1 },
   { "FTL",                     NULL,       NULL,       1 << 3,       True,             True,         -1 },
   {  NULL,                     NULL,     "mutt",       1 << 4,       False,            False,        -1 },
   {  NULL,                     NULL,       "st",       1 << 1,       False,            False,        -1 },
   {  NULL,                     NULL,  "youtube",       1 << 2,       False,            False,        -1 },
   { "mpv",                     NULL,       NULL,       1 << 2,       False,            False,        -1 },
};
/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/zsh", "-c", cmd, NULL } }
//static const char *menu[] = { "dmenu_run", "-i", "-fn", font, "-nb", "#002b36", "-nf", "#afd700", "-sb", "#cb4b16", "-sf", "#afd700", NULL };
static const char *menu[] = { "rofi", "-show", "run", "-config", "$HOME/.config/rofi/royal-sky.theme", "-font", "Source Sans Pro 12", NULL };
static const char *menu2[] = { "rofi", "-show", "window", "-config", "~/.config/rofi/royal-sky.theme", "-font", "Source Sans Pro 12", NULL };
static const char *webb[] = { "chromium", NULL, "chromium" };
static const char *file[] = { "st", "-e", "ranger", NULL };
static const char *img[] = { "feh", "-F", "$HOME/media/img", NULL };
static const char *term[] = { "st", NULL, };
static Key keys[] = {
    { MODKEY,           XK_p,       spawn,          {.v = menu } },
    { MODKEY|ShiftMask, XK_w,       runorraise,     {.v = webb } },
    { MODKEY|ShiftMask, XK_Return,  spawn,          {.v = term } },
    { MODKEY|ShiftMask, XK_f,       spawn,     {.v = file } },
    { MODKEY|ShiftMask, XK_i,       spawn,          {.v = img } },
    { MODKEY|ShiftMask, XK_q,       quit,           {0} },
    { MODKEY|ShiftMask, XK_b,       togglebar,      {0} },
    { MODKEY|ShiftMask, XK_c,       killclient,     {0} },
    { MODKEY,           XK_Return,  zoom,           {0} },
    { MODKEY,           XK_Tab,     spawn,           {.v = menu2 } },
    { MODKEY|ControlMask,     XK_f, togglefloating, {0} },
    { MODKEY,           XK_space,   setlayout,      {0} },
    { MODKEY,           XK_t,       setlayout,      {.v = &layouts[0] } },
    { MODKEY,           XK_b,       setlayout,      {.v = &layouts[1] } },
    { MODKEY,           XK_m,       setlayout,      {.v = &layouts[2] } },
    { MODKEY,           XK_f,       setlayout,      {.v = &layouts[3] } },
    { MODKEY,           XK_j,       focusstack,     {.i = +1 } },
    { MODKEY,           XK_k,       focusstack,     {.i = -1 } },
    { MODKEY,           XK_h,       setmfact,       {.f = -0.05 } },
    { MODKEY,           XK_l,       setmfact,       {.f = +0.05 } },
    { MODKEY,           XK_equal,   incnmaster,     {.i = +1 } },
    { MODKEY,           XK_minus,   incnmaster,     {.i = -1 } },
    { MODKEY,           XK_Down,    focusstack,     {.i = +1 } },
    { MODKEY,           XK_Up,      focusstack,     {.i = -1 } },
    { MODKEY,           XK_0,       view,           {.ui = ~0 } },
    { MODKEY|ShiftMask, XK_0,       tag,            {.ui = ~0 } },
    { MODKEY,           XK_comma,   focusmon,       {.i = -1 } },
    { MODKEY,           XK_period,  focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask, XK_comma,   tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask, XK_period,  tagmon,         {.i = +1 } },
    { MODKEY,                       XK_Left,   cycle,          {.i = -1 } },
    { MODKEY,                       XK_Right,  cycle,          {.i = +1 } },
    { MODKEY|ControlMask,           XK_Left,   tagcycle,       {.i = -1 } },
    { MODKEY|ControlMask,           XK_Right,  tagcycle,       {.i = +1 } },
    { MODKEY|ControlMask,           XK_j,      pushdown,       {0} },
    { MODKEY|ControlMask,           XK_k,      pushup,         {0} },
    { MODKEY|ControlMask,           XK_q,      quit,           {0} },
    TAGKEYS(            XK_1,       0)
    TAGKEYS(            XK_2,       1)
    TAGKEYS(            XK_3,       2)
    TAGKEYS(            XK_4,       3)
    TAGKEYS(            XK_5,       4)
    TAGKEYS(            XK_6,       5)
};
static Button buttons[] = {
    { ClkLtSymbol,      0,          Button1,        setlayout,      {0} },
    { ClkClientWin,     MODKEY,     Button1,        movemouse,      {0} },
    { ClkClientWin,     MODKEY,     Button2,        togglefloating, {0} },
    { ClkClientWin,     MODKEY,     Button3,        resizemouse,    {0} },
    { ClkTagBar,        0,          Button1,        view,           {0} },
    { ClkTagBar,        0,          Button3,        toggleview,     {0} },
    { ClkTagBar,        MODKEY,     Button1,        tag,            {0} },
    { ClkTagBar,        MODKEY,     Button3,        toggletag,      {0} },
};
