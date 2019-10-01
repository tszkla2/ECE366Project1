.data
T: .word 12 # 0x2000
best_matching_scre: .word -1 # best score = ? within [0, 32] 0x2004
best_matching_count: .word -1 # how many patterns achieve the best score? #2008
Pattern_Array: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20   #start 0x200c
.text

addi $22, $0, 0x200c #$22=Adress Counter
lw $8, 0x2000
addi $18, $0, 32
addi $20, $0, 0 #Value of best score

setup:
lw $9, ($22) #$9=value of address $22
addi $11, $0, 0 #Counter of 1 bits
xor $10, $8, $9 #Xor to get number of matching 1 bits
j loop

loop:
xor $13, $10, 0 #Xor to know when to exit loop
beq $13, 0, done
andi $12, $10, 1 #Matching ones
beq $12, 1, one
srl $10, $10, 1 #Shift to calculate next bit
j loop

one:
addi $11, $11, 1 #Add matching bit to counter
srl $10, $10, 1 #Shift to calculate next bit
j loop

done:
sub $19, $18, $11 #32-number of matching bits
slt $21, $20, $19 #Find best score
beq $21, 1, best
beq $19, $20, best2
j finish 

best:
sw $19, 0x2004 #Store best score
addi $20, $19, 0 #Store value of best score
addi $23, $0, 0 #Reset counter for best scores
j best2

best2:
addi $23, $23, 1 #Number of best scores
j finish

finish:
addi $22, $22, 4 #Shift address of array by 4
beq $22, 0x205c, exit #20th number in array
j setup

exit:
sw $23, 0x2008 #Store number of best scores
