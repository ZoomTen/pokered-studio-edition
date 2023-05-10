MACRO two_option_menu
	db \1, \2, \3
	dw \4
ENDM

TwoOptionMenuStrings:
; entries correspond to *_MENU constants
	table_width 5, TwoOptionMenuStrings
	; width, height, blank line before first menu item?, text pointer
	two_option_menu 18, 2, FALSE, .YesNoMenu
	two_option_menu 6, 3, FALSE, .NorthWestMenu
	two_option_menu 6, 3, FALSE, .SouthEastMenu
	two_option_menu 6, 3, FALSE, .YesNoMenu
	two_option_menu 6, 3, FALSE, .NorthEastMenu
	two_option_menu 7, 3, FALSE, .TradeCancelMenu
	two_option_menu 18, 2, FALSE,  .HealCancelMenu
	two_option_menu 18, 2, FALSE, .NoYesMenu
	assert_table_length NUM_TWO_OPTION_MENUS

.NoYesMenu:
	db   "No"
	next "Yes@"

.YesNoMenu:
	db   "Yes"
	next "No@"

.NorthWestMenu:
	db   "North"
	next "West@"

.SouthEastMenu:
	db   "South"
	next "East@"

.NorthEastMenu:
	db   "North"
	next "East@"

.TradeCancelMenu:
	db   "Trade"
	next "No thanks@"

.HealCancelMenu:
	db   "Heal"
	next "No thanks@"
