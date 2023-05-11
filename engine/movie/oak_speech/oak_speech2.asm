OakSpeech_ClearTextboxAndResetW:
	hlcoord 0, 0
	lb bc, 4, 20
	call ClearScreenArea
	call Delay3
	;xor a
	;ld [hWY], a
	ret

ChoosePlayerName:
	;call OakSpeech_ClearTextboxAndResetW
	;call OakSpeechSlidePicRight
	ld de, DefaultNamesPlayer
	call DisplayIntroNameTextBox
	ld a, [wCurrentMenuItem]
	and a
	jr z, .customName
	ld hl, DefaultNamesPlayerList
	call GetDefaultName
	ld de, wPlayerName
	call OakSpeechCopyNameBack
	call ScrollWindowDown
	jr .done
.customName
	ld hl, wPlayerName
	xor a ; NAME_PLAYER_SCREEN
	ld [wNamingScreenType], a
	call DisplayNamingScreen
	ld a, [wStringBuffer]
	cp "@"
	jr z, .customName
	call ClearScreen
	call Delay3
	ld de, RedPicFront
	ld b, BANK(RedPicFront)
	call IntroDisplayPicCenteredOrUpperRight
.done
	ld hl, YourNameIsText
	jp PrintText_Standalone_NoCopyBuffer

YourNameIsText:
	text_far _YourNameIsText
	text_end

ChooseRivalName:
	hlcoord 0, 0
	lb bc, 4, 20
	call ClearScreenArea
	call Delay3
	;call OakSpeechSlidePicRight
	ld de, DefaultNamesRival
	call DisplayIntroNameTextBox
	ld a, [wCurrentMenuItem]
	and a
	jr z, .customName
	ld hl, DefaultNamesRivalList
	call GetDefaultName
	ld de, wRivalName
	call OakSpeechCopyNameBack
	call ScrollWindowDown
	jr .done
.customName
	ld hl, wRivalName
	ld a, NAME_RIVAL_SCREEN
	ld [wNamingScreenType], a
	call DisplayNamingScreen
	ld a, [wStringBuffer]
	cp "@"
	jr z, .customName
	call ClearScreen
	call Delay3
	ld de, Rival1Pic
	ld b, $13
	call IntroDisplayPicCenteredOrUpperRight
.done
	ld hl, HisNameIsText
	jp PrintText_Standalone_NoCopyBuffer

HisNameIsText:
	text_far _HisNameIsText
	text_end

OakSpeechCopyNameBack::
	ld hl, wcd6d
	ld bc, NAME_LENGTH
	jp CopyData

OakSpeechSlidePicRight:
	hlcoord 5, 4
	lb de, 6, 6 * SCREEN_WIDTH + 5
	xor a

OakSpeechSlidePicCommon:
	push hl
	push de
	push bc
	ldh [hSlideDirection], a
	ld a, d
	ldh [hSlideAmount], a
	ld a, e
	ldh [hSlidingRegionSize], a
	ld c, a
	ldh a, [hSlideDirection]
	and a
	jr nz, .next
; If sliding right, point hl to the end of the pic's tiles.
	ld d, 0
	add hl, de
.next
	ld d, h
	ld e, l
.loop
	xor a
	ldh [hAutoBGTransferEnabled], a
	ldh a, [hSlideDirection]
	and a
	jr nz, .slideLeft
; sliding right
	ld a, [hli]
	ld [hld], a
	dec hl
	jr .next2
.slideLeft
	ld a, [hld]
	ld [hli], a
	inc hl
.next2
	dec c
	jr nz, .loop
	ldh a, [hSlideDirection]
	and a
	jr z, .next3
; If sliding left, we need to zero the last tile in the pic (there is no need
; to take a corresponding action when sliding right because hl initially points
; to a 0 tile in that case).
	xor a
	dec hl
	ld [hl], a
.next3
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ldh a, [hSlidingRegionSize]
	ld c, a
	ld h, d
	ld l, e
	ldh a, [hSlideDirection]
	and a
	jr nz, .slideLeft2
	inc hl
	jr .next4
.slideLeft2
	dec hl
.next4
	ld d, h
	ld e, l
	ldh a, [hSlideAmount]
	dec a
	ldh [hSlideAmount], a
	jr nz, .loop
	pop bc
	pop de
	pop hl
	ret

DisplayIntroNameTextBox:
	push de
	hlcoord 0, 0
	lb bc, 4, 18
	call TextBoxBorder
	pop de
	hlcoord 2, 1
	call PlaceString
	call UpdateSprites
	ld a, 6
	ld [wWinTilesToScroll], a
	call ScrollWindowUp
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	inc a
	ld [wTopMenuItemX], a
	ld [wMenuWatchedKeys], a ; A_BUTTON
	ld [wTopMenuItemY], a
	inc a
	inc a
	ld [wMaxMenuItem], a
	jp HandleMenuInput

INCLUDE "data/player_names.asm"

GetDefaultName:
; a = name index
; hl = name list
	ld b, a
	ld c, 0
.loop
	ld d, h
	ld e, l
.innerLoop
	ld a, [hli]
	cp "@"
	jr nz, .innerLoop
	ld a, b
	cp c
	jr z, .foundName
	inc c
	jr .loop
.foundName
	ld h, d
	ld l, e
	ld de, wcd6d
	ld bc, NAME_BUFFER_LENGTH
	jp CopyData

INCLUDE "data/player_names_list.asm"

LinkMenuEmptyText:
	text_end
