#!/bin/bash

mkdir -p pingOperatorTraces
num_operators=13
echo "Orange.Telia.TelenorS.YOIGO.WIND.3\sSE.voda\sES.voda\sIT.TIM.NetCom.Telenor,.460\s99.Telenor\sSE," > operators
for (( i=1; i <= $num_operators; ++i ))
do
    #name=`cat $operators | cut -d. -f $i | cut -d: -f2 | cut -d, -f4 | sed 1d |sed 's/\./,/'`
    name=`cat operators | cut -d. -f $i  | cut -d. -f1`
    echo "$i"
    echo "$name" >> outputPING.txt
    #cat *_ping.csv | grep $name | cut -d, -f1 | uniq | sed 1d >>  outputPING.txt
    nodes=`cat *_ping.csv | grep $name | cut -d, -f1 | uniq`
    echo "$nodes" >> outputPING.txt
    numNodes=`echo "$nodes" | wc -l`
    echo "num of nodes $numNodes"
    for (( j=1; j <= $numNodes; ++j ))
    do
	selectedNode=`echo "$nodes" | head -$j | tail -1`
	echo "$selectedNode"
    	cat *_ping.csv | grep $name | grep ^$selectedNode, | cut -d, -f1,3,11 | sed 's/\,/\t/g' > pingOperatorTraces/$name"-"$selectedNode.txt
    done
done
mv outputPING.txt pingOperatorTraces/
