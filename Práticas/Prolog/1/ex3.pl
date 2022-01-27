pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

team('Lamb', 'Breitling').
team('Besenyei', 'Red Bull').
team('Chambliss', 'Red Bull').
team('MacLean', 'Mediterranean Racing Team').
team('Mangold', 'Cobra').
team('Jones', 'Matador').
team('Bonhomme', 'Matador').

plane('Lamb', 'MX2').
plane('Besenyei', 'Edge540').
plane('Chambliss', 'Edge540').
plane('MacLean', 'Edge540').
plane('Mangold', 'Edge540').
plane('Jones', 'Edge540').
plane('Bonhomme', 'Edge540').

track('Istanbul').
track('Budapest').
track('Porto').

win_at('Jones', 'Porto').
win_at('Mangold', 'Budapest').
win_at('Mangold', 'Istanbul').

num_gates('Istanbul', 9).
num_gates('Budapest', 6).
num_gates('Porto', 5).

/*
win_at(Winner, 'Porto').
win_at(_Winner, 'Porto'), team(_Winner, Team).
num_gates(Circuit, _Gates), _Gates > 8.
pilot(Pilot), \+plane(Pilot, 'Edge540').
win_at(Pilot, _T1), win_at(Pilot, _T2), _T1 \= _T2.
win_at(_Winner, 'Porto'), plane(_Winner, Plane).
*/