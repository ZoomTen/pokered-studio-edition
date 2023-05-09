INCLUDE "crysaudio/macros.asm"
INCLUDE "crysaudio/audio_constants.asm"
INCLUDE "crysaudio/cry_constants.asm"


SECTION "Sound Effect Headers 1", ROMX
INCLUDE "audio/headers/sfxheaders1.asm"

SECTION "Sound Effect Headers 2", ROMX
INCLUDE "audio/headers/sfxheaders2.asm"

SECTION "Sound Effect Headers 3", ROMX
INCLUDE "audio/headers/sfxheaders3.asm"


SECTION "Sound Effects 1", ROMX

INCLUDE "audio/sfx/start_menu_1.asm"
INCLUDE "audio/sfx/pokeflute.asm"
INCLUDE "audio/sfx/cut_1.asm"
INCLUDE "audio/sfx/go_inside_1.asm"
INCLUDE "audio/sfx/swap_1.asm"
INCLUDE "audio/sfx/tink_1.asm"
INCLUDE "audio/sfx/59_1.asm"
INCLUDE "audio/sfx/purchase_1.asm"
INCLUDE "audio/sfx/collision_1.asm"
INCLUDE "audio/sfx/go_outside_1.asm"
INCLUDE "audio/sfx/press_ab_1.asm"
INCLUDE "audio/sfx/save_1.asm"
INCLUDE "audio/sfx/heal_hp_1.asm"
INCLUDE "audio/sfx/poisoned_1.asm"
INCLUDE "audio/sfx/heal_ailment_1.asm"
INCLUDE "audio/sfx/trade_machine_1.asm"
INCLUDE "audio/sfx/turn_on_pc_1.asm"
INCLUDE "audio/sfx/turn_off_pc_1.asm"
INCLUDE "audio/sfx/enter_pc_1.asm"
INCLUDE "audio/sfx/shrink_1.asm"
INCLUDE "audio/sfx/switch_1.asm"
INCLUDE "audio/sfx/healing_machine_1.asm"
INCLUDE "audio/sfx/teleport_exit1_1.asm"
INCLUDE "audio/sfx/teleport_enter1_1.asm"
INCLUDE "audio/sfx/teleport_exit2_1.asm"
INCLUDE "audio/sfx/ledge_1.asm"
INCLUDE "audio/sfx/teleport_enter2_1.asm"
INCLUDE "audio/sfx/fly_1.asm"
INCLUDE "audio/sfx/denied_1.asm"
INCLUDE "audio/sfx/arrow_tiles_1.asm"
INCLUDE "audio/sfx/push_boulder_1.asm"
INCLUDE "audio/sfx/ss_anne_horn_1.asm"
INCLUDE "audio/sfx/withdraw_deposit_1.asm"
INCLUDE "audio/sfx/safari_zone_pa.asm"

INCLUDE "audio/sfx/get_item1_1.asm"
INCLUDE "audio/sfx/pokedex_rating_1.asm"
INCLUDE "audio/sfx/get_item2_1.asm"
INCLUDE "audio/sfx/get_key_item_1.asm"


SECTION "Sound Effects 2", ROMX

