.data		
# Colors			       	# FLAG    | R  | G  | B   			#
arenaBG:	.word 0xBB55D914	# BB      | 55 | D9 | 14  ----BACKGROUND COLOR	#

# Addresses	------------------------------------------------------------------------
screenStart:	.word 0x10010500

.macro PaintArena 
		li $t0, 256 #starting line index [halved line size]
		li $t1, 0 #starting pixel index
		lw $t3, screenStart # load starting address on t3		
		lw $t2, arenaBG #load bg color on t2	
	drawline:
		sw $t2, ($t3)		# paint pixel_address
		addi $t3, $t3, 4	# pixel_adress++
		addi $t1, $t1, 4	# pixel_i++
		blt $t1, $t0, drawline	# if pixel_index < (line_size/2), keep painting line
		addi $t3, $t3, 128	# 	else, jump pixel_adress to next beginning line.
		addi $t1, $t1, 128	# 	jump pixel_i to next beginning line.
		addi $t0, $t0, 256	# 	line_i++.
		ble  $t0, 6784, drawline# if not finished painting line, do it again
					# (27*line_size)+(line_size/2)=6784
	.end_macro
.text
	
	PaintArena		#Paint the arena