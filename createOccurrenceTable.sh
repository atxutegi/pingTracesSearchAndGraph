#!/bin/bash
days="2016-10-02 2016-10-03 2016-10-04 2016-10-05 2016-10-06 2016-10-07 2016-10-08 2016-10-09 2016-10-10"
echo "$days"
num_operators=13
echo "Orange.Telia.TelenorS.YOIGO.WIND.3\sSE.voda\sES.voda\sIT.TIM.NetCom.Telenor,.460\s99.Telenor\sSE," > operators
echo "Orange.Telia.TelenorS.YOIGO.WIND.3\\\sSE.voda\\\sES.voda\\\sIT.TIM.NetCom.Telenor,.460\\\s99.Telenor\\\sSE," > operators2


for (( i=1; i <= $num_operators; ++i ))
do
	name=`cat operators | cut -d. -f $i  | cut -d. -f1`
	name2=`cat operators2 | cut -d. -f $i  | cut -d. -f1`
	echo "$name2"
	uniqNodes=`ls 2016-*/$name2-*.txt | cut -d \/ -f2 | sed 's/.*\-//' | sed 's/\.txt//' | sort | uniq`
	#echo "NodeID $days" > $name"Table.txt"
	echo "$uniqNodes"
	for z in $uniqNodes;do
	echo -n "$z " >> table-"$name.txt"
		for j in $days;do
		echo "$j/$name'-'$z.txt"
			if [ ! -e "$j/$name""-$z.txt" ]
			then
    				echo -n "0 " >> table-"$name.txt"
			else
				echo -n "1 " >> table-"$name.txt"
			fi
		done
	echo \ >> table-"$name.txt"			
	done 	
done

