IF DEF(_RED)
DefaultNamesPlayer:
	db   "New name"
	next "RED"
	next "ASH"
	next "JACK"
	db   "@"

DefaultNamesRival:
	db   "New name"
	next "BLUE"
	next "GARY"
	next "JOHN"
	db   "@"
ENDC

IF DEF(_BLUE)
DefaultNamesPlayer:
	db   "New name"
	next "BLUE"
	next "GARY"
	next "JOHN"
	db   "@"

DefaultNamesRival:
	db   "New name"
	next "RED"
	next "ASH"
	next "JACK"
	db   "@"
ENDC