INCLUDE "audio/sfx/silph_scope.asm"
INCLUDE "audio/sfx/ball_toss.asm"
INCLUDE "audio/sfx/ball_poof.asm"
INCLUDE "audio/sfx/faint_thud.asm"
INCLUDE "audio/sfx/run.asm"
INCLUDE "audio/sfx/dex_page_added.asm"
INCLUDE "audio/sfx/peck.asm"
INCLUDE "audio/sfx/faint_fall.asm"
INCLUDE "audio/sfx/battle_09.asm"
INCLUDE "audio/sfx/pound.asm"
INCLUDE "audio/sfx/battle_0b.asm"
INCLUDE "audio/sfx/battle_0c.asm"
INCLUDE "audio/sfx/battle_0d.asm"
INCLUDE "audio/sfx/battle_0e.asm"
INCLUDE "audio/sfx/battle_0f.asm"
INCLUDE "audio/sfx/damage.asm"
INCLUDE "audio/sfx/not_very_effective.asm"
INCLUDE "audio/sfx/battle_12.asm"
INCLUDE "audio/sfx/battle_13.asm"
INCLUDE "audio/sfx/battle_14.asm"
INCLUDE "audio/sfx/vine_whip.asm"
INCLUDE "audio/sfx/battle_16.asm"
INCLUDE "audio/sfx/battle_17.asm"
INCLUDE "audio/sfx/battle_18.asm"
INCLUDE "audio/sfx/battle_19.asm"
INCLUDE "audio/sfx/super_effective.asm"
INCLUDE "audio/sfx/battle_1b.asm"
INCLUDE "audio/sfx/battle_1c.asm"
INCLUDE "audio/sfx/doubleslap.asm"
INCLUDE "audio/sfx/battle_1e.asm"
INCLUDE "audio/sfx/horn_drill.asm"
INCLUDE "audio/sfx/battle_20.asm"
INCLUDE "audio/sfx/battle_21.asm"
INCLUDE "audio/sfx/battle_22.asm"
INCLUDE "audio/sfx/battle_23.asm"
INCLUDE "audio/sfx/battle_24.asm"
INCLUDE "audio/sfx/battle_25.asm"
INCLUDE "audio/sfx/battle_26.asm"
INCLUDE "audio/sfx/battle_27.asm"
INCLUDE "audio/sfx/battle_28.asm"
INCLUDE "audio/sfx/battle_29.asm"
INCLUDE "audio/sfx/battle_2a.asm"
INCLUDE "audio/sfx/battle_2b.asm"
INCLUDE "audio/sfx/battle_2c.asm"
INCLUDE "audio/sfx/psybeam.asm"
INCLUDE "audio/sfx/battle_2e.asm"
INCLUDE "audio/sfx/battle_2f.asm"
INCLUDE "audio/sfx/psychic_m.asm"
INCLUDE "audio/sfx/battle_31.asm"
INCLUDE "audio/sfx/battle_32.asm"
INCLUDE "audio/sfx/battle_33.asm"
INCLUDE "audio/sfx/battle_34.asm"
INCLUDE "audio/sfx/battle_35.asm"
INCLUDE "audio/sfx/battle_36.asm"

INCLUDE "audio/sfx/level_up.asm"
INCLUDE "audio/sfx/caught_mon.asm"

INCLUDE "audio/sfx/pokeflute_ch5_ch6.asm"
INCLUDE "audio/sfx/pokeflute_ch7.asm"


SECTION "Sound Effects 3", ROMX

INCLUDE "audio/sfx/intro_lunge.asm"
INCLUDE "audio/sfx/intro_hip.asm"
INCLUDE "audio/sfx/intro_hop.asm"
INCLUDE "audio/sfx/intro_raise.asm"
INCLUDE "audio/sfx/intro_crash.asm"
INCLUDE "audio/sfx/intro_whoosh.asm"
INCLUDE "audio/sfx/slots_stop_wheel.asm"
INCLUDE "audio/sfx/slots_reward.asm"
INCLUDE "audio/sfx/slots_new_spin.asm"
INCLUDE "audio/sfx/shooting_star.asm"


SECTION "Music Routines", ROMX

INCLUDE "audio/play_battle_music.asm"


SECTION "Alt Music Routines", ROMX

INCLUDE "audio/alternate_tempo.asm"


SECTION "Pokedex Rating SFX Routines", ROMX

INCLUDE "audio/pokedex_rating_sfx.asm"

; crystal:

SECTION "Audio Engine 1", ROMX

INCLUDE "crysaudio/engine.asm"

INCLUDE "crysaudio/music_pointers_red.asm"
;INCLUDE "crysaudio/music_pointers.asm"

INCLUDE "crysaudio/music/nothing.asm"

INCLUDE "crysaudio/cry_pointers.asm"

