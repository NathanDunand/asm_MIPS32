.data
tab : .word 15: 11
aux : .word 0

.text
la $a0,tab	#$a0 contient l'adresse du début du tableau
la $a1,aux	#$a1 contient l'adresse JUSTE APRES la fin du tableau
addi $a1,$a1,-4	#on enlève une case mémoire à $a1 pour bien avoir la dernière case du tableau


# votre programme :
main :#fonction main
jal moy#appel de moy
li $v0, 10
syscall #fin du main

sum : #nom de la fonction
#on ne touche pas à la pile, dernière fonction apellée
addi $a3,$zero,-1 #init de $a3 pas à 0 sinon ça ne fera pas un tour de boucle
add $a2,$zero,$zero # init de $a2
add $a1,$a1,4 # on ajoute 4 à $a1 pour pouvoir additionner aussi la dernière case, sinon la dernière case ne sera pas prise en compte
loop:bgtz $a3,fin # si $a3>0, si on se trouve à la dernière case du tableau
    add $a2,$a2,$t2 #on somme $a2 avec $t2 qui contient l'entier de la case courante
    lw $t2,0($a0) #on met dans $t2 l'entier de la case du tableau
    addi $a0,$a0,4 #incrémentation de la case du tableau
    sub $a3,$a0,$a1 # un moment $a3 contiendra 0 -> moment d'arrêt
    j loop
fin : add $v0,$a2,$zero #on stocke la somme dans $v0
jr $ra # return $v0

moy :#nom de la fonction
sw $ra,0($sp)# empile
sub $sp,$sp,4 # on empile
jal sum #appel de la fonction sum
div $v1,$v0,11

lw $ra,4($sp)#on dépile
add $sp,$sp,4 #on dépile
jr $ra #return