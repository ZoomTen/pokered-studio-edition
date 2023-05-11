; This function is used to wait a short period after printing a letter to the
; screen unless the player presses the A/B button or the delay is turned off
; through the [wd730] or [wLetterPrintingDelayFlags] flags.
PrintLetterDelay::
	ld a, [wd730]
	bit 6, a
	ret nz
	ld a, [wLetterPrintingDelayFlags]
	bit 1, a
	ret z
	push hl
	push de
	push bc
	ld a, [wLetterPrintingDelayFlags]
	bit 0, a
	jr z, .waitOneFrame
	ld a, [wOptions]
	and $f
	ldh [hFrameCounter], a
IF 0 ;;;;;;;;;;;;;;;;
	jr .checkButtons
ENDC
.waitOneFrame
	ld a, 1
	ldh [hFrameCounter], a
IF 0 ;;;;;;;;;;;;;;;;
.checkButtons
	call Joypad
	ldh a, [hJoyHeld]
.checkAButton
	bit BIT_A_BUTTON, a
	jr z, .checkBButton
	jr .done
.checkBButton
	bit BIT_B_BUTTON, a
	jr z, .buttonsNotPressed
	jr .done
.endWait
ENDC ;;;;;;;;;;;;;;;;
	call DelayFrame
IF 0 ;;;;;;;;;;;;;;;;
	jr .done
.buttonsNotPressed ; if neither A nor B is pressed
	ldh a, [hFrameCounter]
	and a
	jr nz, .checkButtons
.done
ENDC ;;;;;;;;;;;;;;;;
	pop bc
	pop de
	pop hl
	ret
