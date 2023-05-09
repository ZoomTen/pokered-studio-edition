EmotionBubble:
	ld a, [wWhichEmotionBubble]
	ld c, a
	ld b, 0
	ld hl, EmotionBubblesPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, vChars1 tile $78
	lb bc, BANK(EmotionBubbles), 4
	call CopyVideoData
	ld a, [wUpdateSpritesEnabled]
	push af
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld a, [wd736]
	bit 6, a ; are the last 4 OAM entries reserved for a shadow or fishing rod?
	ld hl, wShadowOAMSprite35Attributes
	ld de, wShadowOAMSprite39Attributes
	jr z, .next
	ld hl, wShadowOAMSprite31Attributes
	ld de, wShadowOAMSprite35Attributes

; Copy OAM data 16 bytes forward to make room for emotion bubble OAM data at the
; start of the OAM buffer.
.next
	ld bc, $90
.loop
	ld a, [hl]
	ld [de], a
	dec hl
	dec de
	dec bc
	ld a, c
	or b
	jr nz, .loop

; get the screen coordinates of the sprite the bubble is to be displayed above
	ld hl, wSpritePlayerStateData1YPixels
	ld a, [wEmotionBubbleSpriteIndex]
	swap a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld b, a
	inc hl
	ld a, [hl]
	add $8
	ld c, a

; reuse wEmotionBubbleSpriteIndex as indicator
	xor a
	ld [wEmotionBubbleSpriteIndex], a
	
	ld hl, EmotionBubbleYAnimOffsets
.do_animation
	push bc
		ld a, [hli]
		cp $80  ; sentinel value
		jr nz, .not_done
	; done
		ld a, 1
		ld [wEmotionBubbleSpriteIndex], a
		jr .put_to_oam
.not_done
		add b
		ld b, a
.put_to_oam
		xor a
		ld de, EmotionBubblesOAM
		push hl
			call WriteOAMBlock
		pop hl
		call DelayFrame
	pop bc
	ld a, [wEmotionBubbleSpriteIndex]
	and a
	jr z, .do_animation
	ld c, 45
	call DelayFrames
	pop af
	ld [wUpdateSpritesEnabled], a
	call DelayFrame
	jp UpdateSprites

EmotionBubblesPointerTable:
; entries correspond to *_BUBBLE constants
	dw ShockEmote
	dw QuestionEmote
	dw HappyEmote

EmotionBubblesOAM:
	dbsprite  0, -1,  0,  0, $f9, 0
	dbsprite  0, -1,  0,  2, $fb, 0

EmotionBubbleYAnimOffsets:
	db 0, -1, -2, -3, -4, -5, -6, -7
	db -6, -5, -4, -3, -2, -1, 0
	db $80  ; terminator

EmotionBubbles:
ShockEmote:    INCBIN "gfx/emotes/shock.2bpp"
QuestionEmote: INCBIN "gfx/emotes/question.2bpp"
HappyEmote:    INCBIN "gfx/emotes/happy.2bpp"
