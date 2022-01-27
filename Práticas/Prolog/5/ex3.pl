:-op(500, xfx, na). 
:-op(500, yfx, la). 
:-op(500, xfy, ra).

/*
% See https://stackoverflow.com/a/20693625

a)  a ra b na c
    a xfy b xfx c
    a xfy (b xfx c)

b)  a la b na c
    a yfx b xfx c
LA wants: (a yfx b) xfx c
NA wants: a yfx (b xfx c)
Conflict

c)  a na b la c
    a xfx b yfx c
    (a xfx b) yfx c

d)  a na b ra c
    a xfx b xfy c
NA wants: (a xfx b) xfy c
RA wants: a xfx (b xfy c)
Conflict

e)  a na b na c
    a xfx b xfx c
NA1 wants: (a xfx b) xfx c
NA2 wants: a xfx (b xfx c)
Conflict

f)  a la b la c
    a yfx b yfx c
    (a yfx b) yfx c

g)  a ra b ra c
    a xfy b xfy c
    a xfy (b xfy c)
*/

