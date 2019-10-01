.data
P: .word 11
R: .word -1

#(6^P)%17=R

.text
lw $8, 0x2000 #$8=P
addi $9, $0, 6 #$9=6
addi $10, $0, 1 #Temp=1 for ^
addi $13, $0, 1 #Temp=1 for %
addi $14, $0, 17 #%17

mul: 
beq $8, $10, div #Finished when (number of loops)=P
sll $11, $9, 2 #6=(1*2^2)+(1*2^1)+(0*2^0)
sll $12, $9, 1
add $9, $11, $12
addi $10, $10, 1 #Counter for number of multiplications
j mul

div:
sub $15, $9, $14 #Subtract 17 from value of $9
slt $13, $0, $15 #Check for negative
beq $13, $0, store
add $9, $0, $15 #New number to subtract from
j div

store:
sw  $9, 0x2004 #Store remainder





