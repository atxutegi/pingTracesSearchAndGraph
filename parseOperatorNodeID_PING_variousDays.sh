#!/bin/bash

route="pingTraces"
#days="2016-10-02 2016-10-03 2016-10-04 2016-10-05 2016-10-06 2016-10-07 2016-10-08 2016-10-09 2016-10-10 "
# Execute bash parseOperatorNodeID_PING_variousDays.sh "2016-10-11;2016-10-12" (notice semicolon)
days=`echo "$1" | sed 's/\;/ /'`

num_operators=13
echo "Orange.Telia.TelenorS.YOIGO.WIND.3\sSE.voda\sES.voda\sIT.TIM.NetCom.Telenor,.460\s99.Telenor\sSE," > operators

for z in $days
do
	mkdir -p $route"/"$z
	storePath=$route"/"$z
	for (( i=1; i <= $num_operators; ++i ))
	do
    		name=`cat operators | cut -d. -f $i  | cut -d. -f1`
    		echo "$i"
    		echo "$name" >> outputPING.txt
    		nodes=`cat $route/$z*_ping.csv | grep $name | cut -d, -f1 | uniq | sed 1d`
    		echo "$nodes" >> outputPING.txt
    		numNodes=`echo "$nodes" | wc -l`
    		echo "num of nodes $numNodes"
    		for (( j=1; j <= $numNodes; ++j ))
    		do
			selectedNode=`echo "$nodes" | head -$j | tail -1`
			echo "$selectedNode"
    			cat $route/$z*_ping.csv | grep $name | grep ^$selectedNode, | cut -d, -f1,3,11 | sed 's/\,/\t/g' > $storePath"/"$name"-"$selectedNode.txt
    		done
	done
	mv outputPING.txt $storePath"/"
done