INCLUDE "crysaudio/sfx_pointers_red.asm"
;INCLUDE "crysaudio/sfx_pointers.asm"


SECTION "RBY Songs 1", ROMX

INCLUDE "crysaudio/music/RBY/pkmnhealed.asm"
INCLUDE "crysaudio/music/RBY/routes1.asm"
INCLUDE "crysaudio/music/RBY/routes3.asm"
INCLUDE "crysaudio/music/RBY/routes4.asm"
INCLUDE "crysaudio/music/RBY/indigoplateau.asm"
INCLUDE "crysaudio/music/RBY/unusedsong.asm"
INCLUDE "crysaudio/music/RBY/cities1.asm"
INCLUDE "crysaudio/music/RBY/museumguy.asm"
INCLUDE "crysaudio/music/RBY/meetprofoak.asm"
INCLUDE "crysaudio/music/RBY/meetrival.asm"
INCLUDE "crysaudio/music/RBY/ssanne.asm"
INCLUDE "crysaudio/music/RBY/cities2.asm"
INCLUDE "crysaudio/music/RBY/celadon.asm"
INCLUDE "crysaudio/music/RBY/cinnabar.asm"
INCLUDE "crysaudio/music/RBY/vermilion.asm"
INCLUDE "crysaudio/music/RBY/lavender.asm"
INCLUDE "crysaudio/music/RBY/safarizone.asm"
INCLUDE "crysaudio/music/RBY/gym.asm"
INCLUDE "crysaudio/music/RBY/pokecenter.asm"


SECTION "RBY Songs 2", ROMX

INCLUDE "crysaudio/music/RBY/gymleaderbattle.asm"
INCLUDE "crysaudio/music/RBY/wildbattle.asm"
INCLUDE "crysaudio/music/RBY/finalbattle.asm"
INCLUDE "crysaudio/music/RBY/defeatedtrainer.asm"
INCLUDE "crysaudio/music/RBY/defeatedwildmon.asm"
INCLUDE "crysaudio/music/RBY/defeatedgymleader.asm"


SECTION "RBY Songs 3", ROMX

INCLUDE "crysaudio/music/RBY/bikeriding.asm"
INCLUDE "crysaudio/music/RBY/dungeon1.asm"
INCLUDE "crysaudio/music/RBY/gamecorner.asm"
INCLUDE "crysaudio/music/RBY/titlescreen.asm"
INCLUDE "crysaudio/music/RBY/dungeon2.asm"
INCLUDE "crysaudio/music/RBY/dungeon3.asm"
INCLUDE "crysaudio/music/RBY/cinnabarmansion.asm"
INCLUDE "crysaudio/music/RBY/oakslab.asm"
INCLUDE "crysaudio/music/RBY/pokemontower.asm"
INCLUDE "crysaudio/music/RBY/silphco.asm"
INCLUDE "crysaudio/music/RBY/meeteviltrainer.asm"
INCLUDE "crysaudio/music/RBY/meetmaletrainer.asm"
INCLUDE "crysaudio/music/RBY/surfing.asm"
INCLUDE "crysaudio/music/RBY/jigglypuffsong.asm"
INCLUDE "crysaudio/music/RBY/halloffame.asm"
INCLUDE "crysaudio/music/RBY/credits.asm"

SECTION "GBT Player Styled Songs 1", ROMX

INCLUDE "crysaudio/music/shit/titlescreen.asm"
INCLUDE "crysaudio/music/shit/meetfemaletrainer.asm"
INCLUDE "crysaudio/music/shit/introbattle.asm"
INCLUDE "crysaudio/music/shit/routes2.asm"
INCLUDE "crysaudio/music/shit/pallettown.asm"
INCLUDE "crysaudio/music/shit/trainerbattle.asm"


SECTION "Sound Effects", ROMX

INCLUDE "crysaudio/sfx.asm"


SECTION "Cries", ROMX

INCLUDE "crysaudio/cry_headers.asm"

INCLUDE "crysaudio/cries.asm"
