operators={'Orange';'Telia';'YOIGO';'NetCom';'TelenorS';'Telenor';'3\sSE';'Telenor\sSE';'TIM';'WIND';'voda\sES';'voda\sIT'};
operators2={'Orange';'Telia';'YOIGO';'NetCom';'TelenorS';'Telenor';'3 SE';'Telenor SE';'TIM';'WIND';'voda ES';'voda IT'};
pos30 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
position1=[1 5 9];
position2=[4 8 12];
names={'PingBoxplot1';'PingBoxplot2';'PingBoxplot3'};
for round=1:size(names,1)
    hand=figure('units','normalized','outerposition',[0 0 1 1]);
    for j=position1(1,round):position2(1,round) %size(operators,1)
        subplot(2,2,j-4*(round-1))
        set(0,'defaulttextinterpreter','latex')
        files=dir(strcat('pingOperatorTraces/',operators{j,1},'*'));
        hold all;
        %mpdc = distinguishable_colors(length(files));
        cc=jet(length(files));
        set(0,'defaulttextinterpreter','latex')
        array(86400,size(files,1))=0;
        counter=1;
        for i=1:size(files,1)
            traceBase(86400,1)=0;
            trace=dlmread(strcat('pingOperatorTraces/',files(i,1).name));
            token = strtok(files(i,1).name, '.');
            token2 = strsplit(token, '-');
            nodeID=token2{1,2};
            nodes{i,1}=nodeID;
            %plot (trace(:,2)-trace(1,2),trace(:,3),'.','Color',cc (i,:) ,'DisplayName', strcat('Node ',nodeID));
            var = strcat('v',num2str(counter));
            traceBase(1:size(trace(:,3)),1)=trace(:,3);
            where_zeros = find(traceBase == 0);
            traceBase(where_zeros,1) = NaN;
            variable.(var)=traceBase(:,1);
            array(:,i)=traceBase(:,1);
            counter=counter+1;
        end
        boxplot(array, 'positions', pos30(1,1:i),'PlotStyle', 'traditional', 'OutlierSize', 2, 'Color', cc(1:i,:))
        if(i>15)
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