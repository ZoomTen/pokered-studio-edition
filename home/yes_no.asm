; displays yes/no choice
; yes -> set carry
YesNoChoice::
; if there's more text right after a yes/no choice
	call SaveScreenTilesToBuffer1
	call InitYesNoTextBoxParameters
	call DisplayYesNoChoice
	push af
		call ScrollWindowUpTextBox
	pop af
	ret
	
YesNoChoice_NoContinue::
; if text closes right after a yes/no choice
	call SaveScreenTilesToBuffer1
	call InitYesNoTextBoxParameters
	jr DisplayYesNoChoice
	

TwoOptionMenu:: ; unreferenced
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call InitYesNoTextBoxParameters
	jp DisplayTextBoxID

InitYesNoTextBoxParameters::
	xor a ; YES_NO_MENU
	ld [wTwoOptionMenuID], a
	hlcoord 0, 0
	lb bc, 1, 1
	ret

YesNoChoicePokeCenter::
	call SaveScreenTilesToBuffer1
	ld a, HEAL_CANCEL_MENU
	ld [wTwoOptionMenuID], a
	hlcoord 0, 0
	lb bc, 1, 1
	jr DisplayYesNoChoice

WideYesNoChoice:: ; unused
	call SaveScreenTilesToBuffer1
	ld a, WIDE_YES_NO_MENU
	ld [wTwoOptionMenuID], a
	hlcoord 12, 7
	lb bc, 8, 13

DisplayYesNoChoice::
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	push af
	call ScrollWindowDown
; instantly hide the textbox from view
	call HideWindow
	call ClearTextBoxArea
	pop af
	ret
