operators={'Orange';'Telia';'YOIGO';'NetCom';'TelenorS';'Telenor,';'3\sSE';'Telenor\sSE,';'TIM';'WIND';'voda\sES';'voda\sIT'};
operators2={'Orange';'Telia';'YOIGO';'NetCom';'TelenorS';'Telenor';'3 SE';'Telenor SE';'TIM';'WIND';'voda ES';'voda IT'};
pos50 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50];
position1=[1 5 9];
position2=[4 8 12];
days={'2016-10-02';'2016-10-03';'2016-10-04';'2016-10-05';'2016-10-06';'2016-10-07';'2016-10-08';'2016-10-09';'2016-10-10'};
maxSize=86400*size(days,1);
names={'PingBoxplot1_multipleDays';'PingBoxplot2_multipleDays';'PingBoxplot3_multipleDays'};
for round=1:size(names,1)
    hand=figure('units','normalized','outerposition',[0 0 1 1]);
    for j=position1(1,round):position2(1,round)
        subplot(2,2,j-4*(round-1))
        set(0,'defaulttextinterpreter','latex')
        %files=dir(strcat('pingTraces/',operators{j,1},'*'));
        tableFile=dlmread(strcat('pingTraces/table-', operators{j,1}, '.txt'));
        hold all;
        cc=jet(size (tableFile(:,1),1));
        set(0,'defaulttextinterpreter','latex');
        array(maxSize,size (tableFile(:,1),1))=0;
        counter=1;
        
        for i=1:size(tableFile(:,1),1)
            traceBase(maxSize,1)=0;
            nodes{i,1}=tableFile(i,1);
            counter2=1;
            for q=1:size(days,1)
                if (tableFile(i,q+1)==0)
                    traceBase(counter2:counter2+86399,1)=NaN;
                else
                    trace=dlmread(strcat('pingTraces/', days{q},'/',operators{j,1},'-',int2str(nodes{i,1}),'.txt'));
                    traceBase(counter2:counter2+size(trace(:,3))-1,1)=trace(:,3);
                end
                counter2=counter2+86400;
            end
            where_zeros = find(traceBase == 0);
            traceBase(where_zeros,1) = NaN;          
            var = strcat('v',num2str(counter));
            variable.(var)=traceBase(:,1);
            array(:,i)=traceBase(:,1);
            counter=counter+1;
        end
        
        boxplot(array, 'positions', pos50(1,1:i),'PlotStyle', 'traditional', 'OutlierSize', 2, 'Color', cc(1:i,:))
        if(i>10)
            set(gca,'xticklabel',{nodes{1:i,1}},'FontSize',6)
        else
            set(gca,'xticklabel',{nodes{1:i,1}},'FontSize',12)
        end
        %set(gca, 'YLim', [0, get(gca, 'YLim')]);
        ylim ([0 Inf])
        xlabel('Node ID','Interpreter', 'latex','FontSize',16)
        ylabel('RTT (ms)','Interpreter', 'latex','FontSize',16)
        title(operators2{j,1},'Interpreter', 'latex','FontSize',20)
        %legend('show')
        %legend('Location','eastoutside')
        clear array trace traceBase toke token2 nodes
    end
    saveFigure(hand, names{round,1})
    close all
end