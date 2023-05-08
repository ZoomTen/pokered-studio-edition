import loadmod as modfile
import re
import sys

if __name__ == "__main__":
	module_loaded = modfile.read_module(sys.argv[1])
	
	import pprint
		
	if module_loaded:
		title = re.findall("[A-Za-z0-9_]+", modfile.songtitle)[0]
		
		loop_point = None
		
		def insnumber_to_parameters(ins_number: str) -> dict:
			p = {
				"duty_cycle": None,
				"wave_index": None,
				"drum_instrument": None
			}
			actual_number = int(ins_number, 16)
			
			if actual_number >= 1 and actual_number <= 4:
				p["duty_cycle"] = actual_number % 4  # ins. 4 == duty 0
			elif actual_number >= 8 and actual_number <= 15:
				p["wave_index"] = actual_number - 8
			elif actual_number >= 16 and actual_number <= 31:
				p["drum_instrument"] = actual_number - 15
			
			return p
		
		def volumefx_to_gbvolume(volume: str, channel: int) -> int:
			actual_volume = int(volume, 16)
			# clip
			if actual_volume > 63:
				actual_volume = 63
			if channel < 2:
				return actual_volume >> 2
			elif channel == 2:
				return 3 - (actual_volume >> 4) + 1
			else:
				return 15  # noise does not have configurable volume
	
		# search loop point
		# only one is to be used, and it's the last Bxx effect
		for pattern in modfile.patterns:
			for row in pattern:
				for channel in row:
					note, instrument, effect = channel.split(" ")
					if effect[0] == "B":
						loop_point = int(effect[1:])
		
		# crysaudio header
		print("%s::\n\tchannel_count 4" % (title))
		
		for channel in range(4):
			print("\tchannel %d, %s_Ch%d" % (channel + 1, title, channel + 1))
		
		print()
		
		# begin writing file
		tempo_set = False
		
		for channel in range(4):
			command_bin = []
			print("%s_Ch%d::" % (title, channel + 1))
			
			if channel == 0:
				command_bin.append("tempo 90")  # ensure stability
				command_bin.append("volume 7, 7")
			
			if channel == 3:  # noise
				command_bin.append("toggle_noise 7")  # crysaudio
				command_bin.append("drum_speed 12")
			else:
				command_bin.append("note_type 12, 0, 0")  # ensure stability
		
			
			# emulate order
			for index, order in enumerate(modfile.pattern_table):
				# place loop point
				if loop_point == index:
					command_bin.append(".loop")
				
				command_bin.append("sound_call .sub%d" % order)
			
			# how to end song
			if loop_point == None:
				command_bin.append("sound_ret")
			else:
				command_bin.append("sound_loop 0, .loop")
			
			command_bin.append(" ")  # empty
			
			# write the actual patterns
			# artifical rows are written when needed
			# XXX = indicates a rest note
			# YYY = indicates the pattern's cutoff point
			for pattern_index, pattern in enumerate(modfile.patterns):
				command_bin.append(".sub%d" % pattern_index)
				
				current_duty_cycle = None  # is wave for ch3
				current_volume = None
				current_note = None
				previous_note_before_rest = None
				current_length = -1
				current_octave = None
				current_volume = None
				should_skip_rest = False
				afternote_events_queue = []
				
				# add an extra row to mark the end of the pattern
				pattern.append(["YYY 00 000"] * len(pattern[0]))
				
				# also find cutoff points of Bxx & Dxx
				# Bxx or Dxx skips entire pattern unconditionally
				# for Dxx only D00 should be used!
				cutoff_points = []
				for row_index, row in enumerate(pattern):
					for channel_index, channel_content in enumerate(row):
						note, instrument, effect = channel_content.split(" ")
						if effect[0] == "B" or effect[0] == "D":
							cutoff_points.append(row_index)
				
				# insert cutoff points
				for point in cutoff_points:
					pattern.insert(point + 1, ["YYY 00 000"] * len(pattern[0]))
				
				for row_index, row in enumerate(pattern):
					# process fx first
					for channel_index, channel_content in enumerate(row):
						note, instrument, effect = channel_content.split(" ")
						if effect[0] == "F":
							if not tempo_set: # only allows single use
								command_bin.append("tempo %d" %
									(int(effect[1:], 16) * 26)
								)
								tempo_set = True
					
					# then individual channels
					for channel_index, channel_content in enumerate(row):
						note, instrument, effect = channel_content.split(" ")
						
						# handle patterns not starting at row 0
						if row_index == 0:
							if note == "---":
								note = "XXX"
								
						# write rows
						if not should_skip_rest:
							if channel_index == channel:
								new_params = insnumber_to_parameters(instrument)
								
								if channel_index < 2:
									if new_params["duty_cycle"] != None and new_params["duty_cycle"] != current_duty_cycle:
										current_duty_cycle = new_params["duty_cycle"]
										command_bin.append("duty_cycle %d" % current_duty_cycle)
								elif channel_index == 2:
									if new_params["wave_index"] != None and new_params["wave_index"] != current_duty_cycle:
										current_duty_cycle = new_params["wave_index"]
								elif channel_index == 3:
									if new_params["drum_instrument"] != None and new_params["drum_instrument"] != current_duty_cycle:
										current_duty_cycle = new_params["drum_instrument"]
								
								if effect[0] == "C":
									volume = effect[1:]
									if volume == "00":
										if note != "YYY": # unless the pattern ended
											# if note cut, force a note to appear at that position
											note = "XXX"
									else:
										# a note MUST be associated with this row
										if note == "---":
											if current_note == "rest":
												if previous_note_before_rest:
													note = "%s%s" % (previous_note_before_rest, current_octave)
											else:
												note = "%s%s" % (current_note, current_octave)
										try:
											old_volume = volumefx_to_gbvolume(current_volume, channel_index)
										except:
											old_volume = -1
										new_volume = volumefx_to_gbvolume(volume, channel_index)
										if old_volume != new_volume:
											current_volume = volume
											if channel_index < 2:
												low_value = 0
											elif channel_index == 2:
												low_value = current_duty_cycle
											afternote_events_queue.append("note_type 12, %d, %d" % (
												new_volume, low_value
											))
									
									
								if note != "---":
									if note != "XXX" and note != "YYY":
										note_ = note[0:2]
										octave = int(note[2])
									else:
										octave = -1
									if current_note != None and current_length != -1:
										if current_length > 16:
											command_bin.append("; WARNING @ %d.%d.%d : previous note lasted for too long! Must be less than 16" % (
												pattern_index, row_index, channel_index
											))
										if current_note == "rest":
										# at least apply makeup if it is a rest note
											if current_length > 16:
												lens_div, lens_mod = divmod(current_length, 16)
												for len_makeup in range(lens_div):
													command_bin.append("rest 16")
												if lens_mod > 0:
													command_bin.append("rest %d" % (lens_mod))
											else:
												command_bin.append("rest %d" % (current_length))
										else:
											if channel_index == 3:
												command_bin.append(
													"drum_note %d, %d" % (
														current_duty_cycle,
														current_length
													)
												)
											else:
												command_bin.append("note %s, %d" % (current_note.replace("-","_"), current_length))
									if current_octave != octave:
										if note != "XXX" and note != "YYY":
											current_octave = octave
											if channel_index != 3:
												command_bin.append("octave %d" % octave)
									if note != "XXX" and note != "YYY":
										current_note = note_
									else:
										if current_note != "rest":
											previous_note_before_rest = current_note
										current_note = "rest"
									for ev in afternote_events_queue:
										command_bin.append(ev)
									afternote_events_queue.clear()
									current_length = 1
								else:
									current_length += 1
								
								# command_bin.append("; --------- %s %s %s" % (note, instrument, effect))
								
								if note == "YYY":
									should_skip_rest = True  
							#print(insnumber_to_parameters(instrument))
						#print(row)
				command_bin.append("sound_ret")
				command_bin.append(" ")
			
			# -----------------------------------------------
			
			# write everything
			for command in command_bin:
				if command[0] in [".", " ", ";"]:  # is relative symbol, empty or comment
					print("%s" % command)
				else:
					print("\t%s" % command)
			
			
		#import pprint
		#pprint.pprint(loadmod.patterns)
		#for i in loadmod.pattern_table:
		#	print(i)
		#print(loadmod.pattern_table)
